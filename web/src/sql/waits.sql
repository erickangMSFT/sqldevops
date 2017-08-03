--From: https://blog.sqlauthority.com/2011/02/04/sql-server-dmv-sys-dm_os_waiting_tasks-and-sys-dm_exec_requests-wait-type-day-4-of-28/

SELECT dm_ws.wait_duration_ms,
dm_ws.wait_type,
dm_es.status,
dm_t.TEXT,
dm_qp.query_plan,
dm_ws.session_ID,
dm_es.cpu_time,
dm_es.memory_usage,
dm_es.logical_reads,
dm_es.total_elapsed_time,
dm_es.program_name,
DB_NAME(dm_r.database_id) DatabaseName,
-- Optional columns
dm_ws.blocking_session_id,
dm_r.wait_resource,
dm_es.login_name,
dm_r.command,
dm_r.last_wait_type
FROM sys.dm_os_waiting_tasks dm_ws
INNER JOIN sys.dm_exec_requests dm_r ON dm_ws.session_id = dm_r.session_id
INNER JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_r.session_id
CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t
CROSS APPLY sys.dm_exec_query_plan (dm_r.plan_handle) dm_qp
WHERE dm_es.is_user_process = 1
GO