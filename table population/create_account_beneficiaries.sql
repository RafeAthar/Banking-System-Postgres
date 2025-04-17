-- Account Beneficiaries
CREATE TABLE account_beneficiaries (
    beneficiary_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES accounts(account_id) ON DELETE CASCADE,
    beneficiary_name VARCHAR(150) NOT NULL,
    relationship VARCHAR(50),
    contact_info VARCHAR(150),
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);