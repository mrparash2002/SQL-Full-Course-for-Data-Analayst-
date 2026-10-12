#04 Group By and Aggregations
# GROUP BY collapses rows into groups. Aggregate functions — COUNT, SUM, AVG, MIN, MAX — calculate a single value for each group.
-- Total revenue per Payment Mode
select `Payment Mode`, count(*) as total_transaction ,sum(`Total Amount ($)`) as Revenue from retail.sales_transactions
group by `Payment Mode`;

-- Average, MIN and Max order value per Status
select Status, avg(`Total Amount ($)`) as avg_revenue, 
min(`Total Amount ($)`) as min_revenue, max(`Total Amount ($)`) as max_revenue from retail.sales_transactions
group by Status;
-- 1.  Find total revenue and transaction count grouped by Payment Mode
select sum(`Total Amount ($)`) as total_revenue, count(*) as total_transcations from retail.sales_transactions
group by `Payment Mode`;
-- 2.  Find total revenue grouped by Salesman ID — order by revenue descending
select `Salesman ID`, sum(`Total Amount ($)`) as total_rev from retail.sales_transactions
group by `Salesman ID` 
order by total_rev desc;

-- 3.  Find average Total Amount grouped by Store ID
select `Store ID`,avg(`Total Amount ($)`) as avg_rev from retail.sales_transactions
group by `Store ID`;



#Use of Having
-- HAVING filters grouped results after aggregation. WHERE filters rows before grouping
-- Order of execution:
-- 1. FROM   — get the table
-- 2. WHERE  — filter rows
-- 3. GROUP BY — form groups
-- 4. HAVING — filter groups
-- 5. SELECT — return columns
-- 6. ORDER BY — sort output


-- Salesmen with revenue over $50,000
select `Salesman ID`, sum(`Total Amount ($)`) as Revenue from retail.sales_transactions
group by `Salesman ID`
having Revenue > 50000;

#Rules to must remeber: HAVING is just a WHERE clause, but specifically for filtering aggregated math totals (like SUM or COUNT).
#To use having we must use an aggregation 

-- Payment modes with 500+ transactions from high to low
select `Payment Mode`,count(*) as transactions from retail.sales_transactions
group by `Payment Mode`
having transactions > 500 
order by transactions desc;

#Practice Qsns
# 1.  Find all Salesman IDs where total revenue exceeds $100,000
select `Salesman ID`,sum(`Total Amount ($)`) as revenue from retail.sales_transactions
group by `Salesman ID`
having revenue > 100000
order by revenue desc;

#2.  Find Payment Modes with more than 1,500 transactions
select `Payment Mode`, count(*) as transactions from retail.sales_transactions
group by `Payment Mode`
having transactions > 1500
order by transactions desc;


#3.  Find Store IDs where average order value is above $100
select `Store ID`, avg(`Unit Price ($)`) as avg_order from retail.sales_transactions
group by `Store ID`
having avg_order > 100
order by avg_order desc;


#Assignment Qsns
#1.  Find total revenue, count of transactions, and average order value grouped by Status
select `Status`,sum(`Total Amount ($)`) as revenue, count(*) as transactions, avg(`Unit Price ($)`) as avg_up 
from retail.sales_transactions
group by `Status`;

select * from retail.customers;
#2.  Find the number of customers in each Customer Segment
select `Customer Segment`,count(*) as customer_count from retail.customers
group by `Customer Segment`;

#3.  Find all Store IDs where total revenue exceeds $200,000 — order by revenue descending
select `Store ID`, sum(`Total Amount ($)`) as revenue from retail.sales_transactions
group by `Store ID` having revenue > 20000 order by revenue desc;


#4.  Find all Payment Modes where average transaction value is above $250 and count is above 1,000
select `Payment Mode`, avg(`Total Amount ($)`) as avg_trans, count(*) as trans_count from retail.sales_transactions
group by `Payment Mode`
having avg_trans >250 and trans_count > 1000
order by avg_trans;

#Use WHERE and HAVING in the same query. Find Salesman IDs with more than 400 Completed transactions 
-- WHERE filters to Completed first, HAVING filters the count.
select `Salesman ID`, count(*) as transactions, Status from retail.sales_transactions
where Status = 'Completed'
group by `Salesman ID` having transactions > 400;

