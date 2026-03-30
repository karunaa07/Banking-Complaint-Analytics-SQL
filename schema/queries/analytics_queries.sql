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

