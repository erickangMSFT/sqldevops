SELECT
    table_schema || '.' || table_name AS table_full_name,
    pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') AS size
FROM information_schema.tables
where pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') > 0
ORDER BY
    pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') DESC
LIMIT 10