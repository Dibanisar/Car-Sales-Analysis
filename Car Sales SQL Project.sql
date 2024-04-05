--- Show all information in the offices relation.
--office in a city then give their phone numbers in decreasing order
--where the cost is more than 10 000 (cost is quantityOrdered times priceEach).
---Show productVendor, productCode, and new (doubled) quantityInStock for all �Exoto Designs�
---products - I�m unsure how �Exoto� is spelt, but I know it starts �Ex� and has a �to� somewhere.
--Call the last column newStock.
SELECT 
---places

SELECT 
[avPrice] = AVG([priceEach])
FROM orderdetails


---How many different creditLimit values are there in our database? Call the result �numLimits�.
SELECT
[numLimits]= COUNT(DISTINCT(creditLimit))
FROM customers


---Show orderNumber, status, priceEach, quantityOrdered and productName for all products
--from productVendor �Exoto Designs�.
a.[orderNumber],a.[status],b.[priceEach],b.[quantityOrdered],c.[productName],c.[productVendor]


FROM orders a
inner join orderdetails b
	on a.orderNumber =b.orderNumber
inner join products c
	on b.productCode = c.productCode
WHERE [productVendor] = 'Exoto Designs'


--- Show the OrderNumber, Comments and customerName of all orders that have a status of
--�Disputed�.
SELECT
a.[orderNumber],b.[customerName],a.[comments],a.[status]

From  orders a
inner join  customers b
	on a.[customerNumber]= b.[customerNumber]
where status = 'Disputed'


---Show the productCode of all products that have never been ordered
SELECT 
a.[productCode]


FROM  products a
left join  orderdetails b
	on a.productCode=b.productCode
LEFT join  orders c
	on b.orderNumber = c.orderNumber

where c.orderNumber IS NULL

---. Show how many employees there are in each office. Call the 1st column �officeCode� and the
--2nd column �numEmps�.
SELECT 
b.[officeCode],
[numEmps]= count(a.[employeeNumber])
FROM  employees a
inner join  offices b
	on a.officeCode = b.officeCode
group by b.officeCode




--- Show how many Sales Reps there are in each office. Call the 1st column �officeCode� and the 2nd
--column �numReps�.
SELECT 
b.[officeCode],
[numReps]= count(a.[jobTitle])
FROM  employees a
inner join  offices b
	on a.officeCode = b.officeCode
Where jobTitle = 'Sales Rep'
group by b.officeCode



---. Show how many customers each employee is associated with (as salesRepEmployeeNumber),
---but only for employees who are the salesRepEmployeeNumber for at least 10 customers and
--who report to employee 1143. Call the 1st column �salesRepEmployeeNumber� and the 2nd
---column �numCustomers�.
SELECT 
[salesRepEmployeeNumber]= a.[employeeNumber],
numCustomers= count(b.[customerNumber])
FROM  employees a
INNER JOIN  customers b
	on a.employeeNumber = b.salesRepEmployeeNumber
where a.[reportsTo] = 1143
group by a.[employeeNumber]
HAVING  count(b.[customerNumber])>=10


----Which pairs of offices are in the same country? Show the country and the 2 officeCodes, making
--sure that the 2nd column�s officeCode is less than the 3rd column�s officeCode so information is
--not repeated. Call the 2nd column �oneOffice� and the 3rd column �otherOffice�.

SELECT 
    a.country,
    [oneOffice] = a.officeCode,
    [otherOffice] = b.officeCode
FROM  offices a
INNER JOIN  offices b
	ON a.country = b.country AND a.officeCode < b.officeCode


--- Show the customerNumber of the customer/s with the largest single check (cheque) payment
--amount.
SELECT 
    a.customerNumber

FROM  customers a
INNER JOIN  payments b 
	ON a.customerNumber = b.customerNumber
WHERE b.amount = (
        SELECT 
            MAX(amount) 
        FROM 
            payments
    )
---- Give a SQL statement to output �YES� if any attribute storing a price (and thus specified as NOT
---NULL) contains a value that is zero � i.e., if priceEach in any orderdetails row, or buyPrice in any
---products row, is zero. If there is no zero in those columns, then it should output an empty table.
---Call the result column �anyProblems�.

SELECT 
[anyProblems] =CASE 
					WHEN a.[priceEach] = 0  or b.[buyPrice]= 0 THEN 'YES'
					ELSE ''
					END
FROM  orderdetails a
INNER JOIN  products b
	ON  a.productCode = b.productCode