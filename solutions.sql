/* Q9 */
SELECT customers.customerNumber, customerName, AVG(amount) as averageAmount FROM payments JOIN customers
	ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName

/* Addenum */
/* Find the top ten customers by average spending */
SELECT customers.customerNumber, customerName, AVG(amount) as averageAmount FROM payments JOIN customers
	ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName
HAVING AVG(amount) > 10000
ORDER BY AVG(amount) DESC
LIMIT 10

/* Q10 */
SELECT productCode, COUNT(*) FROM orderdetails
GROUP BY productCode
ORDER BY COUNT(*) DESC
LIMIT 10

/* Q11 */

/* if we want to see from June 2003 to June 2004 */
SELECT * FROM orders
WHERE orderDate >= '2003-06' AND orderDate <= '2004-06'

/* Q12 */
SELECT MONTH(orderDate), COUNT(*) FROM orders
WHERE YEAR(orderDate) = '2003'
GROUP BY MONTH(orderDate)