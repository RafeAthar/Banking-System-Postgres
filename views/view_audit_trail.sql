-- audit_trail
CREATE VIEW audit_trail AS
SELECT 
    al.log_id,
    al.action_timestamp,
    al.action_type,
    al.table_name,
    al.record_id,
    al.details,
    CONCAT(e.first_name, ' ', e.last_name) AS performed_by
FROM audit_log al
LEFT JOIN employees e ON al.performed_by = e.employee_id;
