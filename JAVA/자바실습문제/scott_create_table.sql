drop table course1 purge;
drop table course2 purge;

create table course1 (
name varchar(15),
phone varchar(20),
age number(3)
);

create table course2 (
name varchar(15),
phone varchar(20),
age number(3)
);

insert into course1 values('둘리', '010-111-1111', 10);
insert into course1 values('또치', '010-222-2222', 11);
insert into course1 values('도우너', '010-333-3333', 12);
insert into course1 values('희동이', '010-444-4444', 6);

insert into course2 values('둘리', '010-111-1111', 10);
insert into course2 values('또치', '010-222-2222', 11);
insert into course2 values('토토로', '010-555-5555', 13);
insert into course2 values('짱구', '010-666-6666', 7);
insert into course2 values('듀크', '010-777-7777', 11);

commit;