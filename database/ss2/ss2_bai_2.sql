create database ss2_bai_tap_2;

use ss2_bai_tap_2;

create table customers(
	c_id int primary key,
    c_name varchar(50),
    c_age int
);

create table products(
	p_id int primary key,
    p_name varchar(50),
    p_price double
);

create table orders(
	o_id int primary key,
    c_id int,
    o_date date,
    o_total_price double,
    foreign key(c_id) references customers(c_id)
);

create table order_details(
	o_id int,
    p_id int,
    od_qty int,
    primary key(o_id, p_id),
    foreign key(o_id) references orders(o_id),
    foreign key(p_id) references products(p_id)
);