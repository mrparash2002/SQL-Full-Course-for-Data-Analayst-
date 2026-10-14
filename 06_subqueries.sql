# 06_Subqueries
-- A subquery is a query nested inside another query. It runs first and its result is used by the outer query as a value, list, or table.
-- Transactions above average value
select `Transaction ID` from retail.sales_transactions 
where `Total Amount ($)` > (select avg(`Total Amount ($)`) 
from retail.sales_transactions);

-- Some questions cannot be answered in one pass 
-- find transactions above the average, or find salespeople who beat their target. Subqueries make this possible.

#1.  Find all transactions where Total Amount is above the overall average Total Amount
select * from retail.sales_transactions
where `Total Amount ($)` > (select avg(`Total Amount ($)`) from retail.sales_transactions);
# select avg(`Total Amount ($)`) from retail.sales_transactions;
-- avg total amount is : 274.71287147266736


#2.  Find all salespeople whose Annual Target is above the average Annual Target
select * from retail.salespeople
where `Annual Target ($)` > 
( select avg(`Annual Target ($)`) from retail.salespeople);



#3.  Find the top earning Salesman ID from Transactions — show their name from Salespeople
select `Salesman ID`,`Salesman Name` from retail.salespeople
where `Salesman ID` = (select `Salesman ID` from retail.sales_transactions
group by `Salesman ID`
order by sum(`Total Amount ($)`) desc limit 1);

#1.  Find all products whose Selling Price is above the average Selling Price across all products
select * from retail.products
where `Selling Price ($)` > 
( select avg(`Selling Price ($)`) from retail.products);

#2.  Find all customers who have made at least one transaction — use a subquery with IN
select `Customer ID`, `Customer Name` from retail.customers
where `Customer ID` IN (select distinct `Customer ID` from retail.sales_transactions
where `Transaction ID` is not null );

#3.  Find the store with the highest total revenue — show Store Name using a JOIN and subquery
select st.`Store ID`,s.`Store Name`, sum(st.`Total Amount ($)`) as revenue from retail.sales_transactions as st
inner join retail.stores as s
on st.`Store ID` = s.`Store ID`
group by st.`Store ID`,s.`Store Name`
order by revenue desc;
-- It can be done this way or 
select s.`Store Name`, sum(st.`Total Amount ($)`) as revenue from retail.sales_transactions as st
inner join retail.stores as s
on st.`Store ID` = s.`Store ID`
group by s.`Store Name`, st.`Store ID`
having sum(st.`Total Amount ($)`) = (
select max(store_revenue) from 
(select sum(`Total Amount ($)`) as store_revenue from retail.sales_transactions
group by `Store ID`)
as totals);



#4.  Find all transactions from the most recent date in the dataset using a subquery in WHERE
select * from retail.sales_transactions 
where `Date` = ( select Date from retail.sales_transactions
order by Date desc limit 01);

-- or we can use max(`Date`) as well




