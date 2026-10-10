create schema sql_learning;

# before creating a table we must create a database so I created a DB name sql_learning
use sql_learning;
#then i used this database

#Creating a table
create table sql_learning.students (
student_id int auto_increment primary key, #student id is integer(number) and a primary key
name varchar(50), # name is variable character with limit of (50) chars
course varchar(50) ); #same as name


#Inserting data in sql
insert into students (name,course)
values ("Parash", "Data Analytics");
#here i didnt wrote student cause i use auto_incement which means: automatically assign value to student id

#check the value
select * from sql_learning.students;
# here * means all

#Now insert more 5 datas
insert into students (name,course)
values
("Rahul","Data Science"),
("Neeraj", "Web Development"),
("Sajan","SEO"),
("Rajeev","Digital Markiting")
,("Punit Superstar","Social Media");


#Now recheck all the data we have inserted
select * from students;


#Till now we have done DDL (Data Definition Language), DML (Data Manipulation Language)
#and DQL (Data Query Language). other things will be done vastly in another query/file
