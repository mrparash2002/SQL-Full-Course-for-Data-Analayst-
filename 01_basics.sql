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

#what if i have to add a column in students table
#ALter
alter table students add column email varchar(50) unique; #unique is required to store unique email addresses
insert into students (email)
values ("mrparash001@gmail.com"), ("rahul02@gmail.com");
#check the values 
select * from students;
#due to auto increment my new emails are being stored in new rows so we will drop it 

alter table students drop column email;


use sql_learning;
#now use update
alter table students add column email varchar(70) unique;
update students set email = "parashchhetri01@gmail.com" where student_id = 1;


#rename a table
rename table students to students_info;

#only one student should have an email so we will check
select * from students_info;
#Till now we have done DDL (Data Definition Language), DML (Data Manipulation Language)



#Truncate :to instantly delete all rows from a table while keeping the table's structure, columns, and indexes intact
#Mostly avoid drop table but we can use truncate to remove info but keep the columns in a proper structure
truncate table students_info;
select * from students_info;