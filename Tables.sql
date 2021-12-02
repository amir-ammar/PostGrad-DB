create database postgradDB;



create table User
(
    int id primary key identity,
    email varchar(50) not null unique,
    password varchar(50) not null,
);


create Admin
(
    id int primary key,
    foreign key(id) references User
);


create table Student
(
    id int primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    type varchar(20) not null,
    faculty varchar(20) not null,
    address varchar(50) not null,
    GPA decimal(3,2) not null,
    foreign key(id) references User
);


create table GucianStudent
(
    id int primary key,
    undergrad_id int unique not null,
    foreign key (id) references Student on delete cascade on update cascade
);

create table NonGucianStudent
(
    id int primary key,
    undergrad_id int unique not null,
    foreign key (id) references Student on delete cascade on update cascade
);

create table GucStudentPhoneNumber
(
    id int,
    phone_number varchar(20),
    primary key(id, phone_number),
    foreign key (id) references GucianStudent on delete cascade on update cascade
);

create table NonGucStudentPhoneNumber
(
    id int,
    phone_number varchar(20),
    primary key(id, phone_number),
    foreign key (id) references NonGucianStudent on delete cascade on update cascade
);

create table Course
(
    id int primary key identity,
    fee decimal not null,
    creditHours int not null,
    code varchar(20) unique not null
);

create table Supervisor
(
    id int primary key,
    name varchar(20) not null,
    faculty varchar(20) not null,
    foreign key(id) references User
);

create table Thesis
(
    serial_Number varchar(30) primary key,
    field varchar(20) not null,
    type varchar(20) not null,
    title varchar(50) not null,
    startDate datetime not null,
    endDate datetime not null,
    defenseDate datetime not null,
    years as (endDate - startDate),
    grade decimal not null,
    payment_id int not null,
    Number_OF_Extensions int not null,
    foreign key (payment_id) references Payment on delete cascade on update cascade
);

create table Publication
(
    id int primary key identity,
    title varchar(50) not null,
    data datetime not null,
    place varchar(30) not null,
    accepted bit not null,
    host varchar(30) not null
);

create table Payment
(
    id int primary key identity,
    amount decimal not null,
    no_installments int not null,
    fund_percentage decimal not null
);

create table Examiner
(
    id int primary key identity,
    name varchar(20) not null,
    email varchar(30) not null,
    fieldOfWork varchar(30) not null,
    isNational bit not null
);


create table Defense
(
    serial_Number varchar(30),
    date datetime not null,
    location varchar(50) not null,
    grade decimal not null,
    primary key(serial_Number, date),
    foreign key(serial_Number) references Thesis on delete cascade on update cascade
);



-- here there 'no' attrs that i donot know what it is mean
create table GUCianProgressReport
(
    sid int,
    thesis_serial_number varchar(30),
    supid int,
    date datetime not null,
    state varchar(20) not null,
    eval varchar(100) not null,
    primary key(sid),
    foreign key(thesis_serial_number) references Thesis on delete cascade on update cascade,
    foreign key (sid) references GucianStudent on delete cascade on update cascade,
    foreign key (supid) references Supervisor on delete cascade on update cascade
);


-- here there 'no' attrs that i donot know what it is mean
create table NonGUCianProgressReport
(
    sid int,
    thesis_serial_number varchar(30),
    supid int,
    date datetime not null,
    state varchar(20) not null,
    eval varchar(100) not null,
    primary key(sid),
    foreign key(thesis_serial_number) references Thesis on delete cascade on update cascade,
    foreign key (sid) references GucianStudent on delete cascade on update cascade,
    foreign key (supid) references Supervisor on delete cascade on update cascade
);

create table Installment
(
    date datetime,
    paymentid int,
    amount decimal not null,
    done bit not null,
    primary key(date, paymentid),
    foreign key (paymentid) references Payment on delete cascade on update cascade
);

create table NonGucianStudentPayForCourse
(
    sid int,
    cid int,
    paymentNo int,
    primary key(sid, cid, paymentNo),
    foreign key(sid) references NonGucianStudent on delete cascade on update cascade,
    foreign key(cid) references Course on delete cascade on update cascade,
    foreign key(paymentNo) references Payment on delete cascade on update cascade
);

create table NonGucianStudentTakeCourse
(   
    sid int,
    cid int,
    grade decimal not null,
    primary key(sid, cid),
    foreign key(sid) references NonGucianStudent on delete cascade on update cascade,
    foreign key(cid) references Course on delete cascade on update cascade

);


create table GUCianStudentRegisterThesis
(
    sid int,
    serial_number varchar(30),
    supid int,
    primary key(sid, serial_number, supid),
    foreign key(sid) references GucianStudent on delete cascade on update cascade,
    foreign key(serial_number) references Thesis on delete cascade on update cascade,
    foreign key(supid) references Supervisor on delete cascade on update cascade
);

create table NonGUCianStudentRegisterThesis
(
    sid int,
    serial_number varchar(30),
    supid int,
    primary key(sid, serial_number, supid),
    foreign key(sid) references NonGucianStudent on delete cascade on update cascade,
    foreign key(serial_number) references Thesis on delete cascade on update cascade,
    foreign key(supid) references Supervisor on delete cascade on update cascade
);

create table ExaminerEvaluateDefense
(
    date datetime,
    serial_number varchar(30),
    examinerid int,
    comment varchar(255),
    primary key (date, serial_number, examinerid),
    foreign key(serial_number) references Defense on delete cascade on update cascade,
    foreign key(examinerid) references Examiner on delete cascade on update cascade,
    foreign key(date) references Defense on delete cascade on update cascade
);

create table ThesisHasPublication
(
    serial_number varchar(30),
    subid int,
    primary key(serial_number, subid),
    foreign key(serial_number) references Thesis on delete cascade on update cascade,
    foreign key(subid) references Publication on delete cascade on update cascade

);