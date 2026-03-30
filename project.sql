create database project;
use project;

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

INSERT INTO banks (bank_name, bank_type, headquarters) VALUES
('HDFC Bank','Private','Mumbai'),
('ICICI Bank','Private','Mumbai'),
('State Bank of India','Public','Mumbai'),
('Axis Bank','Private','Mumbai'),
('Kotak Mahindra Bank','Private','Mumbai'),
('Punjab National Bank','Public','Delhi'),
('Bank of Baroda','Public','Vadodara'),
('Canara Bank','Public','Bangalore'),
('Union Bank of India','Public','Mumbai'),
('IndusInd Bank','Private','Mumbai');

SELECT * FROM banks;

INSERT INTO complaint_categories (category_name) VALUES
('ATM Issue'),
('Credit Card Fraud'),
('Loan Processing Delay'),
('Net Banking Issue'),
('Unauthorized Charges'),
('Account Blocked'),
('KYC Problem'),
('UPI Transaction Failure');

SELECT * FROM complaint_categories;

INSERT INTO complaint_priority (priority_level) VALUES
('Low'),
('Medium'),
('High'),
('Critical');

INSERT INTO complaint_status (status_name) VALUES
('Open'),
('Assigned'),
('In Progress'),
('Resolved'),
('Closed');

INSERT INTO customers (name,email,phone) VALUES
('Rahul Sharma','rahul@gmail.com','9876543210'),
('Priya Patel','priya@gmail.com','9876543211'),
('Amit Singh','amit@gmail.com','9876543212'),
('Neha Gupta','neha@gmail.com','9876543213'),
('Rohit Verma','rohit@gmail.com','9876543214');

SELECT * FROM customers;

INSERT INTO bank_branches (bank_id, branch_name, city) VALUES
(1,'HDFC Mumbai Main','Mumbai'),
(1,'HDFC Pune Branch','Pune'),
(2,'ICICI Delhi Branch','Delhi'),
(3,'SBI Bangalore Branch','Bangalore'),
(4,'Axis Hyderabad Branch','Hyderabad'),
(5,'Kotak Chennai Branch','Chennai');

INSERT INTO complaints 
(customer_id,bank_id,category_id,priority_id,status_id,complaint_date,description)
VALUES
(1,1,1,2,1,'2024-01-05','ATM did not dispense cash'),
(2,2,2,4,2,'2024-01-06','Credit card fraud transaction'),
(3,3,3,3,3,'2024-01-07','Loan approval taking too long'),
(4,1,4,2,1,'2024-01-10','Net banking login failure'),
(5,4,5,2,2,'2024-01-11','Wrong service charge deducted');

SELECT * FROM complaints;

SELECT b.bank_name, COUNT(c.complaint_id) AS total_complaints
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
GROUP BY b.bank_name
ORDER BY total_complaints DESC;

SELECT MONTH(complaint_date) AS month,
COUNT(*) AS total_complaints
FROM complaints
GROUP BY MONTH(complaint_date)
ORDER BY month;

SELECT cc.category_name,
COUNT(*) AS total
FROM complaints c
JOIN complaint_categories cc 
ON c.category_id = cc.category_id
GROUP BY cc.category_name
ORDER BY total DESC;

SELECT c.complaint_id,
cp.priority_level,
b.bank_name
FROM complaints c
JOIN complaint_priority cp 
ON c.priority_id = cp.priority_id
JOIN banks b 
ON c.bank_id = b.bank_id
WHERE cp.priority_level = 'Critical';

SELECT customer_id,
COUNT(*) AS complaint_count
FROM complaints
GROUP BY customer_id
ORDER BY complaint_count DESC;

SELECT b.bank_name,
COUNT(c.complaint_id) AS total_complaints,
RANK() OVER (ORDER BY COUNT(c.complaint_id) DESC) AS rank_position
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
GROUP BY b.bank_name;

SELECT cs.status_name,
COUNT(*) AS total
FROM complaints c
JOIN complaint_status cs
ON c.status_id = cs.status_id
GROUP BY cs.status_name;

SELECT b.bank_name,
cc.category_name,
COUNT(*) total
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
JOIN complaint_categories cc 
ON c.category_id = cc.category_id
GROUP BY b.bank_name, cc.category_name
ORDER BY total DESC;

SELECT cu.name,
cu.email,
c.complaint_id,
c.description
FROM complaints c
JOIN customers cu
ON c.customer_id = cu.customer_id;

SELECT *
FROM complaints
WHERE complaint_date >= CURDATE() - INTERVAL 30 DAY;

DELIMITER //

CREATE PROCEDURE GetBankComplaints(IN bankName VARCHAR(100))
BEGIN
SELECT c.complaint_id,
b.bank_name,
cu.name AS customer_name,
cc.category_name,
cs.status_name,
c.complaint_date
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
JOIN customers cu ON c.customer_id = cu.customer_id
JOIN complaint_categories cc ON c.category_id = cc.category_id
JOIN complaint_status cs ON c.status_id = cs.status_id
WHERE b.bank_name = bankName;
END //

DELIMITER ;

CALL GetBankComplaints('HDFC Bank');

DELIMITER //

CREATE PROCEDURE BankComplaintSummary()
BEGIN
SELECT b.bank_name,
COUNT(c.complaint_id) AS total_complaints
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
GROUP BY b.bank_name
ORDER BY total_complaints DESC;
END //

DELIMITER ;

CALL BankComplaintSummary();

DELIMITER //
CREATE PROCEDURE AddComplaint(
IN p_customer_id INT,
IN p_bank_id INT,
IN p_category_id INT,
IN p_priority_id INT,
IN p_description TEXT
)
BEGIN
INSERT INTO complaints(
customer_id,
bank_id,
category_id,
priority_id,
status_id,
complaint_date,
description
)
VALUES(
p_customer_id,
p_bank_id,
p_category_id,
p_priority_id,
1,
CURDATE(),
p_description
);
END //
DELIMITER ;

CALL AddComplaint(1,2,1,3,'ATM cash not dispensed');

DELIMITER //
CREATE PROCEDURE CategoryComplaintReport()
BEGIN
SELECT cc.category_name,
COUNT(c.complaint_id) AS total_complaints
FROM complaints c
JOIN complaint_categories cc
ON c.category_id = cc.category_id
GROUP BY cc.category_name
ORDER BY total_complaints DESC;
END //
DELIMITER ;

CALL CategoryComplaintReport();
CALL GetBankComplaints('ICICI Bank');

CREATE TABLE departments (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(100)
);

INSERT INTO departments (department_name) VALUES
('Customer Support'),
('Fraud Investigation'),
('Loan Department'),
('Technical Support'),
('UPI Operations');

CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
employee_name VARCHAR(100),
department_id INT,
email VARCHAR(100),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees (employee_name, department_id, email) VALUES
('Ankit Sharma',1,'ankit@bank.com'),
('Pooja Mehta',2,'pooja@bank.com'),
('Ravi Kumar',3,'ravi@bank.com'),
('Sneha Patel',4,'sneha@bank.com'),
('Arjun Singh',5,'arjun@bank.com');

CREATE TABLE complaint_assignments (
assignment_id INT AUTO_INCREMENT PRIMARY KEY,
complaint_id INT,
employee_id INT,
assigned_date DATE,
FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id),
FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO complaint_assignments (complaint_id,employee_id,assigned_date)
VALUES
(1,1,'2024-01-05'),
(2,2,'2024-01-06'),
(3,3,'2024-01-07');

CREATE TABLE complaint_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
complaint_id INT,
old_status INT,
new_status INT,
changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id)
);

DELIMITER //
CREATE TRIGGER complaint_status_change
AFTER UPDATE ON complaints
FOR EACH ROW
BEGIN
IF OLD.status_id <> NEW.status_id THEN
INSERT INTO complaint_history(
complaint_id,
old_status,
new_status
)
VALUES(
NEW.complaint_id,
OLD.status_id,
NEW.status_id
);
END IF;
END //
DELIMITER ;

UPDATE complaints
SET status_id = 3
WHERE complaint_id = 1;

SELECT e.employee_name,
COUNT(ca.complaint_id) AS total_assigned
FROM complaint_assignments ca
JOIN employees e 
ON ca.employee_id = e.employee_id
GROUP BY e.employee_name
ORDER BY total_assigned DESC;

SELECT d.department_name,
COUNT(ca.complaint_id) AS total_complaints
FROM complaint_assignments ca
JOIN employees e ON ca.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_complaints DESC;

INSERT INTO complaints
(customer_id, bank_id, category_id, priority_id, status_id, complaint_date, description)
SELECT
FLOOR(1 + RAND()*5),
FLOOR(1 + RAND()*10),
FLOOR(1 + RAND()*8),
FLOOR(1 + RAND()*4),
FLOOR(1 + RAND()*5),
DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
'Customer reported banking issue'
FROM information_schema.tables
LIMIT 10000;

SELECT b.bank_name,
COUNT(*) AS complaints
FROM complaints c
JOIN banks b ON c.bank_id = b.bank_id
GROUP BY b.bank_name
ORDER BY complaints DESC
LIMIT 5;

SELECT YEAR(complaint_date) AS year,
COUNT(*) AS total_complaints
FROM complaints
GROUP BY YEAR(complaint_date);

SELECT cu.name,
COUNT(*) AS complaint_count
FROM complaints c
JOIN customers cu
ON c.customer_id = cu.customer_id
GROUP BY cu.name
ORDER BY complaint_count DESC
LIMIT 10;

SELECT cp.priority_level,
COUNT(*) total
FROM complaints c
JOIN complaint_priority cp
ON c.priority_id = cp.priority_id
GROUP BY cp.priority_level;

SELECT bank_name,
total_complaints,
RANK() OVER (ORDER BY total_complaints DESC) AS rank_position
FROM
(
SELECT b.bank_name,
COUNT(*) total_complaints
FROM complaints c
JOIN banks b ON c.bank_id=b.bank_id
GROUP BY b.bank_name
) t;

