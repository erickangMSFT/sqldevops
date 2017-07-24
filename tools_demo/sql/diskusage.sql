WITH t(s) AS
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
  Used_Space = d.s, 
  Available_Space = t.s - d.s
 FROM t CROSS APPLY d;