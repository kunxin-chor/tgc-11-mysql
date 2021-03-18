/* select only certain columns from the table */
select employeeNumber, email from employees;

/* show all the employees from officeCode 1 */
select firstName, lastName, email from employees where officeCode = 1;

/* see all the sales rep */
select * from employees where jobTitle = "Sales Rep"

/* see all the rows where jobTitle has the substring "sales" */
select * from employees where jobTitle like "%Sales%";

/* Find all the sales rep from office code 1 */
select * from employees where officeCode=1 and jobTitle = "Sales Rep";

/* Find all the employees from office code 1 or office code 4 */
select * from employees where officeCode = 1 or officeCode = 4;

/* Find all employees NOT from office code 1 or 4 */
select * from employees where officeCode != 1 and officeCode !=4;
select * from employees where officeCode not in (1,4);

/* Find all employees from office code 4 and all sales rep from office code 1 */
/* There is an implied parenthesis after the or */
select * from employees where officeCode = 4 or officeCode = 1 and jobTitle="Sales Rep";

/* Show the city, addressline1, addresslin2 and state for all emplyoees */
SELECT firstName, lastName, city, addressLine1, addressLine2, state FROM employees
	join offices on employees.officeCode = offices.officeCode

/* Show the customer name, sales rep name, and the city of the sales rep */
SELECT customers.customerName, employees.firstName, employees.lastName, offices.city FROM customers join employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber
join offices
 ON employees.officeCode = offices.officeCode


/* Show the customer name, sales rep name, and the city of the sales rep,
    but only for customers from USA or France,
    sorted by the custoemr name in descending order
 */
SELECT customers.customerName, employees.firstName, employees.lastName, offices.city
 FROM customers join employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber
join offices
 ON employees.officeCode = offices.officeCode
WHERE customers.country = "France" or customers.country = "USA"
ORDER BY customers.customerNumber DESC;

/* Show the customer name, sales rep name, and the city of the sales rep,
    but only for customers from USA or France,
    sorted by the custoemr name in descending order
    and show only the first three results
 */
SELECT customers.customerName, employees.firstName, employees.lastName, offices.city
 FROM customers join employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber
join offices
 ON employees.officeCode = offices.officeCode
WHERE customers.country = "France" or customers.country = "USA"
ORDER BY customers.customerNumber DESC
LIMIT 3;

/* Answer to questions */
/* 1. Find all the offices and display only their city, phone and country */
SELECT city, phone, country FROM offices;

/* 2. Find all the orders where FedEx is mentioned in the comments */
SELECT * from orders where comments like "%Fedex%";

/* 3. Display all the orders bought by the customer with the customer number 124, along with the customer name, the contact's first name and contact's last name.*/
SELECT orders.*, customers.customerName, customers.contactLastName, customers.contactFirstName FROM customers JOIN orders ON orders.customerNumber = customers.customerNumber
	WHERE customers.customerNumber = 124;

/* 4. Show the contact first name and contact last name of all customers in descending order by the customer's name */
SELECT contactFirstName, contactLastName from customers order by customerName;

/* 5. Find all sales rep who are in office code 1, 2 or 3 and their first name or last name contains the substring 'son' */
SELECT * from employees where jobTitle = "Sales Rep" and 
(firstName LIKE "%son%" OR lastName LIKE "%son%") and
(officeCode = 1 OR officeCode = 2 OR officeCode = 3);

SELECT * from employees where jobTitle = "Sales Rep"
and (firstName LIKE "%son%" OR lastName LIKE "%son%") and
officeCode in (1,2,3);

/* 6.  Show the name of the product, together with the order details,  for each order line from the orderdetails table */
SELECT orderdetails.orderNumber, products.productCode, products.productName FROM orderdetails 
join products on orderdetails.productCode = products.productCode

/** DATES **/

/* show all the orders made on 2003-01-09 */
select * from orders where orderDate='2003-01-09';

/* extract out the year,month and day components of a date */
select orderNumber, YEAR(orderDate), MONTH(orderDate), DAY(orderDate) from orders;

/* find all the orders made in the year 2003 */
select orderNumber, orderDate from orders where YEAR(orderDate) = 2003;
select orderNumber, orderDate from orders where orderDate >= '2003-01-01' and orderDate <= '2003-31-12';

/* find all the orders made in the year 2003 and in the month of feb */
select orderNumber, orderDate from orders where YEAR(orderDate) = '2003' AND MONTH(orderDate) = '2';

/* find all the orders that are required to ship in 3 days time */
select * from orders where requiredDate - CURDATE() = 3;

/* find all the orders that has shipped within 3 days ago */
select * from orders where CURDATE() - shippedDate < 3;

/* AGGREGATION */
/* aka Reducing */

/* Count how many orders there are */
select count(*) from orders;

/* Sum up the creditLimit for all customers */
SELECT sum(creditLimit) FROM customers;

/* Find the average credit limit */
select avg(creditLimit) FROM customers;

/* Find the average credit limit for all customers from USA */
SELECT avg(creditLimit) FROM customers WHERE country="USA";

/* Find the MAX credit limit among all the customers from USA */
SELECT max(creditLimit) FROM customers WHERE country="USA"

/* Find the MIN credit limit among all the customers from USA */
SELECT min(creditLimit) FROM customers WHERE country="USA"

/* Show the countries where we have customers */
SELECT distinct(country) from customers;

/* Show the average credit limit for each country */
SELECT avg(creditLimit), country FROM customers
GROUP BY country

/* Count all the employees in each office */
SELECT offices.officeCode, city, count(*) AS "employee_count" FROM employees
JOIN offices on employees.officeCode = offices.officeCode
GROUP BY officeCode, city

/* Count all the SALES REP in each office */
SELECT offices.officeCode, city, count(*) AS "employee_count" FROM employees
JOIN offices on employees.officeCode = offices.officeCode
WHERE jobTitle = "Sales Rep"
GROUP BY officeCode, city

/* Only show the office where they have more than 2 sales rep */
SELECT offices.officeCode, city, count(*) AS "employee_count" FROM employees
JOIN offices on employees.officeCode = offices.officeCode
WHERE jobTitle = "Sales Rep"
GROUP BY officeCode, city
HAVING count(*) > 2
ORDER BY count(*)


/* SUB QUERIES */
/* find all customers whose credit limit is above the average credit limit */