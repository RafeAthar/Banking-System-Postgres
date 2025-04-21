-- Audit Log
INSERT INTO audit_log (action_type, table_name, record_id, performed_by, details)
VALUES
('INSERT', 'accounts', 1, 2, 'Created savings account for John Doe'),
('UPDATE', 'transactions', 6, 3, 'Jane Doe transferred $300 to John Doe'),
('INSERT', 'cards', 1, 2, 'Issued debit card to John Doe');
