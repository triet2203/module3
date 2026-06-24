create database bai_tap;

use bai_tap;

create table class(
	id int,
    name varchar(200)
);

create table teacher(
	id int,
    name varchar(200),
    age int,
    country varchar(50)
);

select * from class;

alter table class add primary key (id);

insert into class values (1, 'triet');

desc class;