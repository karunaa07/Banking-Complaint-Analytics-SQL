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
