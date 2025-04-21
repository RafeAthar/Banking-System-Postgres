-- Accounts
INSERT INTO accounts (customer_id, branch_id, account_type, balance)
VALUES
(1, 1, 'savings', 5000.00),
(2, 1, 'checking', 2500.00),
(3, 2, 'savings', 10000.00),
(4, 3, 'business', 20000.00),
(1, 1, 'checking', 1500.00); -- John has two accounts
