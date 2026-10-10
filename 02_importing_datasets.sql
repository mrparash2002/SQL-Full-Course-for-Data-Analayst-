# 02_importing data using table wizard import wizard
create database retail;
use retail;
#first created a database/schema where i will import datasets of CSV format

#After importing all files verify it
select * from retail.salespeople;
select * from retail.customers;
select * from retail.products;
select * from retail.stores;
select * from retail.sales_transactions;


#getting a specififc column from a table
select `Customer ID`, `Customer Name`,`Age` from retail.customers;
#Use back tick `` id a column name has space

#Alias
select `Transaction ID` as total_transaction , `Unit Price ($)` as cost_price, `Total Amount ($)` as selling_price
from retail.sales_transactions;
#here i used alias "as" to rename a column

#using limit; what if i wanna know first 10 transaction
select `Transaction ID`as trans_id , `Total Amount ($)` as top_sellings from retail.sales_transactions
limit 10;

#practice qsn 1.  Select only Customer Name, City and Customer Segment from Customers
select `Customer Name`, `city`, `Customer Segment` from retail.customers;

#practice qsn 2.  Select Transaction ID, Date and Total Amount from Sales Transactions — limit to 20 rows
select `Transaction ID`, `Date`, `Total Amount ($)` from retail.sales_transactions limit 20;

#Assignment
#1.  Write a query to select all columns from the Products table
select * from retail.products;
#2.  Write a query to select only Salesman Name, Region, and Annual Target from Salespeople — rename Annual Target as Target
select `Salesman Name`, `Region`, `Annual Target ($)` as Target from retail.salespeople;
#3.  Write a query to select Transaction ID, Date, Payment Mode, and Total Amount from Sales Transactions — order by Date descending, limit to 50 rows
Select `Transaction ID`, `Date`, `Payment Mode`, `Total Amount ($)` from retail.sales_transactions
order by Date desc limit 50;
#here order means a clause that sorts the result set of a query in either ascending or descending order

#4.  Write a query to count how many rows exist in each of the 5 tables using COUNT(*)
select
(select count(*)from retail.sales_transactions) as sales_trans_count,
(select count(*) from retail.salespeople) as salespeople_count,
(select count(*) from retail.customers) as customer_count,
(select count(*) from retail.products) as products_count,
(select count(*) from retail.stores) as stores_count;


#Bonus QSN: SELECT DISTINCT `Payment Mode` FROM `Sales Transactions` — what does DISTINCT do? Try it and observe the result.

select distinct `Payment Mode` from retail.sales_transactions;
#Here distinct means giving unique values only





