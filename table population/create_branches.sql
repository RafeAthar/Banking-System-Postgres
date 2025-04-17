-- Branches
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(15),
    manager_id INT, -- FK to employees (will be added later)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Alter Branches Table
ALTER TABLE branches
ADD CONSTRAINT fk_branch_manager
FOREIGN KEY (manager_id) REFERENCES employees(employee_id);