#05_Joins
# A JOIN in SQL is used to combine rows from two or more tables based on a related column between them.
-- Returns rows only when there is a match in both tables.

-- Get Salesman Name with each transaction
select st.`Salesman ID`, (st.`Total Amount ($)`) as revenue,s.`Salesman Name` 
from retail.sales_transactions as st
inner join retail.salespeople as s
on st.`Salesman ID` = s.`Salesman ID`;

# Practice QSNs
-- 1.  Join Transactions to Salespeople — show Transaction ID, Date, Salesman Name, and Total Amount
select st.`Transaction ID`,st.Date, sp.`Salesman Name`, st.`Total Amount ($)` as total_amount
from retail.sales_transactions as st
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`;

-- 2.  Join Transactions to Products — show Transaction ID, Product Name, Category, and Total Amount
select st.`Transaction ID`, p.`Product Name`, p.`Category`, st.`Total Amount ($)` 
from retail.sales_transactions as st
inner join retail.products as p
on st.`Product ID` = p.`Product ID`;

-- 3.  Join Transactions to Stores — show Transaction ID, Store Name, Store Type, and Total Amount
select st.`Transaction ID`, s.`Store Name`, s.`Store Type`, st.`Total Amount ($)` from retail.sales_transactions as st
inner join retail.stores as s
on st.`Store ID` = s.`Store ID`;


#Left Joins
#LEFT JOIN returns all rows from the left table and matching rows from the right. Where there is no match, NULL appears for the right table columns.
# Use INNER JOIN when you only want complete data where a relationship exists on both sides
# Use LEFT JOIN when you want to preserve the primary list and see what is missing

#left join practice qsns
-- All transactions including those with null Salesman ID
select st.`Transaction ID`, st.`Total Amount ($)`, sp.`Salesman Name` from retail.sales_transactions as st
left join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`;

# 1.  LEFT JOIN Transactions to Salespeople — find rows where Salesman Name is NULL
select st.`Transaction ID`, st.`Total Amount ($)`, sp.`Salesman Name` from retail.sales_transactions as st
left join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
where sp.`Salesman Name` is null;

#2.  LEFT JOIN Transactions to Customers — find rows where Customer Name is NULL
select * from retail.sales_transactions as st
left join retail.customers as c
on st.`Customer ID` = c.`Customer ID`
where c.`Customer Name` is null;

#3.  LEFT JOIN Salespeople to itself on Manager ID — find the salesman with no manager
select * from retail.salespeople as m
left join retail.salespeople as s
on m.`Manager ID` = s.`Salesman ID`
where s.`Manager ID` is null;

#Assignment Qsns
# 1.  JOIN Transactions to Products — find total revenue grouped by Product Category using the joined data
select sum(st.`Total Amount ($)`) as revenue, p.`Category` 
from retail.sales_transactions as st
inner join retail.products as p
on st.`Product ID` = p.`Product ID`
group by p.`Category`
order by revenue desc;


#2.  JOIN Transactions to Salespeople — find the top 5 salespeople by total revenue using Salesman Name not ID
select sp.`Salesman Name`, sum(st.`Total Amount ($)`) as total_amt 
from retail.sales_transactions as st
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
group by sp.`Salesman Name`
order by total_amt desc limit 5;


#3.  LEFT JOIN Transactions to Customers — count how many transactions have no matching Customer record
SELECT COUNT(st.`Transaction ID`) AS trans_count
FROM retail.sales_transactions AS st
LEFT JOIN retail.customers AS c 
ON st.`Customer ID` = c.`Customer ID`
WHERE c.`Customer ID` IS NULL;

#4.  LEFT JOIN Salespeople to Salespeople on Manager ID — list every salesperson with their manager's name
select sp.`Salesman Name`, m.`Salesman Name`as Manager_Name from retail.salespeople as sp
left join retail.salespeople as m
on m.`Salesman ID` = sp.`Manager ID`;

#Bonus : Combine JOIN with WHERE. JOIN Transactions to Products, filter to Electronics category only, 
# then GROUP BY Product Name to find the best-selling Electronics product by revenue
select p.`Product Name`, sum(st.`Total Amount ($)`) as sales from retail.sales_transactions as st
inner join retail.products as p
on st.`Product ID` = p.`Product ID`
where p.`Category` = 'Electronics'
group by p.`Product Name`
order by sales desc limit 5;








