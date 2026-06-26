create database demo;

use demo;

	create table products(
		id int primary key,
		product_code varchar(10),
		product_name varchar(20),
		product_price double,
		product_amount int,
		product_description varchar(50),
		product_status varchar(20)
	);

INSERT INTO products
(id, product_code, product_name, product_price, product_amount, product_description, product_status)
VALUES
(1, 'P001', 'Dell Inspiron', 18500000, 15, 'Laptop Dell Core i5 8GB RAM', 'Available'),
(2, 'P002', 'Asus Vivobook', 17200000, 20, 'Laptop Asus Core i5 16GB RAM', 'Available'),
(3, 'P003', 'Logitech M331', 350000, 120, 'Wireless silent mouse', 'Available'),
(4, 'P004', 'Logitech K120', 250000, 80, 'USB wired keyboard', 'Available'),
(5, 'P005', 'LG Monitor 24', 3200000, 30, '24 inch Full HD IPS monitor', 'Available'),
(6, 'P006', 'Sony WH-CH520', 1290000, 40, 'Bluetooth headphone', 'Available'),
(7, 'P007', 'Samsung SSD', 2100000, 25, '1TB NVMe SSD', 'Available'),
(8, 'P008', 'Kingston USB', 180000, 0, '64GB USB 3.2', 'Out of Stock'),
(9, 'P009', 'Canon LBP2900', 3650000, 10, 'Laser printer', 'Available'),
(10, 'P010', 'Webcam C920', 1850000, 12, 'Full HD webcam', 'Available');

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index idx_product_code
on products(product_code);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create index idx_name_price
on products(product_name, product_price);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain
select *
from products
where product_code = 'P005';

explain
select *
from products
where product_name = 'LG Monitor 24'
and product_price = 3200000;

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view view_products as
select product_code, product_name, product_price, product_status
from products;

select * from view_products;

-- Tiến hành sửa đổi view
alter view view_products as
select product_code, product_name, product_price, product_status
from products
where product_status = 'Available';

-- Tiến hành xoá view
drop view view_products;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure getAllProducts()
begin
	select *
    from products;
end //
delimiter ;

call getAllProducts();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure addProduct(
	in p_id int,
    in p_code varchar(10),
    in p_name varchar(20),
    in p_price double,
    in p_amount int,
    in p_description varchar(50),
    in p_status varchar(20)
)
begin
	insert into products(
		id,
        product_code,
        product_name,
        product_price,
        product_amount,
        product_description,
        product_status
    )
    values(
		p_id,
        p_code,
        p_name,
        p_price,
        p_amount,
        p_description,
        p_status
    );
end //
delimiter ;

call addProduct(11, 'P011', 'Acer Aspire', 15500000, 18, 'Laptop Acer Core i5', 'Available');

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure updateProduct(
	in p_id int,
    in p_code varchar(10),
    in p_name varchar(20),
    in p_price double,
    in p_amount int,
    in p_description varchar(50),
    in p_status varchar(20)
)
begin
	update products
    set
        product_code = p_code,
        product_name = p_name,
        product_price = p_price,
        product_amount = p_amount,
        product_description = p_description,
        product_status = p_status
	where id = p_id;
end //
delimiter ;

call updateProduct(1, 'P001', 'Dell Inspiron 15', 18900000, 20, 'Laptop Dell Core i5 16GB RAM', 'Available');

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure deleteProduct(
	in p_id int
)
begin
	delete
    from products
    where id = p_id;
end //
delimiter ;

call deleteProduct(11);

show procedure status
where db = database();

show create procedure updateProduct;