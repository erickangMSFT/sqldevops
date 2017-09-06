--source:https://www.mssqltips.com/sqlservertip/2393/determine-sql-server-memory-use-by-database-and-object/

DECLARE @total_buffer INT;

SELECT @total_buffer = cntr_value
FROM sys.dm_os_performance_counters 
WHERE RTRIM([object_name]) LIKE '%Buffer Manager'
AND counter_name = 'Database Pages';

;WITH src AS
(
SELECT 
database_id, db_buffer_pages = COUNT_BIG(*)
FROM sys.dm_os_buffer_descriptors
--WHERE database_id BETWEEN 5 AND 32766
GROUP BY database_id
)
SELECT
[db_name] = CASE [database_id] WHEN 32767 
THEN 'Resource DB' 
ELSE DB_NAME([database_id]) END,
db_buffer_pages,
db_buffer_MB = db_buffer_pages / 128,
db_buffer_percent = CONVERT(DECIMAL(6,3), 
db_buffer_pages * 100.0 / @total_buffer)
FROM src
ORDER BY db_buffer_MB DESC; 

--source:http://udayarumilli.com/script-to-monitor-sql-server-memory-usage/
-- select
--       total_physical_memory_kb/1024 AS total_physical_memory_mb,
--       available_physical_memory_kb/1024 AS available_physical_memory_mb,
--       total_page_file_kb/1024 AS total_page_file_mb,
--       available_page_file_kb/1024 AS available_page_file_mb,
--       100 - (100 * CAST(available_physical_memory_kb AS DECIMAL(18,3))/CAST(total_physical_memory_kb AS DECIMAL(18,3))) 
--       AS 'Percentage_Used',
--       system_memory_state_desc
-- from  sys.dm_os_sys_memory;