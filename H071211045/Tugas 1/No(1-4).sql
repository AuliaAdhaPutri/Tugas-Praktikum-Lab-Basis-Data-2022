-- Active: 1663738801222@@127.0.0.1@3306@db_office_sample
USE db_office_sample;

CREATE TABLE offices (
officeCode VARCHAR(10) NOT NULL,
city VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressline1 VARCHAR(50) NOT NULL,
addressline2 VARCHAR(50) NOT NULL,
state VARCHAR(50),
country VARCHAR(50) NOT NULL,
PRIMARY KEY(officeCode));

DESC offices;

ALTER TABLE offices MODIFY COLUMN phone INT(20) NOT NULL;

ALTER TABLE offices DROP COLUMN addressline2;