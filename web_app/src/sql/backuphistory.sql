SELECT
    DB.name AS [database],
    CASE
        WHEN BK.[type] = 'D' THEN 'FULL'
        WHEN BK.[type] = 'I' THEN 'DIFF'
        WHEN BK.[type] = 'L' THEN 'LOG'
        WHEN BK.[type] = 'F' THEN 'FILEGROUP'
        WHEN BK.[type] = 'G' THEN 'DIFFERENTIAL - FILE'
        WHEN BK.[type] = 'P' THEN 'PARTIAL'
        WHEN BK.[type] = 'Q' THEN 'DIFFERENTIAL PARTIAL'
    END AS [backup_type],
    MAX(BK.backup_start_date) AS [last_backup]
FROM master..sysdatabases AS DB
LEFT JOIN msdb..backupset AS BK ON DB.name = BK.database_name
LEFT JOIN msdb..backupmediafamily AS MD ON BK.media_set_id = MD.media_set_id
GROUP BY DB.name, BK.[type]
ORDER BY MAX(BK.backup_start_date) DESC, DB.name;