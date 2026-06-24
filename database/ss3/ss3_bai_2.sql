create database quan_ly_ban_hang;

use quan_ly_ban_hang;

create table customers(
	c_id int primary key,
    c_name varchar(25),
    c_age tinyint
);

create table products(
	p_id int primary key,
    p_name varchar(25),
    p_price int
);

create table orders(
	o_id int primary key,
    c_id int,
    o_date datetime,
    o_total_price int,
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

insert into customers (c_id, c_name, c_age)
values (1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

insert into orders (o_id, c_id, o_date, o_total_price)
values (1, 1, '2006-03-21', null),
(2, 2, '2006-03-23', null),
(3, 1, '2006-03-16', null);

insert into products (p_id, p_name, p_price)
values (1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

insert into order_details (o_id, p_id, od_qty)
values (1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select o_id, o_date, o_total_price
from orders;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.c_name, p.p_name
from customers c
inner join orders o
on c.c_id = o.c_id
inner join order_details ord
on o.o_id = ord.o_id
inner join products p
on ord.p_id = p.p_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.c_name
from customers c
left join orders o
on c.c_id = o.c_id
where o.o_id is null;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select o.o_id, o.o_date, sum(od.od_qty * p.p_price) as total_price
from orders o
inner join order_details od
on o.o_id = od.o_id
inner join products p
on od.p_id = p.p_id
group by o.o_id, o.o_date;