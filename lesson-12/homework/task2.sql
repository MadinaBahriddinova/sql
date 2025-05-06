CREATE PROCEDURE usp_ListProceduresWithParams
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @sql = '
        USE [' + QUOTENAME(@DatabaseName) + '];
        SELECT 
            DB_NAME() AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM sys.objects o
        JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'', ''FS'', ''FT'');'
        EXEC sp_executesql @sql;
    END
    ELSE
    BEGIN
        DECLARE @name SYSNAME;
        DECLARE db_cursor CURSOR FOR
        SELECT name FROM sys.databases
        WHERE state = 0 AND name NOT IN ('master', 'tempdb', 'model', 'msdb');

        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @name;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @sql = '
            USE [' + QUOTENAME(@name) + '];
            SELECT 
                ''' + @name + ''' AS DatabaseName,
                s.name AS SchemaName,
                o.name AS ObjectName,
                o.type_desc AS ObjectType,
                p.name AS ParameterName,
                t.name AS DataType,
                p.max_length AS MaxLength
            FROM sys.objects o
            JOIN sys.schemas s ON o.schema_id = s.schema_id
            LEFT JOIN sys.parameters p ON o.object_id = p.object_id
            LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
            WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'', ''FS'', ''FT'');'
            
            EXEC sp_executesql @sql;

            FETCH NEXT FROM db_cursor INTO @name;
        END

        CLOSE db_cursor;
        DEALLOCATE db_cursor;
    END
END;
