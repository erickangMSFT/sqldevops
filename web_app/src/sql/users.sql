DECLARE @SQLStatement VARCHAR(4000)
DECLARE @T_DBuser TABLE (DBName SYSNAME, UserName SYSNAME, AssociatedDBRole NVARCHAR(256))
SET @SQLStatement='
SELECT ''?'' AS DBName,dp.name AS UserName,USER_NAME(drm.role_principal_id) AS AssociatedDBRole
FROM ?.sys.database_principals dp
LEFT OUTER JOIN ?.sys.database_role_members drm
ON dp.principal_id=drm.member_principal_id
WHERE dp.sid NOT IN (0x01) AND dp.sid IS NOT NULL AND dp.type NOT IN (''C'')
AND dp.is_fixed_role <> 1 AND dp.name NOT LIKE ''##%'' AND ''?''
NOT IN (''master'',''msdb'',''model'',''tempdb'') ORDER BY DBName'
INSERT @T_DBuser
EXEC sp_MSforeachdb @SQLStatement
SELECT * FROM @T_DBuser ORDER BY DBName