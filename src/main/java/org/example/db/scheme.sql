create database ComplaintDB;
use ComplaintDB;

create table employee
(
    username        varchar(255) not null
        primary key,
    address         varchar(255) null,
    confirmPassword varchar(255) null,
    email           varchar(255) null,
    fullName        varchar(255) null,
    password        varchar(255) null,
    profilePic      varchar(255) null,
    role            varchar(255) null
);

create table complaints
(
    complaint_id      int auto_increment
        primary key,
    adminRemark       varchar(255) null,
    description       varchar(255) null,
    priority          varchar(255) null,
    status            varchar(255) null,
    title             varchar(255) null,
    employee_username varchar(255) null,
    constraint FK9htmv3ve6fxg71abvc4xdlonu
        foreign key (employee_username) references employee (username)
);

