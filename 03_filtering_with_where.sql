# DAY 03 OF LEARNING SQL for data analystics
# WHERE filters rows before they are returned. Only rows where the condition is TRUE appear in the result.
select `Customer Name` ,Age from retail.customers
where Age > 15;

#Completed transactions only from transactions table
select * from retail.sales_transactions
where Status = "Completed"; #While adding a valuse use ""

#Use of comparison operators. Show transaction above $500
select * from retail.sales_transactions
where `Total Amount ($)` > 500;

#Multiple conditions AND & OR
#-- Credit Card payments in 2024
select * from retail.sales_transactions
where `Payment Mode` = "Credit Card" and Date >= "2024-01-01" ;#since the final date here is upto 2024-06 so we donot justify it between

#Between : To set up a range between the values
select * from retail.sales_transactions
where `Discount (%)` between "5" and "10";

#IN — Matching Any Value in a List
select * from retail.customers;
select `Customer Name`, `City` from retail.customers 
where City in ("Boston", "Dallas", "San Diego");
#it is like an OR where only one codition has to match to get the output

#Like - Pattern Matching
select `Customer Name` from retail.customers
where `Customer Name` like '%A'; # this finds the names which starts with the letter A
-- where `Customer Name` like '%A' finds the name which ends with the letter A
-- where `Customer Name` like '%A%' finds the name which has letter A

#1.  Find all transactions where Status is 'Returned'
select * from retail.sales_transactions
where Status = "Returned" limit 10;

#2.  Find all transactions where Total Amount is between $200 and $500
select `Transaction ID` as trans_id, `Total Amount ($)` as total_amt from retail.sales_transactions
where `Total Amount ($)` between 200 and 500;

#3.  Find all customers from Texas (State = 'TX') in the Premium segment
select `Customer Name`, `State`, `Customer Segment` from retail.customers
where State = "TX" and `Customer Segment` = "Premium";

-- Transactions paid by Cash or Online Transfer
select * from retail.sales_transactions
where `Payment Mode` in ('Cash', 'Online Transfer');

-- Customers whose name starts with S
select * from retail.customers
where `Customer Name` like 'S%';

-- Find null Salesman IDs
select * from retail.sales_transactions
where `Salesman ID` is null;

-- Sort by date newest first: Order By (sort the result set of a query in ascending or descending order.)
select * from retail.sales_transactions
order by Date desc;

#More Practice Qsns 
#1.  Find all transactions where Payment Mode is Cash, Debit Card, or Gift Card
select * from retail.sales_transactions
where `Payment Mode` in ('Cash','Debit Card','Gift Card');
#2.  Find all customers whose name contains the word 'Smith'
select * from retail.customers
where `Customer Name` like '%Smith%';
#3.  Find all transactions with a null Customer ID — order by Total Amount descending
select * from retail.sales_transactions
where `Customer ID` is null 
order by `Total Amount ($)` desc;

#Assignments to Complete
#1.  Find all completed transactions where Total Amount is greater than $1000 — order by Total Amount descending
select * from retail.sales_transactions
where Status = "Completed" and `Total Amount ($)` > '1000'
order by `Total Amount ($)` desc;

#2.  Find all customers from California (State = 'CA') or New York (State = 'NY')
select * from retail.customers
where State in ('CA','TX');

#3.  Find all transactions where Salesman ID IS NULL and Status is Completed
select * from retail.sales_transactions
where `Salesman ID` is null and Status = 'Completed'; # since there are no null salesman id with completed status so it will show 0 rows

#4.  Find all products where Product Name contains the word 'Pro' — show Product Name, Category, and Selling Price
select  `Product Name`, `Category`, `Selling Price ($)` from retail.products
where `Product Name` like '%Pro%';

#Combine IN and LIKE in the same query. Find all customers from TX or CA whose name starts with the letter A.
select * from retail.customers
where State in ('TX','CA') and `Customer Name` like '%A%';