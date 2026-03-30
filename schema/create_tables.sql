CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
phone VARCHAR(15),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE banks (
bank_id INT AUTO_INCREMENT PRIMARY KEY,
bank_name VARCHAR(100),
bank_type VARCHAR(50),
headquarters VARCHAR(100)
);

CREATE TABLE bank_branches (
branch_id INT AUTO_INCREMENT PRIMARY KEY,
bank_id INT,
branch_name VARCHAR(100),
city VARCHAR(50),
FOREIGN KEY (bank_id) REFERENCES banks(bank_id)
);

CREATE TABLE complaint_categories (
category_id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(100)
);

CREATE TABLE complaint_priority (
priority_id INT AUTO_INCREMENT PRIMARY KEY,
priority_level VARCHAR(50)
);

CREATE TABLE complaint_status (
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50)
);

CREATE TABLE complaints (
complaint_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
bank_id INT,
category_id INT,
priority_id INT,
status_id INT,
complaint_date DATE,
description TEXT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (bank_id) REFERENCES banks(bank_id),
FOREIGN KEY (category_id) REFERENCES complaint_categories(category_id),
FOREIGN KEY (priority_id) REFERENCES complaint_priority(priority_id),
FOREIGN KEY (status_id) REFERENCES complaint_status(status_id)
);

CREATE TABLE departments (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(100)
);

CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
employee_name VARCHAR(100),
department_id INT,
email VARCHAR(100),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE complaint_assignments (
assignment_id INT AUTO_INCREMENT PRIMARY KEY,
complaint_id INT,
employee_id INT,
assigned_date DATE,
FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id),
FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE complaint_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
complaint_id INT,
old_status INT,
new_status INT,
changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id)
);

