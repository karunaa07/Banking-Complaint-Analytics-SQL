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
