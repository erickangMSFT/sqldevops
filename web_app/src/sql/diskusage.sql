--source: https://dba.stackexchange.com/questions/29543/query-to-report-disk-space-allocation-and-used-space

SELECT
(SELECT SUM(CAST(df.size as float)) FROM sys.database_files AS df 
   WHERE df.type in ( 0, 2, 4 ) ) AS [DbSize],
SUM(a.total_pages) AS [SpaceUsed],
(SELECT SUM(CAST(df.size as float)) FROM sys.database_files AS df 
   WHERE df.type in (1, 3)) AS [LogSize]
FROM
sys.partitions p join sys.allocation_units a 
  on p.partition_id = a.container_id 
left join sys.internal_tables it 
  on p.object_id = it.object_id

--source: https://dba.stackexchange.com/questions/29543/query-to-report-disk-space-allocation-and-used-space
;WITH t(s) AS
(
  SELECT CONVERT(DECIMAL(18,2), SUM(size)*8/1024.0)
   FROM sys.database_files
   WHERE [type] % 2 = 0
), 
d(s) AS
(
  SELECT CONVERT(DECIMAL(18,2), SUM(total_pages)*8/1024.0)
   FROM sys.partitions AS p
   INNER JOIN sys.allocation_units AS a 
   ON p.[partition_id] = a.container_id
)
SELECT 
  Allocated_Space = t.s,
  Used_Space = d.s, 
  Available_Space = t.s - d.s,
  [Available_%] = CONVERT(DECIMAL(5,2), (t.s - d.s)*100.0/t.s)
FROM t CROSS APPLY d;