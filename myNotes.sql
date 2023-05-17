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

#cambiar el nombre de una columna

> alter table sales_rep add enhancement_value int;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0


> alter table sales_rep rename cash_flow_specialist;
Query OK, 0 rows affected (0.01 sec)

> show tables;
+----------------------+
| Tables_in_firstdb    |
+----------------------+
| cash_flow_specialist |
+----------------------+
1 row in set (0.00 sec)

> alter table cash_flow_specialist rename to sales_rep;
Query OK, 0 rows affected (0.01 sec)

>show tables;
+-------------------+
| Tables_in_firstdb |
+-------------------+
| sales_rep         |
+-------------------+
1 row in set (0.00 sec)

> alter table sales_rep drop enhancement_value;
Query OK, 4 rows affected (0.01 sec)               
Records: 4  Duplicates: 0  Warnings: 0

> describe sales_rep;
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
6 rows in set (0.01 sec)

#uso de las funciones de fecha
> select  date_joined,birthday from sales_rep;
+-------------+----------+
| date_joined | birthday |
+-------------+----------+
| NULL        | NULL     |
| NULL        | NULL     |
| NULL        | NULL     |
| NULL        | NULL     |
+-------------+----------+
4 rows in set (0.00 sec)
#valores NULL indican que nunca se ha introducido nada en estos campos

> update sales_rep set date_joined='2023-05-16',birthday='1996-03-18' where employee_number=1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

> update sales_rep set date_joined='2018-07-09',birthday='1978-11-30' where employee_number=2;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

> update sales_rep set date_joined='2021-05-14',birthday='1971-06-18' where employee_number=3;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

> update sales_rep set date_joined='2022-11-23',birthday='1992-01-04' where employee_number=4;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0
> select  date_joined,birthday from sales_rep;
+-------------+------------+
| date_joined | birthday   |
+-------------+------------+
| 2023-05-16  | 1996-03-18 |
| 2018-07-09  | 1978-11-30 |
| 2021-05-14  | 1971-06-18 |
| 2022-11-23  | 1992-01-04 |
+-------------+------------+
4 rows in set (0.00 sec)

> select * from sales_rep;
+-----------------+----------+------------+-----------+-------------+------------+
| employee_number | surname  | first_name | comission | date_joined | birthday   |
+-----------------+----------+------------+-----------+-------------+------------+
|               1 | Rive     | Sol        |        12 | 2023-05-16  | 1996-03-18 |
|               2 | Gordimer | Charlene   |        15 | 2018-07-09  | 1978-11-30 |
|               3 | Serote   | Mike       |        10 | 2021-05-14  | 1971-06-18 |
|               4 | Rive     | Mongane    |        10 | 2022-11-23  | 1992-01-04 |
+-----------------+----------+------------+-----------+-------------+------------+
4 rows in set (0.01 sec)

#especificar fomato de fecha

> select date_format(date_joined, '%m/%d/%y') from sales_rep where employee_number=1;
+--------------------------------------+
| date_format(date_joined, '%m/%d/%y') |
+--------------------------------------+
| 05/16/23                             |
+--------------------------------------+
1 row in set (0.01 sec)

> select date_format(date_joined, '%W %M %e %y') from sales_rep where employee_number=1;
+-----------------------------------------+
| date_format(date_joined, '%W %M %e %y') |
+-----------------------------------------+
| Tuesday May 16 23                       |
+-----------------------------------------+
1 row in set (0.00 sec)

> select date_format(date_joined, '%a %D %b %Y') from sales_rep where employee_number=1;
+-----------------------------------------+
| date_format(date_joined, '%a %D %b %Y') |
+-----------------------------------------+
| Tue 16th May 2023                       |
+-----------------------------------------+
1 row in set (0.01 sec)

#recuperaciín de la fecha y hora actual
> select now(), current_date();
+---------------------+----------------+
| now()               | current_date() |
+---------------------+----------------+
| 2023-05-16 18:21:25 | 2023-05-16     |
+---------------------+----------------+
1 row in set (0.00 sec)

#now() devuelve la fecha y hora. Existe un tipo de columna llamado datetime que permite almacenar datos
#en el mismo formato AAAA-MM-DD HH:MM:SS en la tabla.

> select year(birthday) from sales_rep;
+----------------+
| year(birthday) |
+----------------+
|           1996 |
|           1978 |
|           1971 |
|           1992 |
+----------------+
4 rows in set (0.00 sec)

#month() y dayofmonth() para recuperar una parte específica de la fecha
> select month(birthday),dayofmonth(birthday) from sales_rep;
+-----------------+----------------------+
| month(birthday) | dayofmonth(birthday) |
+-----------------+----------------------+
|               3 |                   18 |
|              11 |                   30 |
|               6 |                   18 |
|               1 |                    4 |
+-----------------+----------------------+
4 rows in set (0.00 sec)

############################
# Consultas mas avanzadas  #
############################


#aplicar un nuevo encabezado a una columna con AS

> select surname,firtsname,month(birthday) as month,dayofmonth(birthday) as day from sales_rep order by month;
+----------+------------+-------+------+
| surname  | first_name | month | day  |
+----------+------------+-------+------+
| Rive     | Mongane    |     1 |    4 |
| Rive     | Sol        |     3 |   18 |
| Serote   | Mike       |     6 |   18 |
| Gordimer | Charlene   |    11 |   30 |
+----------+------------+-------+------+
4 rows in set (0.00 sec)

#combinacion de columnas con caoncat
> select concat(first_name, ' ',surname) as name, month(birthday) as month ,dayofmonth(birthday) as day from sales_rep order by month;
+-------------------+-------+------+
| name              | month | day  |
+-------------------+-------+------+
| Mongane Rive      |     1 |    4 |
| Sol Rive          |     3 |   18 |
| Mike Serote       |     6 |   18 |
| Charlene Gordimer |    11 |   30 |
+-------------------+-------+------+
4 rows in set (0.00 sec)

#como buscar el dia del año
> select dayofyear(date_joined) from sales_rep where employee_number=1;
+------------------------+
| dayofyear(date_joined) |
+------------------------+
|                    136 |
+------------------------+
1 row in set (0.00 sec)

###################################
# COMO TRABAJAR CON VARIAS TABLAS #
###################################

> create table customer(
	id int,
	first_name varchar(30),
	surname varchar(40) );
Query OK, 0 rows affected (0.01 sec)

> describe customer;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| id         | int(11)     | YES  |     | NULL    |       |
| first_name | varchar(30) | YES  |     | NULL    |       |
| surname    | varchar(40) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

> create table sales(
	code int,
	sales_rep int,
	customer int,
	value int );
Query OK, 0 rows affected (0.01 sec)

> describe sales;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| code      | int(11) | YES  |     | NULL    |       |
| sales_rep | int(11) | YES  |     | NULL    |       |
| customer  | int(11) | YES  |     | NULL    |       |
| value     | int(11) | YES  |     | NULL    |       |
+-----------+---------+------+-----+---------+-------+
4 rows in set (0.01 sec)

> load data local infile '/var/tmp/tab2.csv' replace into table customer fields terminated by ',' lines terminated by '\n'; 
Query OK, 4 rows affected (0.00 sec)                 
Records: 4  Deleted: 0  Skipped: 0  Warnings: 0
> select * from customer;
+------+------------+-------------+
| id   | first_name | surname     |
+------+------------+-------------+
|    1 | Yvonne     | Clegg       |
|    2 | Johnny     | Chaka-Chaka |
|    3 | Winston    | Powers      |
|    4 | Patricia   | Mankuku     |
+------+------------+-------------+
4 rows in set (0.00 sec)


> load data local infile '/var/tmp/tab3.csv' replace into table sales fields terminated by ',' lines terminated by '\n'; 
Query OK, 6 rows affected (0.01 sec)                 
Records: 6  Deleted: 0  Skipped: 0  Warnings: 0
> select * from sales;
+------+-----------+----------+-------+
| code | sales_rep | customer | value |
+------+-----------+----------+-------+
|    1 |         1 |        1 |  2000 |
|    2 |         4 |        3 |   250 |
|    3 |         2 |        3 |   500 |
|    4 |         1 |        4 |   450 |
|    5 |         3 |        1 |  3800 |
|    6 |         1 |        2 |   500 |
+------+-----------+----------+-------+
6 rows in set (0.00 sec)

###################################
# Combinación de dos o más tablas #
###################################

> select sales_rep,customer,value,first_name,surname from sales,sales_rep where code=1 and sales_rep.employee_number=sales.sales_rep;
+-----------+----------+-------+------------+---------+
| sales_rep | customer | value | first_name | surname |
+-----------+----------+-------+------------+---------+
|         1 |        1 |  2000 | Sol        | Rive    |
+-----------+----------+-------+------------+---------+
1 row in set (0.00 sec)

> select code,customer,value from sales_rep,sales where first_name='Sol' and surname='Rive' and sales.sales_rep=sales_rep.employee_number;
> select code,customer,value from sales,sales_rep where first_name='Sol' and surname='Rive' and sales_rep=employee_number;
> select sales.code,sales.customer,sales.value from sales,sales_rep where sales_rep.first_name='Sol' and sales_rep.surname='Rive' and sales.sales_rep=sales_rep.employee_number;
+------+----------+-------+
| code | customer | value |
+------+----------+-------+
|    1 |        1 |  2000 |
|    4 |        4 |   450 |
|    6 |        2 |   500 |
+------+----------+-------+
3 rows in set (0.00 sec

#realización de cálculos con fechas
> select year(now()) - year(birthday) from sales_rep;
#se pude usar current_date() en lugar de now()
> select year(current_date()) - year(birthday) from sales_rep;
+-----------------+----------+------------+-----------+-------------+------------+
| employee_number | surname  | first_name | comission | date_joined | birthday   |
+-----------------+----------+------------+-----------+-------------+------------+
|               1 | Rive     | Sol        |        12 | 2023-05-16  | 1996-03-18 |
|               2 | Gordimer | Charlene   |        15 | 2018-07-09  | 1978-11-30 |
|               3 | Serote   | Mike       |        10 | 2021-05-14  | 1971-06-18 |
|               4 | Rive     | Mongane    |        10 | 2022-11-23  | 1992-01-04 |
+-----------------+----------+------------+-----------+-------------+------------+
4 rows in set (0.00 sec)


> select year(now()) > year(birthday) from sales_rep where employee_number=1;
+------------------------------+
| year(now()) > year(birthday) |
+------------------------------+
|                            1 |
+------------------------------+
1 row in set (0.00 sec)

> select year(now()) < year(birthday) from sales_rep where employee_number=1;
+------------------------------+
| year(now()) < year(birthday) |
+------------------------------+
|                            0 |
+------------------------------+
1 row in set (0.00 sec)

> select right(current_date,5), right(birthday,5) from sales-rep;
#el 5 incluido dentro de la función right hace referencia al número de caracteres situados a la derecha de la cadena que devuelve la función
+-----------------------+-------------------+
| right(current_date,5) | right(birthday,5) |
+-----------------------+-------------------+
| 05-16                 | 03-18             |
| 05-16                 | 11-30             |
| 05-16                 | 06-18             |
| 05-16                 | 01-04             |
+-----------------------+-------------------+
4 rows in set (0.00 sec)

> select surname,first_name,(year(current_date) - year(birthday) - (right(current_date,5) < right(birthday,5))) as age from sales_rep;
+----------+------------+------+
| surname  | first_name | age  |
+----------+------------+------+
| Rive     | Sol        |   27 |
| Gordimer | Charlene   |   44 |
| Serote   | Mike       |   51 |
| Rive     | Mongane    |   31 |
+----------+------------+------+
4 rows in set (0.00 sec)

#agrupación de una consulta
> select sum(value) from sales;
+------------+
| sum(value) |
+------------+
|       7500 |
+------------+
1 row in set (0.00 sec)

>select sales_rep,sum(value) from sales group by sales_rep;
+-----------+------------+
| sales_rep | sum(value) |
+-----------+------------+
|         1 |       2950 |
|         2 |        500 |
|         3 |       3800 |
|         4 |        250 |
+-----------+------------+
4 rows in set (0.00 sec)

> select sales_rep,sum(value) as sum from sales group by sales_rep order by sum desc;
+-----------+------+
| sales_rep | sum  |
+-----------+------+
|         3 | 3800 |
|         1 | 2950 |
|         2 |  500 |
|         4 |  250 |
+-----------+------+
4 rows in set (0.00 sec)

> select sales_rep,count(*) as count from sales group by sales_rep order by count limit 1;
+-----------+-------+
| sales_rep | count |
+-----------+-------+
|         2 |     1 |
+-----------+-------+
1 row in set (0.00 sec)

> select first_name,surname,sales_rep,count(*) as count from sales,sales_rep where sales_rep=employee_number group by sales_rep,first_name,surname order by count limit 1;
+------------+---------+-----------+-------+
| first_name | surname | sales_rep | count |
+------------+---------+-----------+-------+
| Mike       | Serote  |         3 |     1 |
+------------+---------+-----------+-------+
1 row in set (0.00 sec)
