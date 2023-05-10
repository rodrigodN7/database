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

#Delete complete data from a table without deleting the table structure
truncate table sales_rep

#insertar datos desde un archivo de texto con LOAD DATA
#el formato debe ser .csv utf-8, 
e.g.

> LOAD DATA LOCAL INFILE '/var/tmp/eg.csv' replace into table sales_rep fields terminated by ',' lines terminated by '\n';

Query OK, 3 rows affected (0.01 sec)
Records: 3  Deleted: 0  Skipped: 0  Warnings: 0

#using select to get/extract informaton from table

e.g.

>select * from sales_rep;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               1 | Rive     | Sol        |        10 |
|               2 | Gordimer | Charlene   |        15 |
|               3 | Serote   | Mike       |        10 |
+-----------------+----------+------------+-----------+

>select comission from sales_rep where surname='Gordimer';
+-----------+
| comission |
+-----------+
|        15 |
+-----------+
1 row in set (0.00 sec)

>select comission,employee_number from sales_rep where surname='Gordimer';
+-----------+-----------------+
| comission | employee_number |
+-----------+-----------------+
|        15 |               2 |
+-----------+-----------------+
1 row in set (0.00 sec)

>select * from sales_rep where surname='Gordimer';
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
+-----------------+----------+------------+-----------+
1 row in set (0.01 sec)

>select * from sales_rep where comission>10;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               1 | Rodrigo  | Noriega    |       117 |
|               2 | Gordimer | Charlene   |        15 |
+-----------------+----------+------------+-----------+
2 rows in set (0.00 sec)

>select * from sales_rep where surname='Rive' and (first_name='Sol' or comission>10);
+-----------------+---------+------------+-----------+
| employee_number | surname | first_name | comission |
+-----------------+---------+------------+-----------+
|               3 | Rive    | Sol        |        10 |
+-----------------+---------+------------+-----------+
1 row in set (0.00 sec)

#correspondencias de patrones
>select * from sales_rep where surname LIKE 'Ri%';
+-----------------+---------+------------+-----------+
| employee_number | surname | first_name | comission |
+-----------------+---------+------------+-----------+
|               3 | Rive    | Sol        |        10 |
+-----------------+---------+------------+-----------+
1 row in set (0.00 sec)

>select * from sales_rep where surname like '%e%';
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
|               3 | Rive     | Sol        |        10 |
+-----------------+----------+------------+-----------+
2 rows in set (0.00 sec)

> select * from sales_rep where surname like 'g%';
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
+-----------------+----------+------------+-----------+
1 row in set (0.00 sec)

#search for surname which contains an o in some plase and finishes with o.
#busca en surname que contenga o en alguna parte y que termine en o
> select * from sales_rep where surname like '%o%o';
+-----------------+---------+------------+-----------+
| employee_number | surname | first_name | comission |
+-----------------+---------+------------+-----------+
|               1 | Rodrigo | Noriega    |       117 |
+-----------------+---------+------------+-----------+
1 row in set (0.00 sec)

#ordenación

> select * from sales_rep order by surname;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
|               1 | Rive     | Sol        |        10 |
|               4 | Rive     | Mongane    |        10 |
|               3 | Serote   | Mike       |        10 |
|               5 | Smith    | Mike       |        12 |
+-----------------+----------+------------+-----------+
5 rows in set (0.00 sec)

> select * from sales_rep order by surname,first_name;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
|               4 | Rive     | Mongane    |        10 |
|               1 | Rive     | Sol        |        10 |
|               3 | Serote   | Mike       |        10 |
|               5 | Smith    | Mike       |        12 |
+-----------------+----------+------------+-----------+
5 rows in set (0.00 sec)

>select * from sales_rep order by comission desc;
+-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
|               5 | Smith    | Mike       |        12 |
|               1 | Rive     | Sol        |        10 |
|               3 | Serote   | Mike       |        10 |
|               4 | Rive     | Mongane    |        10 |
+-----------------+----------+------------+-----------+
5 rows in set (0.00 sec)

> select * from sales_rep order by comission desc, surname ASC,first_name ASC;
 +-----------------+----------+------------+-----------+
| employee_number | surname  | first_name | comission |
+-----------------+----------+------------+-----------+
|               2 | Gordimer | Charlene   |        15 |
|               5 | Smith    | Mike       |        12 |
|               4 | Rive     | Mongane    |        10 |
|               1 | Rive     | Sol        |        10 |
|               3 | Serote   | Mike       |        10 |
+-----------------+----------+------------+-----------+
5 rows in set (0.00 sec)

#limitación del número de resultados
#limit 0 no devuelve registros

> select first_name,surname,comission from sales_rep order by comission desc;
+------------+----------+-----------+
| first_name | surname  | comission |
+------------+----------+-----------+
| Charlene   | Gordimer |        15 |
| Mike       | Smith    |        12 |
| Sol        | Rive     |        10 |
| Mike       | Serote   |        10 |
| Mongane    | Rive     |        10 |
+------------+----------+-----------+
5 rows in set (0.00 sec)


> select first_name,surname,comission from sales_rep order by comission desc limit 1;
+------------+----------+-----------+
| first_name | surname  | comission |
+------------+----------+-----------+
| Charlene   | Gordimer |        15 |
+------------+----------+-----------+
1 row in set (0.00 sec)

> select first_name,surname,comission from sales_rep order by comission desc limit 1,1;
+------------+---------+-----------+
| first_name | surname | comission |
+------------+---------+-----------+
| Mike       | Smith   |        12 |
+------------+---------+-----------+
1 row in set (0.00 sec)

> select first_name,surname,comission from sales_rep order by comission desc limit 0,1;
+------------+----------+-----------+
| first_name | surname  | comission |
+------------+----------+-----------+
| Charlene   | Gordimer |        15 |
+------------+----------+-----------+
1 row in set (0.01 sec)

> select first_name,surname,comission from sales_rep order by comission desc limit 2,3;
+------------+---------+-----------+
| first_name | surname | comission |
+------------+---------+-----------+
| Sol        | Rive    |        10 |
| Mike       | Serote  |        10 |
| Mongane    | Rive    |        10 |
+------------+---------+-----------+
3 rows in set (0.00 sec)


