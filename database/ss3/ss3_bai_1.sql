create database QuanLySinhVien;

use QuanLySinhVien;

create table classes(
	class_id int primary key auto_increment,
    class_name varchar(60) not null,
    star_date datetime not null,
    status bit
);

create table students(
	student_id int primary key auto_increment,
    student_name varchar(30) not null,
    address varchar(50),
    phone varchar(20),
    status bit,
    class_id int not null,
    foreign key(class_id) references classes(class_id)
);

create table subjects(
	sub_id int primary key auto_increment,
    subname varchar(30) not null,
    credit tinyint not null default 1 check (credit >= 1),
    status bit default 1
);

create table marks(
	mark_id int primary key auto_increment,
    sub_id int not null,
    student_id int not null,
    mark float default 0 check (mark between 0 and 100),
    exam_times tinyint default 1,
    foreign key(sub_id) references subjects(sub_id),
    foreign key(student_id) references students(student_id)
);

insert into classes
values (1, 'A1', '2008-12-20', 1);
insert into classes
values (2, 'A2', '2008-12-22', 1);
insert into classes
values (3, 'A3', current_date, 0);

insert into students (student_name, address, phone, status, class_id)
values ('Hung', 'Ha Noi', '0912113113', 1, 1);
insert into students (student_name, address, status, class_id)
values ('Hoa', 'Hai Phong', 1, 1);
insert into students (student_name, address, phone, status, class_id)
values ('Manh', 'HCM', '0123123123', 0, 2);

insert into subjects
values (1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

insert into marks (sub_id, student_id, mark, exam_times)
values (1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select *
from students
where student_name like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select *
from classes
where month(star_date) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select *
from subjects
where credit between 3 and 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update students
set class_id = 2
where student_id = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select s.student_name,
		sub.subname,
        m.mark
from marks m
inner join students s
on s.student_id = m.student_id
inner join subjects sub
on m.sub_id = sub.sub_id
order by m.mark desc, s.student_name asc;