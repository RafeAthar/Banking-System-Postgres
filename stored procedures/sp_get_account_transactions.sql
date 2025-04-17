-- 3. Get account transaction history with pagination
CREATE OR REPLACE FUNCTION get_account_transactions(
    p_account_id INT,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_limit INT DEFAULT 50,
    p_offset INT DEFAULT 0
)
RETURNS TABLE (
    transaction_id INT,
    transaction_type VARCHAR(20),
    amount NUMERIC(15, 2),
    transaction_date TIMESTAMP,
    description TEXT,
    related_account_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, t.description, t.related_account_id
    FROM transactions t
    WHERE t.account_id = p_account_id
    AND (p_start_date IS NULL OR t.transaction_date::DATE >= p_start_date)
    AND (p_end_date IS NULL OR t.transaction_date::DATE <= p_end_date)
    ORDER BY t.transaction_date DESC
    LIMIT p_limit
    OFFSET p_offset;
END;
$$;