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

/* Foreign keys */

create table Students (
    student_id int unsigned auto_increment primary key,
    surname varchar(100) not null,
    given_name varchar(100) not null,
    date_of_birth date not null,
    parent_id int unsigned not null,
    foreign key(parent_id) references Parents(parent_id)
) engine=innodb;

insert into Students (surname, given_name, date_of_birth, parent_id)
   values ('Phua', 'Anthony', '1990-06-21', 1);

insert into Students (surname, given_name, date_of_birth, parent_id)
   values ('Lim', 'Mary', '1999-06-21', 5);

insert into Students (surname, given_name, date_of_birth, parent_id)
   values ('Sue', 'Mary', '1999-06-21', 100);

create table Sessions (
    session_id int unsigned auto_increment primary key,
    session_date datetime not null,
    venue_id tinyint unsigned,
    foreign key(venue_id) references Venues(venue_id) on delete cascade
) engine=innodb;

create table CertificateStudent (
    certificate_student_id int unsigned auto_increment primary key,
    student_id int unsigned,
    certificate_id int unsigned,
    award_date date not null,
    foreign key (student_id) references Students(student_id),
    foreign key (certificate_id) references Certificates(certificate_id)
) engine = innodb;

insert into CertificateStudent (student_id, certificate_id, award_date)
  values (2, 1, '2021-01-21');

/* add a new column to an existing table */
alter table Students add gender varchar(1) not null;

/* rename a column */
alter table Students rename column surname to last_name;
alter table Students rename column given_name to first_name;

/* modify the definition of a column */
alter table Students modify gender varchar(1);

/* assume we have a table named `Fake` and we want to drop it */
drop table Fake;

/* to create a new row, we use insert */

/* to delete a row, we use DELETE FROM */
delete from Parents where parent_id = 3;

/* to modify a row, we use UPDATE */
update Students set first_name = "Susan" where student_id = 2;

/* the following will not work because of foreign key constraints */
update Students set parent_id = 100 where student_id = 2;