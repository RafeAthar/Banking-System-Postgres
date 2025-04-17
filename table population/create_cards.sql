-- Cards
CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES accounts(account_id) ON DELETE CASCADE,
    card_number CHAR(16) UNIQUE NOT NULL,
    card_type VARCHAR(10) CHECK (card_type IN ('debit', 'credit')),
    cvv CHAR(3) NOT NULL,
    expiry_date DATE NOT NULL,
    issued_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'blocked', 'expired'))
);