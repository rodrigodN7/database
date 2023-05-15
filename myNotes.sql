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

#max() function

> select max(comission) from sales_rep;

+----------------+
| max(comission) |
+----------------+
|             15 |
+----------------+
1 row in set (0.00 sec)

#recuperación de registros distintos
#puede evitar recuperar información repetida
> select distinct surname from sales_rep order by surname;
+----------+
| surname  |
+----------+
| Gordimer |
| Rive     |
| Rive     |
| Serote   |
| Smith    |
+----------+
5 rows in set (0.00 sec)

#count() function

> select count(surname) from sales_rep;
+----------------+
| count(surname) |
+----------------+
|              5 |
+----------------+
1 row in set (0.00 sec)

> select count(*) from sales_rep;
+----------+
| count(*) |
+----------+
|        5 |
+----------+
1 row in set (0.01 sec)

> select count(distinct surname) from sales_rep;
+-------------------------+
| count(distinct surname) |
+-------------------------+
|                       4 |
+-------------------------+
1 row in set (0.01 sec)

# sum(), avg(), min()

> select avg(comission) from sales_rep;
+----------------+
| avg(comission) |
+----------------+
|        11.4000 |
+----------------+
1 row in set (0.00 sec)

> select min(comission) from sales_rep;
+----------------+
| min(comission) |
+----------------+
|             10 |
+----------------+
1 row in set (0.00 sec)

> select sum(comission) from sales_rep;
+----------------+
| sum(comission) |
+----------------+
|             57 |
+----------------+
1 row in set (0.00 sec)


#calculos en una consulta

> SELECT 1 + 1;
+-------+
| 1 + 1 |
+-------+
|     2 |
+-------+
1 row in set (0.00 sec)

> select first_name,surname,comission + 1 from sales_rep;
+------------+----------+---------------+
| first_name | surname  | comission + 1 |
+------------+----------+---------------+
| Sol        | Rive     |            11 |
| Charlene   | Gordimer |            16 |
| Mike       | Serote   |            11 |
| Mongane    | Rive     |            11 |
| Mike       | Smith    |            13 |
+------------+----------+---------------+
5 rows in set (0.00 sec)

#eliminación de registtros
> delete from sales_rep where employee_number=5;
Query OK, 1 row affected (0.00 sec)

#cambiar los registros de una tabla
> update sales_rep set comission=12 where employee_number=1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

#DANGER! take where when using delete, if where statement is not used you will delete all the registrys with comission=12!!!!!!!

#eliminación de tablas y bases de datos
> create table comission(id INT);
Query OK, 0 rows affected (0.01 sec)

> drop table comission;
Query OK, 0 rows affected (0.00 sec)

> create database shortlived;
Query OK, 1 row affected (0.00 sec)

> drop database shortlived;
Query OK, 0 rows affected (0.00 sec)

#modificar la estructura de una tabla
> alter table sales_rep add date_joined date;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [firstdb]> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
| date_joined     | date        | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
5 rows in set (0.01 sec)
#Nota: date almacena datos en formato AAAA-MM-DD, si se desean introducir fechas enotros formatos como MM-DD-AAAA se nececitan realizar ajustes.

> alter table sales_rep add year_born year;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [firstdb]> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
| date_joined     | date        | YES  |     | NULL    |       |
| year_born       | year(4)     | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

#modificación de una definición de columna
> alter table sales_rep change year_born birthday date;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [firstdb]> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
| date_joined     | date        | YES  |     | NULL    |       |
| birthday        | date        | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

#para cambiar definición pero no el nombre de columna:
> alter table sales_rep change birthday birthday year;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [firstdb]> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
| date_joined     | date        | YES  |     | NULL    |       |
| birthday        | year(4)     | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

#se puede usar modify sin que resulte necesario repetir el nombre.
> alter table sales_rep modify birthday date;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

MariaDB [firstdb]> describe sales_rep;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| employee_number | int(11)     | YES  |     | NULL    |       |
| surname         | varchar(40) | YES  |     | NULL    |       |
| first_name      | varchar(30) | YES  |     | NULL    |       |
| comission       | tinyint(4)  | YES  |     | NULL    |       |
| date_joined     | date        | YES  |     | NULL    |       |
| birthday        | date        | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
6 rows in set (0.00 sec)
