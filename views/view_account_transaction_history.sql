-- account_transaction_history
CREATE VIEW account_transaction_history AS
SELECT
    t.transaction_id,
    t.transaction_date,
    t.transaction_type,
    t.amount,
    t.description,
    a.account_id,
    a.account_type,
    a.balance AS current_balance,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    b.branch_name
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
JOIN branches b ON a.branch_id = b.branch_id;