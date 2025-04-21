-- Accounts
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    branch_id INT NOT NULL REFERENCES branches(branch_id),
    account_type VARCHAR(20) CHECK (account_type IN ('savings', 'current', 'checking', 'business')),
    balance NUMERIC(15, 2) DEFAULT 0.00,
    opened_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);