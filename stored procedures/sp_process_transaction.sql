-- 2. Process a transaction (deposit, withdrawal, transfer)
CREATE OR REPLACE PROCEDURE process_transaction(
    p_account_id INT,
    p_transaction_type VARCHAR(20),
    p_amount NUMERIC(15, 2),
    p_description TEXT DEFAULT NULL,
    p_related_account_id INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_balance NUMERIC(15, 2);
    target_balance NUMERIC(15, 2);
BEGIN
    -- Check transaction type is valid
    IF p_transaction_type NOT IN ('deposit', 'withdrawal', 'transfer', 'payment') THEN
        RAISE EXCEPTION 'Invalid transaction type: %', p_transaction_type;
    END IF;
    
    -- Get current balance
    SELECT balance INTO current_balance FROM accounts WHERE account_id = p_account_id;
    
    -- Process based on transaction type
    CASE p_transaction_type
        WHEN 'deposit' THEN
            -- Update account balance
            UPDATE accounts 
            SET balance = balance + p_amount 
            WHERE account_id = p_account_id;
            
            -- Record transaction
            INSERT INTO transactions (account_id, transaction_type, amount, description)
            VALUES (p_account_id, 'deposit', p_amount, COALESCE(p_description, 'Deposit'));
            
        WHEN 'withdrawal' THEN
            -- Check sufficient funds
            IF current_balance < p_amount THEN
                RAISE EXCEPTION 'Insufficient funds. Current balance: %', current_balance;
            END IF;
            
            -- Update account balance
            UPDATE accounts 
            SET balance = balance - p_amount 
            WHERE account_id = p_account_id;
            
            -- Record transaction
            INSERT INTO transactions (account_id, transaction_type, amount, description)
            VALUES (p_account_id, 'withdrawal', p_amount, COALESCE(p_description, 'Withdrawal'));
            
        WHEN 'transfer' THEN
            -- Check related account exists
            IF p_related_account_id IS NULL THEN
                RAISE EXCEPTION 'Related account ID is required for transfers';
            END IF;
            
            -- Verify related account exists
            SELECT balance INTO target_balance FROM accounts WHERE account_id = p_related_account_id;
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Target account does not exist';
            END IF;
            
            -- Check sufficient funds
            IF current_balance < p_amount THEN
                RAISE EXCEPTION 'Insufficient funds for transfer. Current balance: %', current_balance;
            END IF;
            
            -- Update source account
            UPDATE accounts 
            SET balance = balance - p_amount 
            WHERE account_id = p_account_id;
            
            -- Update target account
            UPDATE accounts 
            SET balance = balance + p_amount 
            WHERE account_id = p_related_account_id;
            
            -- Record transaction for source account
            INSERT INTO transactions (account_id, transaction_type, amount, related_account_id, description)
            VALUES (p_account_id, 'transfer', p_amount, p_related_account_id, 
                   COALESCE(p_description, 'Transfer to account ' || p_related_account_id));
                   
            -- Record transaction for target account
            INSERT INTO transactions (account_id, transaction_type, amount, related_account_id, description)
            VALUES (p_related_account_id, 'deposit', p_amount, p_account_id, 
                   'Transfer from account ' || p_account_id);
        
        WHEN 'payment' THEN
            -- Check sufficient funds
            IF current_balance < p_amount THEN
                RAISE EXCEPTION 'Insufficient funds for payment. Current balance: %', current_balance;
            END IF;
            
            -- Update account balance
            UPDATE accounts 
            SET balance = balance - p_amount 
            WHERE account_id = p_account_id;
            
            -- Record transaction
            INSERT INTO transactions (account_id, transaction_type, amount, description)
            VALUES (p_account_id, 'payment', p_amount, COALESCE(p_description, 'Payment'));
    END CASE;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
$$;