-- Audit Log
CREATE TABLE audit_log (
    log_id SERIAL PRIMARY KEY,
    action_type VARCHAR(50) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    record_id INT,
    performed_by INT REFERENCES employees(employee_id),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);
