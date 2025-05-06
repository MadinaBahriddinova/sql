DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += '
USE [' + name + '];
SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

-- Execute the dynamic SQL
EXEC sp_executesql @sql;
