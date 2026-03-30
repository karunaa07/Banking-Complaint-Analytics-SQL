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

INSERT INTO complaint_categories (category_name) VALUES
('ATM Issue'),
('Credit Card Fraud'),
('Loan Processing Delay'),
('Net Banking Issue'),
('Unauthorized Charges'),
('Account Blocked'),
('KYC Problem'),
('UPI Transaction Failure');

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

INSERT INTO employees (employee_name, department_id, email) VALUES
('Ankit Sharma',1,'ankit@bank.com'),
('Pooja Mehta',2,'pooja@bank.com'),
('Ravi Kumar',3,'ravi@bank.com'),
('Sneha Patel',4,'sneha@bank.com'),
('Arjun Singh',5,'arjun@bank.com');

INSERT INTO complaint_assignments (complaint_id,employee_id,assigned_date)
VALUES
(1,1,'2024-01-05'),
(2,2,'2024-01-06'),
(3,3,'2024-01-07');

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

