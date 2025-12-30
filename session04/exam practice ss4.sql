create database exam;
use exam;
create table reader(
reader_id int primary key auto_increment,
reader_name varchar(100) not null,
phone varchar(15) unique,
register_date date default(current_date())
);
create table book(
book_id int primary key,
book_title varchar(150) not null,
author varchar (100),
publish_year int check(publish_year>=1900)
);
create table borrow(
reader_id int ,
book_id int,
borrow_date date default (current_date()),
return_date date,
foreign key(reader_id) references reader(reader_id),
foreign key(book_id) references book(book_id)
);

alter table reader
add email varchar(100) unique;
alter table book
modify author varchar(150);
alter table borrow
add check(return_date>=borrow_date);

insert into reader(reader_name,phone,register_date,email)
value ('Nguyễn Văn An','0901234567','2024-09-01','an.nguyen@gmail.com'),
('Trần Thị Bình','0912345678','2024-09-05','binh.tran@gmail.com'),
('Lê MinhcChâu','0923456789','2024-09-10','chau.le@gmail.com');

insert into book(book_id,book_title,author,publish_year)
value('101','Lập trình C căn bản','Nguyễn Văn A',2018),
('102','Cơ sở dữ liệu','Trần Thị B', 2020),
('103','Lập trình Java','Lê Minh C', 2019),
('104','Hệ quản trị MySQL','Phạm Văn D',2021);

insert into borrow(reader_id,book_id,borrow_date,return_date)
value(1,101,'2024-09-15',null),
(1,102,'2024-09-15','2024-09-25'),
(2,103,'2024-09-18',null);

update borrow
set return_date ='2024-10-01'
where reader_id=1;

update book
set publish_year=2023
where publish_year>=2021;

delete from borrow
where borrow_date < '2024-09-18';

select *from reader;
select *from book;
select *from borrow;


