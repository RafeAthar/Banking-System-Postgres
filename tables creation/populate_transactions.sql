-- Transactions
INSERT INTO transactions (account_id, transaction_type, amount, description, related_account_id)
VALUES
(1, 'deposit', 1000.00, 'Initial deposit', NULL),
(1, 'withdrawal', 200.00, 'ATM withdrawal', NULL),
(2, 'deposit', 500.00, 'Salary deposit', NULL),
(3, 'deposit', 7000.00, 'Business funds', NULL),
(4, 'withdrawal', 1000.00, 'Office expense', NULL),
(2, 'transfer', 300.00, 'Sent to John', 1),
(1, 'transfer', 300.00, 'Received from Jane', 2),
(5, 'deposit', 1500.00, 'New checking account', NULL),
(5, 'withdrawal', 200.00, 'Grocery', NULL),
(3, 'deposit', 500.00, 'Monthly top-up', NULL);
