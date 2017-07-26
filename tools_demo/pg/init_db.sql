create database PostgresDemo;

CREATE TABLE employee (
   id       SERIAL,       --emp id; auto-increment when empty
   name     varchar(20),  --emp name
   dept     varchar(10),  --department
   salary   int           --employee's salary
);

INSERT INTO employee VALUES (100,'Thomas','Sales',5000);
INSERT INTO employee VALUES (200,'Jason','Technology',5500);
INSERT INTO employee VALUES (300,'Mayla','Technology',7000);
INSERT INTO employee VALUES (400,'Nisha','Marketing',9500);
INSERT INTO employee VALUES (500,'Randy','Technology',6000);

SELECT * FROM employee;