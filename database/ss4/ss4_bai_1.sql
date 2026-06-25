create database quan_ly_sinh_vien;

use quan_ly_sinh_vien;

create table classes(
	class_id int primary key auto_increment,
    class_name varchar(60) not null,
    start_date datetime not null,
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

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from subjects 
where credit = (select max(credit) from subjects);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select * from subjects s
join marks m 
on s.sub_id = m.sub_id
where m.mark = (select max(mark) from marks);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.student_id, s.student_name, ifnull(avg(mark), 0) as avg_mark
from students s 
left join marks m
on s.student_id = m.student_id
group by s.student_id, s.student_name
order by avg_mark desc;
