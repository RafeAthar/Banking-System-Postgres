-- customer_account_summary
CREATE VIEW customer_account_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.account_id,
    a.account_type,
    a.balance,
    b.branch_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN branches b ON a.branch_id = b.branch_id;