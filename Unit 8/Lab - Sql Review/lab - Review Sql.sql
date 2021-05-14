

# 1 Write a SELECT statement that lists the customerid along with their account number, type, the city the customer lives in and their postalcode.

SELECT c.CustomerID, c.AccountNumber, c.CustomerType, a.City, a.PostalCode
FROM adventureworks.customer c
JOIN adventureworks.customeraddress ca
ON c.CustomerID = ca.CustomerID
JOIN adventureworks.address a
ON ca.AddressID = a.AddressID;

# 2 Write a SELECT statement that lists the 20 most recently launched products, their name and colour

SELECT p.Name, p.Color, p.SellStartDate
FROM adventureworks.product p
ORDER BY SellStartDate DESC
LIMIT 20;

# 3 Write a SELECT statement that shows how many products are on each shelf in 2/5/98, broken down by product category and subcategory

SELECT pi.Shelf, count(pi.ProductID) as num_of_products, p.ProductSubcategoryID
FROM adventureworks.productinventory pi
JOIN product p 
ON pi.ProductID = p.ProductID
WHERE pi.ModifiedDate = '1998-05-02 00:00:00'
GROUP BY pi.Shelf, p.ProductSubcategoryID
ORDER BY pi.Shelf
;

# 4 I am trying to track down a vendor email address… his name is Stuart and he works at G&K Bicycle Corp.
# Can you help?

SELECT *
FROM vendor
WHERE Name = 'G & K Bicycle Corp.';
#VendorID = 18

SELECT *
FROM vendorcontact
WHERE VendorID = '18';
#ContactID = 615

SELECT EmailAddress
FROM contact
WHERE FirstName = 'Stuart' AND ContactID = '615' ;
# stuart2@adventure-works.com

# 5 What’s the total sales tax amount for sales to Germany? What’s the top region in Germany by sales tax?

SELECT *
FROM stateprovince
WHERE CountryRegionCode = 'DE';
# TerritoryID 8

SELECT sum(TaxAmt)
FROM salesorderheader
WHERE TerritoryID = '8';
# 430028.1253999987

# 6 Summarise the distinct # transactions by month

SELECT sum(distinct(TransactionID))
FROM transactionhistory
GROUP BY TransactionDate;


# 7 Which ( if any) of the sales people exceeded their sales quota this year and last year?


# 8 Do all products in the inventory have photos in the database and a text product description? 


# 9 What's the average unit price of each product name on purchase orders which were not fully, but at least partially rejected?


# 10 How many engineers are on the employee list? Have they taken any sickleave?


# 11 How many days difference on average between the planned and actual end date of workorders in the painting stages?


# 6 aggregation

# 7 table go back to other table, need if else condition

#8 is fun