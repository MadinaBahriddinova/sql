USE lesson14;  
GO

DECLARE @tableHTML NVARCHAR(MAX);

SET @tableHTML = 
N'<html>
<head>
<style>
    table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; }
    th, td { border: 1px solid #dddddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
<h3>SQL Server Index Metadata Report</h3>
<table>
<tr>
    <th>Table Name</th>
    <th>Index Name</th>
    <th>Index Type</th>
    <th>Column Type</th>
    <th>Column Name</th>
    <th>Data Type</th>
</tr>';

SET @tableHTML += CAST((
    SELECT 
        td = t.name, '',
        td = i.name, '',
        td = i.type_desc, '',
        td = CASE WHEN ic.is_included_column = 1 THEN 'Included' ELSE 'Key' END, '',
        td = c.name, '',
        td = ty.name
    FROM 
        sys.indexes i
    INNER JOIN 
        sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    INNER JOIN 
        sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    INNER JOIN 
        sys.tables t ON i.object_id = t.object_id
    INNER JOIN 
        sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE 
        i.is_hypothetical = 0
    ORDER BY t.name, i.name, c.column_id
    FOR XML PATH('tr'), TYPE
) AS NVARCHAR(MAX));

SET @tableHTML += N'</table></body></html>';

-- Step 5: Send the email
exec msdb.dbo.sp_send_dbmail
	@profile_name = 'GmailProfile',
	@recipients = 'azatovhikmatyor@outlook.com;dilmurodovsohibjon@gmail.com',
	@subject = 'This is test from sql server',
	@body = '
		<style>
			#customers {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}

			#customers td, #customers th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}

			#customers tr:nth-child(even){background-color: #f2f2f2;}

			#customers tr:hover {background-color: #ddd;}

			#customers th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: #04AA6D;
			  color: white;
			}
			</style>
			</head>
			<body>

			<h1>A Fancy Table</h1>

			<table id="customers">
			  <tr>
				<th>Company</th>
				<th>Contact</th>
				<th>Country</th>
			  </tr>
			  <tr>
				<td>Alfreds Futterkiste</td>
				<td>Maria Anders</td>
				<td>Germany</td>
			  </tr>
			  <tr>
				<td>Berglunds snabbk�p</td>
				<td>Christina Berglund</td>
				<td>Sweden</td>
			  </tr>
			  <tr>
				<td>Centro comercial Moctezuma</td>
				<td>Francisco Chang</td>
				<td>Mexico</td>
			  </tr>
			  <tr>
				<td>Ernst Handel</td>
				<td>Roland Mendel</td>
				<td>Austria</td>
			  </tr>
			  <tr>
				<td>Island Trading</td>
				<td>Helen Bennett</td>
				<td>UK</td>
			  </tr>
			  <tr>
				<td>K�niglich Essen</td>
				<td>Philip Cramer</td>
				<td>Germany</td>
			  </tr>
			  <tr>
				<td>Laughing Bacchus Winecellars</td>
				<td>Yoshi Tannamuri</td>
				<td>Canada</td>
			  </tr>
			  <tr>
				<td>Magazzini Alimentari Riuniti</td>
				<td>Giovanni Rovelli</td>
				<td>Italy</td>
			  </tr>
			  <tr>
				<td>North/South</td>
				<td>Simon Crowther</td>
				<td>UK</td>
			  </tr>
			  <tr>
				<td>Paris sp�cialit�s</td>
				<td>Marie Bertrand</td>
				<td>France</td>
			  </tr>
			</table>

			</body>
	',
	@body_format = 'HTML'
