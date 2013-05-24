SELECT
    sysobjects.Name
    , sysindexes.Rows
FROM
    sysobjects
    INNER JOIN sysindexes
    ON sysobjects.id = sysindexes.id
WHERE
    type = 'U'
    AND sysindexes.IndId < 2
ORDER BY
    sysobjects.Namecode
