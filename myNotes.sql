###################################
MySQL database notes
author: Rodrigo Noriega
date: may 9th 2023
###################################

#Create a database
CREATE DATABASE firstdb;
SHOW satabases;

e.g.

> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| myDb               |
| mysql              |
| performance_schema |
+--------------------+

#Use command let us work on desired db
USE firstdb;

#Create a table, use show tables to display a  table with existent tables, use describe, to describe the table

CREATE TABLE sales_rep(
	employee_number INT,
    	surname VARCHAR(40),
    	first_name VARCHAR(30),
	comission TINYINT);
SHOW TABLES;

e.g.

> show tables;
+-------------------+
| Tables_in_firstdb |
+-------------------+
| sales_rep         |
+-------------------+

> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+

#Insert data in to table

insert into sales_rep(employee_number,surname,first_name,comission) values(1,'Rive','Sol','10');
insert into sales_rep(employee_number,surname,first_name,comission) values(2,'Gordimer','Charlene','15');
insert into sales_rep(employee_number,surname,first_name,comission) values(3,'Serote','Mike','10');

#insertar datos desde un archivo de texto con LOAD DATA
#el formato debe ser .csv utf-8, 
e.g.

> LOAD DATA LOCAL INFILE '/var/tmp/eg.csv' replace into table sales_rep fields terminated by ',' lines terminated by '\n';

Query OK, 4 rows affected (0.01 sec)
Records: 4  Deleted: 0  Skipped: 0  Warnings: 0

#using select to get informaton from table

e.g.

select * from sales_rep;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               1 | Rive     | Sol        |        10 |
|               2 | Gordimer | Charlene   |        15 |
|               3 | Serote   | Mike       |        10 |
+-----------------+----------+------------+-----------+

#Delete complete data from a table without deleting the table structure
truncate table sales_rep

