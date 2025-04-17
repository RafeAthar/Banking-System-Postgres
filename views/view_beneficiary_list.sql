-- beneficiary_list
CREATE VIEW beneficiary_list AS
SELECT
    ab.beneficiary_id,
    ab.account_id,
    ab.beneficiary_name,
    ab.relationship,
    ab.contact_info,
    CONCAT(c.first_name, ' ', c.last_name) AS account_holder_name
FROM account_beneficiaries ab
JOIN accounts a ON ab.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id;