SELECT TOP(10)
SCH.name as schema_name, 
concat(TABL.name,':', INDX.name) AS table_name, 
--INDX.name AS index_name,
SUM(PART.rows) AS row_count,
(SUM(ALOC.used_pages)*8/1024) AS used_space_MB, 
(SUM(ALOC.total_pages)*8/1024) AS total_space_MB, 
(SUM(ALOC.data_pages)*8/1024) AS data_space_MB,
SUM(ALOC.total_pages) AS total_pages, 
SUM(ALOC.used_pages) AS used_pages, 
SUM(ALOC.data_pages) AS data_pages
FROM sys.Tables AS TABL 
INNER JOIN sys.Indexes AS INDX 
ON TABL.object_id = INDX.object_id 
INNER JOIN sys.Partitions AS PART 
ON INDX.object_id = PART.object_id AND INDX.index_id = PART.index_id 
INNER JOIN sys.Allocation_Units AS ALOC ON PART.partition_id = ALOC.container_id 
INNER JOIN sys.schemas as SCH on tabl.schema_id = sch.schema_id
GROUP BY SCH.name, TABL.name,
			INDX.object_id,
			INDX.index_id,
			INDX.name
ORDER BY (SUM(ALOC.total_pages)*8/1024) desc