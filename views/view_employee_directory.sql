-- employee_directory
CREATE VIEW employee_directory AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.email,
    e.phone,
    e.position,
    e.salary,
    b.branch_name,
    b.city,
    b.state
FROM employees e
JOIN branches b ON e.branch_id = b.branch_id;
