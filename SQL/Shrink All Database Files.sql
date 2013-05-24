CREATE TABLE #CommandQueue
(
    ID INT IDENTITY ( 1, 1 )
    , SqlStatement VARCHAR(1000)
)

INSERT INTO    #CommandQueue
(
    SqlStatement
)
SELECT
    'USE [' + A.name + '] DBCC SHRINKFILE (N''' + B.name + ''' , 1)'
FROM
    sys.databases A
    INNER JOIN sys.master_files B
    ON A.database_id = B.database_id
WHERE
    A.name NOT IN ( 'master', 'model', 'msdb', 'tempdb' )

DECLARE @id INT

SELECT @id = MIN(ID)
FROM #CommandQueue

WHILE @id IS NOT NULL
BEGIN
    DECLARE @sqlStatement VARCHAR(1000)
    
    SELECT
        @sqlStatement = SqlStatement
    FROM
        #CommandQueue
    WHERE
        ID = @id

    PRINT 'Executing ''' + @sqlStatement + '''...'

    EXEC (@sqlStatement)

    DELETE FROM #CommandQueue
    WHERE ID = @id

    SELECT @id = MIN(ID)
    FROM #CommandQueue
END