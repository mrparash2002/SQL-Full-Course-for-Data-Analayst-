#Real World Queries
/* Real analyst queries combine SELECT, WHERE, GROUP BY, HAVING, JOINs, and Window Functions 
in a single statement to answer complex business questions.*/

-- Top 3 salespeople per region by completed revenue only
select sp.`Salesman ID`, sp.`Salesman Name`, sum(st.`Total Amount ($)`) as earning 
from retail.sales_transactions as st
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
group by sp.`Salesman ID`, sp.`Salesman Name`
order by earning desc limit 3;


# 1.  Total revenue by Product Category for Completed transactions only — ordered highest to lowest
select sum(st.`Total Amount ($)`) as earning,sp.`Category`,
dense_rank() over(order by sum(st.`Total Amount ($)`) desc) as ranking
from retail.sales_transactions as st
inner join retail.products as sp
on st.`Product ID` = sp.`Product ID`
where Status = 'Completed'
group by sp.`Category`;


#2.  Top 5 customers by total spend — JOIN Transactions to Customers, show Customer Name and total

select c.`Customer ID`, c.`Customer Name`, sum(st.`Total Amount ($)`)
,rank() over( order by sum(st.`Total Amount ($)`) desc) as ranking
from retail.sales_transactions as st
inner join retail.customers as c
on st.`Customer ID` = c.`Customer ID`
group by c.`Customer ID`,c.`Customer Name`;


# 3.  For each salesman, show their total revenue and rank compared to all other salesmen
select sp.`Salesman ID`, sp.`Salesman Name`, sum(st.`Total Amount ($)`),
rank() over( order by sum(`Total Amount ($)`) desc) as ranking
from retail.sales_transactions as st
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
group by sp.`Salesman ID`, sp.`Salesman Name`
order by ranking;


#Q1.  Which Product Category generated the highest total revenue from Completed transactions?
select p.`Product ID`,p.`Product Name`,sum(st.`Total Amount ($)`) as sales 
from retail.sales_transactions as st
inner join retail.products as p
on st.`Product ID` = p.`Product ID`
where status = 'Completed'
group by p.`Product ID`, p.`Product Name`
order by sales desc;




#imporant CTE
# In SQL, WITH lets you create a temporary named result that you can use in your main query. This is called a CTE (Common Table Expression).
#Q2.  Who are the top 3 salespeople by revenue in each Region? Use window functions.
with ranked_salespeople as (
select sp.`Salesman ID`, sp.`Salesman Name`,sum(st.`Total Amount ($)`) as earning, sp.`Region`,
dense_rank() over (partition by sp.`Region` order by sum(st.`Total Amount ($)`) desc) as Rankings
from retail.sales_transactions as st
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
group by sp.`Salesman ID`,sp.`Salesman Name`, sp.`Region`)
select * from ranked_salespeople
where Rankings <=3
order by Region, Rankings;

# Q3.  Which customers have spent more than the average customer spend? Show their names and total spend.
select c.`Customer ID`,c.`Customer Name`, avg(st.`Total Amount ($)`) as avg_spending
from retail.sales_transactions as st
inner join retail.customers as c
on st.`Customer ID` = c.`Customer ID`
where st.`Total Amount ($)` > avg(st.`Total Amount ($)`)
group by c.`Customer ID`, c.`Customer Name`;


#Q4.  Which stores have a higher average transaction value than the overall average? Show Store Name and Store Type.
select s.`Store ID`,s.`Store Name`,s.`Store Type`, avg(st.`Total Amount ($)`)
#rank() over(order by avg(st.`Total Amount ($)`) desc) as ranking
from retail.stores as s
inner join retail.sales_transactions as st
on st.`Store ID` = s.`Store ID`
group by s.`Store ID`, s.`Store Name`, s.`Store Type`
having avg(st.`Total Amount ($)`) in (select avg(st.`Total Amount ($)`) from retail.sales_transactions)
order by avg(st.`Total Amount ($)`) desc limit 01;


#Q5.  For each month in the dataset, show total revenue and how it compares to the previous month using LAG().
with monthly_rev as ( select Year(`Date`) as yearly_rev, month(`Date`) as monthly_rev,
sum(`Total Amount ($)`) as revenue from retail.sales_transactions
group by yearly_rev, monthly_rev)
select yearly_rev, monthly_rev, revenue,
lag(revenue) over(order by yearly_rev, monthly_rev) as previpus_month_revenue
from monthly_rev
order by yearly_rev, monthly_rev;





