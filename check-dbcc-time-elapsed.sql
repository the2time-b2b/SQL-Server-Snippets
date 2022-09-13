SELECT a.session_id,
	command,
	b.TEXT,
	percent_complete,
	done_in_minutes = a.estimated_completion_time / 1000 / 60,
	min_in_progress = DATEDIFF(MI, a.start_time, DATEADD(ms, a.estimated_completion_time, GETDATE())),
	a.start_time,
	estimated_completion_time = DATEADD(ms, a.estimated_completion_time, GETDATE())
FROM sys.dm_exec_requests a
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) b
WHERE command LIKE '%dbcc%'