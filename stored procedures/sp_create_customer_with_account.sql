-- 1. Create a new customer with account
CREATE OR REPLACE PROCEDURE create_customer_with_account(
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    email VARCHAR(150),
    phone VARCHAR(15),
    address TEXT,
    branch_id INT,
    account_type VARCHAR(20),
    initial_deposit NUMERIC(15, 2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    new_customer_id INT;
    new_account_id INT;
BEGIN
    -- Insert customer
    INSERT INTO customers (first_name, last_name, date_of_birth, gender, email, phone, address)
    VALUES (first_name, last_name, dob, gender, email, phone, address)
    RETURNING customer_id INTO new_customer_id;
    
    -- Create account for customer
    INSERT INTO accounts (customer_id, branch_id, account_type, balance, opened_date)
    VALUES (new_customer_id, branch_id, account_type, initial_deposit, CURRENT_DATE)
    RETURNING account_id INTO new_account_id;
    
    -- Log initial deposit if greater than zero
    IF initial_deposit > 0 THEN
        INSERT INTO transactions (account_id, transaction_type, amount, description)
        VALUES (new_account_id, 'deposit', initial_deposit, 'Initial deposit');
    END IF;
    
    COMMIT;
END;
$$;