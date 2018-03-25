create tablespace f1soft
datafile 'C:\Oracle\oradata\f1soft.dbf' size 10M
autoextend on next 20M
encryption using 'AES256'
default storage (encrypt);

create table user_info(
user_id number,
first_name varchar2(25),
last_name varchar2(25),
email   varchar2(50),
password varchar2(25) encrypt using 'AES256',
constraint users_pk primary key(user_id)
);

alter table user_info add hire_date date;
alter table user_info modify (hire_date date default sysdate);

create sequence user_info_sq
    start with 0
    minvalue 0
    increment by 1
    nocache
    nocycle;
    
select user_info_sq.nextval from dual;    

insert into user_info values (user_info_sq.NEXTVAL, 'Saman', 'Munikar', 'samanmunikar@gmail.com', 'saman123');
insert into user_info values (user_info_sq.NEXTVAL, 'Suresh', 'Regmi', 'sureshregmi@gmail.com', 'suresh123');

insert into user_info values (user_info_sq.NEXTVAL, 'Sumin', 'Shakya', 'suminshakya@gmail.com', 'sumin123');
insert into user_info values (user_info_sq.NEXTVAL, 'Nitish', 'Shrestha', 'nitishshrestha@gmail.com', 'nitish123');
insert into user_info values (user_info_sq.NEXTVAL, 'Rowan', 'Siwakoti', 'rowanshiwakoti@gmail.com', 'rowan123');
insert into user_info values (user_info_sq.NEXTVAL, 'Dikendra', 'Siwakoti', 'dikendrasiwakoti@gmail.com', 'dikendra123');
insert into user_info values (user_info_sq.NEXTVAL, 'Bikash', 'Shrestha', 'bikashshrestha@gmail.com', 'bikash123');
insert into user_info values (user_info_sq.NEXTVAL, 'Bikram', 'samsong', 'ikramsamsong@gmail.com', 'bikram123');
insert into user_info values (user_info_sq.NEXTVAL, 'Rabin', 'Naga', 'rabinnaga@gmail.com', 'rabin123');
insert into user_info values (user_info_sq.NEXTVAL, 'Kritish', 'Bista', 'kritishbista@gmail.com', 'kritish123');

select * from user_info;

create table user_address (
user_address_id number not null,
user_info_id number,
permanent_address varchar2(50),
temporary_address varchar2(50),
zip_code number,
contact number,
constraint user_address_pk primary key(user_address_id),
constraint user_info_user_address_fk foreign key(user_info_id) references user_info(user_id)
);
 
 create index user_address_zip_code_idx on user_address(zip_code);

create sequence user_address_sq
    start with 0
    minvalue 0
    increment by 1
    nocache
    nocycle;
    
select user_address_sq.nextval from dual;
desc user_address;

insert into user_address values (user_address_sq.nextval, 1, 'Maligaun', 'Maligaun', 44630, 9849920293);
insert into user_address values (user_address_sq.nextval, 2, 'Kalimati', 'Dharan', 44500, 9849993202);
insert into user_address values (user_address_sq.nextval, 3, 'Mangalbazar', 'Mangalbazar', 44593, 9852415963);
insert into user_address values (user_address_sq.nextval, 4, 'Pulchowk', 'Pulchowk', 44640, 9851235963);
insert into user_address values (user_address_sq.nextval, 5, 'Putalisadak', 'Jhapa', 44596, 9848852633);
insert into user_address values (user_address_sq.nextval, 6, 'Putalisadak', 'Jhapa', 44596, 9846652315);
insert into user_address values (user_address_sq.nextval, 7, 'Kathmandu', 'Kathmandu', 44502, 9963215472);
insert into user_address values (user_address_sq.nextval, 8, 'Putalisadak', 'Jhapa', 44596, 9845632100);
insert into user_address values (user_address_sq.nextval, 9, 'Bhaktapur', 'Bhaktapur', 44500, 9851235684);
insert into user_address values (user_address_sq.nextval, 10, 'Chapagaun', 'Chapagaun', 44610, 9851236954);

select * from user_address;
drop sequence user_address_sq;

/*
explain plan for .......
select * from table(dbms_xplan.display); 
*/

CREATE TABLE designation (
designation_id number,
designation_name varchar2(50),
experience varchar2(25),
constraint designation_id_pk primary key(designation_id)
);

create sequence designation_sq
    start with 0
    minvalue 0 
    increment by 1
    nocache
    nocycle; 
    
desc designation;

insert into designation values (designation_sq.nextval, 'Java', 'Junior');
insert into designation values (designation_sq.nextval, 'Java', 'Intermediate');
insert into designation values (designation_sq.nextval, 'Java', 'Senior');
insert into designation values (designation_sq.nextval, 'Angular JS', 'Junior');
insert into designation values (designation_sq.nextval, 'Angular JS', 'Intermediate');
insert into designation values (designation_sq.nextval, 'Angular JS', 'Senior');
insert into designation values (designation_sq.nextval, 'DBA', 'Junior');
insert into designation values (designation_sq.nextval, 'DBA', 'Intermediate');
insert into designation values (designation_sq.nextval, 'DBA', 'Senior');

select * from designation;

create table salary (
salary_id number,
salary  number(8,2),
designation_id number,
constraint salary_pk primary key(salary_id),
constraint salary_designation_fk foreign key(designation_id) references designation(designation_id)
);

alter table salary modify (salary number encrypt using 'AES256');
 create sequence salary_sq
    start with 0
    minvalue 0
    increment by 1
    nocache
    nocycle;
    
insert into salary values (salary_sq.nextval, 15000, 1);
insert into salary values (salary_sq.nextval, 25000, 2);
insert into salary values (salary_sq.nextval, 50000, 3);
insert into salary values (salary_sq.nextval, 12000, 4);
insert into salary values (salary_sq.nextval, 20000, 5);
insert into salary values (salary_sq.nextval, 60000, 6);
insert into salary values (salary_sq.nextval, 10000, 7);
insert into salary values (salary_sq.nextval, 30000, 8);
insert into salary values (salary_sq.nextval, 70000, 9);

select * from salary;

create table attendance (
id  number,
user_info_id    number,
arrived_time    timestamp(5),
exit_time       timestamp(5),
constraint attendance_pk primary key(id),
constraint attendance_user_info_fk foreign key(user_info_id) references user_info(user_id)
);

alter table attendance modify (id number);

create sequence attendance_sq
    start with 0
    minvalue 0
    increment by 1
    nocache
    nocycle;
    
insert into attendance values(attendance_sq.nextval, 10, systimestamp, TIMESTAMP '2003-01-01 06:00:00 US/Pacific');

select * from attendance;