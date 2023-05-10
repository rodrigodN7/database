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

