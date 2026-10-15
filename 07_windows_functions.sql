#SubQueries Continue
/*Add a WHERE clause to your multi-table JOIN. 
Filter to Completed transactions, Online stores only. Then GROUP BY Salesman Name — who drives the most online revenue?*/
select * from retail.sales_transactions;
select * from retail.stores;
select * from retail.salespeople;
select s.`Store Type`,s.`Store Name`,sp.`Salesman Name`,sum(st.`Total Amount ($)`) as total_revenue from retail.sales_transactions as st
inner join retail.stores as s
on st.`Store ID` = s.`Store ID`
inner join retail.salespeople as sp
on st.`Salesman ID` = sp.`Salesman ID`
where st.Status = 'Completed' and s.`Store Type` = 'Online'
group by sp.`Salesman Name`
order by total_revenue desc limit 1;


#Starting Day 07_Windows Function
-- Window functions perform calculations across a set of rows related to the current row — without collapsing the data the way GROUP BY does.
-- Rank salespeople by revenue, -- within each Region
select sum(st.`Total Amount ($)`) as revenue , sp.Region,
rank() over (Partition by sp.Region 
order by sum(st.`Total Amount ($)`)) as revenue_rank
from retail.sales_transactions as st
join retail.salespeople sp using (`Salesman ID`)
group by st.`Salesman ID`, Region;

# QSNS for practice
#1.  Rank all transactions by Total Amount using RANK() — highest value gets rank 1
select `Transaction ID`,sum(`Total Amount ($)`) as revenue ,
rank() over (
order by sum(`Total Amount ($)`) desc) as revn_rank
from retail.sales_transactions
group by `Transaction ID`;

#2.  Using a JOIN and RANK() OVER PARTITION BY Region, rank salespeople by revenue within each region
select sp.`Salesman Name`, sum(st.`Total Amount ($)`) as totals, sp.`Region`,
rank() over(partition by sp.`Region`
order by sum(`Total Amount ($)`) desc)
from retail.sales_transactions as st
join retail.salespeople as sp using (`Salesman ID`)
group by sp.`Salesman Name`,sp.`Region`;


# 3.  Calculate a running total of Total Amount ordered by Date using SUM() OVER()
select sum(`Total Amount ($)`) as totals,Date,
 sum(sum(`Total Amount ($)`)) over(partition by Date) as running_total
 from retail.sales_transactions
 group by Date
 order by Date desc;


