SELECT max(now() - xact_start) FROM pg_stat_activity
                               WHERE state IN ('idle in transaction', 'active');