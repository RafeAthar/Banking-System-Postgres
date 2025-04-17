-- card_holder_summary
CREATE VIEW card_holder_summary AS
SELECT
    ca.card_id,
    ca.card_number,
    ca.card_type,
    ca.status AS card_status,
    ca.expiry_date,
    a.account_id,
    a.account_type,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    b.branch_name
FROM cards ca
JOIN accounts a ON ca.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
JOIN branches b ON a.branch_id = b.branch_id;
