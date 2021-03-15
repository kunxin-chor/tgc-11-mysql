/* logging in */
/* the root account has been created by default */
mysql -u root

/* see all databases */
show databases;

/* create a database */
create database swimming;

/* switch database */
use swimming;

/* show all tables */
show tables;

/* create table */
create table Parents (
    parent_id int unsigned auto_increment primary key,
    surname varchar(50) not null,
    given_name varchar(50) not null,
    email varchar(350) not null
) engine=innodb;

/* insert one row into the table */
insert into Parents (surname, given_name, email)
    values ('Phua', 'Chua Kang', 'chukang@phua.com.sg');

insert into Parents (surname, given_name, email)
 values ('Lim', 'Megan', 'meganlim@fake.com.sg');

/* see all the rows in a table */
select * from Parents;

create table Certificates (
    certificate_id int unsigned auto_increment primary key,
    title varchar(100) not null
) engine=innodb;

insert into Certificates (title) 
    values ('Basic Swimming'),
           ('Basic Lifesaving'),
           ('Advanced Lifesaving');

select * from Certificates;

create table Venues (
    venue_id tinyint unsigned auto_increment primary key,
    `name` varchar(100)  not null,
    `address` varchar(500) not null
) engine=innodb;

insert into Venues (`name`, address) values
    ('Yishun Swimming Complex', 'Yishun Ave 4'),
    ('Ang Mio Ko Swimming Complex', 'Ang Mio Kio Ave 1');


describe venues; 