--- Show all information in the offices relation.SELECT *FROM offices---. Show the city and phone of all offices, in alphabetical order of city – if there is more than one
--office in a city then give their phone numbers in decreasing orderSELECT [city],[phone]FROM officesORDER BY [city] ASC,[phone] DESC--- Show all information in the offices table for offices located in countries ‘UK’ and ‘SA’SELECT *FROM officesWHERE [country] in ('UK','SA')----Show all information in the orderdetails relation for large orderlines. A large orderline is one
--where the cost is more than 10 000 (cost is quantityOrdered times priceEach).SELECT *FROM orderdetailswhere (quantityOrdered*priceEach)>10000---We have doubled our quantityInStock of every product from productVendor ‘Exoto Designs’.
---Show productVendor, productCode, and new (doubled) quantityInStock for all ‘Exoto Designs’
---products - I’m unsure how “Exoto” is spelt, but I know it starts “Ex” and has a “to” somewhere.
--Call the last column newStock.
SELECT [productVendor],[productCode],[newStock] =[quantityInStock]FROM productsWHERE [productVendor] LIKE '%Ex%' and [productVendor] like '%to%'---In what cities do we have offices? Call the answer column `city’SELECT [city]= cityFROM offices---Show all data for offices where there is an addressLine2 value, but the state is missing (NULL).SELECT *FROM officeswhere [state] is null---How many tuples (rows) are there in employees? Call the result column ‘numEmps’.SELECT [numEmps]= COUNT(*)FROM employees---What is the average buyPrice in the database? Call the result ‘avPrice’ and show 2 decimal
---places

SELECT 
[avPrice] = AVG([priceEach])
FROM orderdetails


---How many different creditLimit values are there in our database? Call the result ‘numLimits’.
SELECT
[numLimits]= COUNT(DISTINCT(creditLimit))
FROM customers


---Show orderNumber, status, priceEach, quantityOrdered and productName for all products
--from productVendor ‘Exoto Designs’.SELECT
a.[orderNumber],a.[status],b.[priceEach],b.[quantityOrdered],c.[productName],c.[productVendor]


FROM orders a
inner join orderdetails b
	on a.orderNumber =b.orderNumber
inner join products c
	on b.productCode = c.productCode
WHERE [productVendor] = 'Exoto Designs'


--- Show the OrderNumber, Comments and customerName of all orders that have a status of
--‘Disputed’.
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

---. Show how many employees there are in each office. Call the 1st column ‘officeCode’ and the
--2nd column ‘numEmps’.
SELECT 
b.[officeCode],
[numEmps]= count(a.[employeeNumber])
FROM  employees a
inner join  offices b
	on a.officeCode = b.officeCode
group by b.officeCode




--- Show how many Sales Reps there are in each office. Call the 1st column ‘officeCode’ and the 2nd
--column ‘numReps’.
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
--who report to employee 1143. Call the 1st column ‘salesRepEmployeeNumber‘ and the 2nd
---column ‘numCustomers’.
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
--sure that the 2nd column’s officeCode is less than the 3rd column’s officeCode so information is
--not repeated. Call the 2nd column ‘oneOffice’ and the 3rd column ‘otherOffice’.

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
---- Give a SQL statement to output “YES” if any attribute storing a price (and thus specified as NOT
---NULL) contains a value that is zero – i.e., if priceEach in any orderdetails row, or buyPrice in any
---products row, is zero. If there is no zero in those columns, then it should output an empty table.
---Call the result column ‘anyProblems’.

SELECT 
[anyProblems] =CASE 
					WHEN a.[priceEach] = 0  or b.[buyPrice]= 0 THEN 'YES'
					ELSE ''
					END
FROM  orderdetails a
INNER JOIN  products b
	ON  a.productCode = b.productCode
