create database minions;

-------------Adding Tables to Minions database------------

create table minions(id int,name nvarchar(300),Age int, constraint pk_minions primary key(id));

create table towns(id int,name nvarchar(50) constraint pk_towns primary key(id));

-----------------Altering minions table to add new column townid that references id of the towns table------

alter table minions add townid int;

-----adding foreign key constraint to townid column-----

alter table minions add constraint fk_townid foreign key (townid) references towns(id);

--------inserting data into minions table and Towns table---------

select * from minions;
select * from towns;

insert into towns values(1,'sofia');
insert into towns values(2,'peter');
insert into towns values(3,'victoria');

insert into minions values(1,'kevin',22,1);
insert into minions values(2,'bob',15,3);
insert into minions values(3,'steward',null,2);

----Truncate the table minions-----

truncate table minions;

----Drop all tables from minions database-----

drop table minions;
drop table towns;

----create a table people------

create table people(id int unique identity not null,
name varchar(200) not null,
picture varbinary check(datalength(picture)<=2*1024*1024) ,
Height numeric(4,2),
[Weight] numeric(4,2),
gender CHAR(1) not null CHECK(gender='M' OR gender='F'),
birthdate date not null,
biography nvarchar(max));

alter table people add primary key(id);

insert into people values('uvw', null,15.2,45.6,'M','1933-09-26','I am swedish'),
('abc', null,17.2,90.6,'M','1933-09-26','I am german'),
('xyz', null,18.4,75.6,'F','1933-09-26','I am indian'),
('pqr', null,15.4,65.4,'F','1933-09-26','I am american'),
('rst', null,15.2,45.6,'F','1933-09-26','I am african');

select * from people;

----------create table users-----------

create table users(id bigint unique not null identity(1,1),
username char(30) not null unique,
password char(26) not null, 
profilepicture varbinary check(datalength(profilepicture)<=900*1024),
lastLoginTime datetime,
IsDeleted bit not null default(0));

insert into users (username,password,profilepicture,IsDeleted) values('abc','dfdsfs',null,0),
('xyz','sdfdfgs',null,1),
('rty','sdfdsf',null,0),
('cxvcxv','fdfgfd',null,0),
('ruyut','gdfgghg',null,1);

select * from users;
 
alter table users add constraint pk_users primary key(id);

alter table users add lastlogintime datetime;

--------------change the primary key-------------------------

alter table users drop constraint pk_users ;

alter table users add constraint pk_users primary key(Id, username);

-------------Add the check constraint--------------------

alter table users add constraint passwordcheck check(len(Password) >= 5);

--------------set default value of a field----------------

alter table users add constraint DF_users default getDate() for lastlogintime;

---------------set the unique field(grade=pass!)----------------

alter table users drop constraint pk_users;

alter table users add constraint pk_users primary key(id);

alter table users add constraint uni_users unique(username);

alter table users add constraint check_users check(len(username)>=3);

insert into users(username,password) values('dd','tyuyuiyiu');  (will throw error because of the constraint username should be 3 0r more characters)

insert into users(username,password) values('ddg','tyuyuiyiu');

------------create movies database----------------

create database movies;

use movies;

create table directors(Id int primary key,DirectorName nvarchar(50) not null,Notes nvarchar(max));

create table Genres(Id int primary key,GenreName nvarchar(60) not null,Notes nvarchar(max));

create table categories(Id int primary key,CategoryName nvarchar(60) not null,Notes nvarchar(max));

create table Movies(Id int primary key,
title nvarchar(50),
DirectorId int foreign key references directors(Id),
CopyrightYear date,
length int,
GenreId int foreign Key references Genres(Id),
CategoryId int foreign key references Categories(Id),
Rating numeric(3,2),
Notes nvarchar(max));

insert into directors values(1,'abc','hjdhfkjh'),
(2,'ghjf','ghjfhg'),
(3,'hfhf',null),
(4,'tyty','ghghh'),
(5,'fdff','ytrr')

insert into genres values(1,'ggh','fhfh'),
(2,'ghgh','hghg'),
(3,'tutyu','gfjgf'),
(4,'dffd','dfgf'),
(5,'dfgfd','ffgfd')

insert into categories values(1,'gfg','dfgdf'),
(2,'ffh',null),
(3,'hgfh','yuyt'),
(4,'fdh','dfgdf'),
(5,'ghgfh',null)

insert into Movies values(1,'dfgfg',2,'1988-05-23',34,2,3,3.4,'dfhgh'),
(2,'gfdfg',4,'2006-07-09',56,3,5,5.6,'ghjdfhd'),
(3,'dfgfdg',3,'2007-09-07',34,4,5,5.6,'fdgdf'),
(4,'fdgfd',5,'1988-09-06',67,4,3,2.3,'dfgdfg'),
(5,'fdgjkfd',3,'2004-09-09',23,5,2,3.2,'fgfg')

select * from movies;

---------create car rental database-----------------

create database CarRental;

use CarRental;

create table Categories(Id int primary key identity not null,
CategoryName nvarchar(30) not null,
DailyRate int not null,
WeeklyRate int not null,
MonthlyRate int not null,
WeekendRate int not null);


insert into Categories values('ada',34,23,56,67),
('ytyt',56,78,45,34),
('tytu',67,67,34,23)

select * from Categories;

create table Cars(id int primary key identity not null,
PlateNumber nvarchar(20) not null,
manufacturer nvarchar(30),
model nvarchar(20),
CarYear date,
CategoryId int foreign key references Categories(Id),
doors int,
picture varbinary(max),
condition char(1) not null check(condition='G' or condition='B'),
available bit default 1);


insert into Cars values('RT44646','fhdhdh','tyrtyr','2003-09-09',1,4,null,'G',1),
('AS3435','dfhdh','fgjfj','2005-04-09',1,4,null,'B',0),
('DF57467','rtytry','rtyrty','2008-09-30',3,5,null,'G',1)

select * from cars


CREATE TABLE Employees
(Id int primary key not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
title nvarchar(50) not null,            
Notes nvarchar(max));

insert into Employees values(1,'fsdfs','dsfsdf','sfdsf','vvsdv'),
(2,'dsfds','dsfds','dfsdf','dsfsdf'),
(3,'sdfdsf','dsfdsf','rwerwe','ttsdf')

create table Customers(Id int not null primary key,
DriverLicenceNumber nvarchar(50) not null unique,
FullName nvarchar(50) NOT NULL,
Address nvarchar(300),
city nvarchar(50),
ZIPCode nvarchar(50),
Notes nvarchar(max));

insert into customers values(1,'34rtytry','dffdg','gsdgsd','dfd','4565474','gfhfghfgh'),
(2,'34rtbcvbcry','dffdg','gsdgsd','dfd','4565474','gfhfghfgh'),
(3,'35rttyuytutry','dffdg','gsdgsd','dfd','4565474','gfhfghfgh')

create table RentalOrders(
Id int primary key identity not null,
EmployeeId int not null Foreign Key references Employees(Id),
CustomerId int not null Foreign key references Customers(Id),
CarId int not null Foreign key references Cars(Id),
TankLevel numeric(4,2),             
KilometrageStart int,
KilometrageEnd int,
TotalKilometrage int,             
StartDate Date not null,
EndDate Date Not Null,
TotalDays int not null,
RateApplied decimal(10, 2),
TaxRate decimal(10, 2),
OrderStatus nvarchar(50),
Notes nvarchar(max));
 

insert into RentalOrders values(1,1,2,34.5,10,34,24,'2014-09-06','2014-11-04',58,34.6,2.5,'sdffdsg',null),
(2,2,3,34.5,10,34,24,'2014-09-06','2014-11-04',58,34.6,2.5,'sdffdsg',null),
(1,1,1,34.5,10,34,24,'2014-09-06','2014-11-04',58,34.6,2.5,'sdffdsg',null)

-------------Create a hotel database---------------

create database hotel;
 
use hotel;

create table Employees
(Id int primary key NOT NULL,
FirstName nvarchar(50) NOT NULL,
LastName  nvarchar(50) NOT NULL,
Title nvarchar(250) NOT NULL,
Notes nvarchar(max));

insert into Employees values(1,'sadsa','ssfsdf','afafaf','sdfdsfdsf'),
(2,'retert','cvbcvb','trytdf','sdgfg'),
(3,'uyiyui','hgfhfg','vbnbcn','hjfh')

create table customers(AccNumber int primary key NOT NULL,
FirstName nvarchar(50) NOT NULL,
LastName nvarchar(50) NOT NULL,
PhoneNumber nvarchar(50),
EmergencyName nvarchar(50) NOT NULL,
EmergencyNumber int NOT NULL,
Notes nvarchar(50));

insert into customers values(1,'sdfds','sdsf','456456456','tryrty','5555','fdgfdg'),
(2,'fgdfgd','gfdgdfg','7567567567','trytrr','6666','gfdfgsf'),
(3,'fdsfsdf','retfdg','5757675','dfgdfg','6666','gghfhf')

select * from customers;

create table RoomStatus(RoomStatus nvarchar(50) primary key NOT NULL,
Notes nvarchar(max));

insert into RoomStatus values('free',null),
('occupied','fdfgdf'),
('reserverd','sdfdsf')

create table RoomTypes
(RoomType nvarchar(50) primary key not null,
Notes nvarchar(max));

insert into RoomTypes values('Ac',null),
('non-Ac','fgdfg'),
('five-star','cdfgdf')

create table BedTypes
(BedType nvarchar(50)primary key not null,
Notes nvarchar(max));

insert into BedTypes values('single','sfsdfsd'),
('double','sddsfsd'),
('triple','dsfdsf');

create table Rooms
(RoomNumber int primary key not null,
RoomType nvarchar(50) not null foreign key references Roomtypes(roomtype),
BedType nvarchar(50) not null foreign key references Bedtypes(bedtype),
Rate decimal(10, 2) not null,
RoomStatus nvarchar(50) not null foreign key references roomstatus(roomstatus),
Notes nvarchar(max));

insert into Rooms Values(1,'Ac','single',200.60,'free','fdgfd'),
(2,'non-Ac','double',300,'reserverd',null),
(3,'five-star','triple',500,'occupied',null)

create table Payments
(Id int primary key not null,
EmployeeId int not null foreign key references Employees(id),
PaymentDate date not null,
AccountNumber int not null,
FirstDateOccupied date not null,
LastDateOccupied  date not null,
TotalDays int not null,
AmountCharged decimal(10, 2)not null,
TaxRate decimal(10, 2)not null,
TaxAmount decimal(10, 2)not null,
PaymentTotal decimal(10, 2)not null,
Notes nvarchar(max));

insert into Payments values(1,1,'2006-09-06',05657656,'2015-09-04','2015-07-06',2,500,25,525,500,null),
(2,2,'2007-04-05',7686898,'2004-07-09','2004-09-09',2,300,56,67,300,'jhgjgj'),
(3,3,'2003-09-07',657657576,'2006-04-09','2006-08-09',4,400,56,23,400,null)

CREATE TABLE Occupancies
(Id int primary key NOT NULL,
EmployeeId int not null foreign key references Employees(id),
DateOccupied date not null,
AccountNumber int not null foreign key references customers(accnumber),
RoomNumber int not null foreign key references rooms(roomnumber),
RateApplied decimal(10, 2),
PhoneCharge int not null,
Notes nvarchar(max));

insert into occupancies values(1,1,'2003-09-08',1,1,450.80,67,null),
(2,2,'2006-07-09',1,2,678.90,34,'ghjgh'),
(3,2,'2008-05-06',2,3,568,78,null)

-------------create Lexicon Database----------------

create database lexicon;

use lexicon;

create table Towns(Id int primary key identity NOT NULL,
Name nvarchar(50) NOT NULL);

create table Addresses(Id int primary key identity NOT NULL,
AddressText nvarchar(100) NOT NULL,
TownId int foreign key references towns(id) NOT NULL);

create table Departments(Id int primary key identity NOT NULL,
[Name] nvarchar(50) NOT NULL);

create table Employees(Id int primary key identity NOT NULL,
FirstName nvarchar(50) NOT NULL,
MiddleName nvarchar(50),
LastName nvarchar(50),
JobTitle nvarchar(50) NOT NULL,
DepartmentId int foreign key references Departments(Id) NOT NULL,
HireDate date,
Salary decimal(10, 2) NOT NULL,
AddressId int foreign key references Addresses(Id));

----------------Back up database--------------

backup database lexicon TO DISK = 'E:\lexicon-backup.bak';

use bank;

drop database lexicon;

restore  database lexicon FROM DISK = 'E:\lexicon-backup.bak';

--------Basic insertion into Lexicon database tables ------------------

insert into Towns values('sofia'),('plovdiv'),('varna'),('burgas')

insert into Departments values('Engineering'),('Sales'),('marketing'),('software development'),('quality assurance')

insert into Employees(FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary) values('mel','gibson','gibson','.net developer',4,CONVERT(DATE, '01/02/2013', 103),3500),
('chuk','norris','norris','senior engineer',1,convert(date,'02/03/2004', 103),4000),
('greta','garbo','garbo','intern',5,convert(date,'28/08/2016', 103),525.25),
('meryl','strep','strep','ceo',2,convert(date,'09/12/2007', 103),3000),
('peter','pan','pan','intern',3,convert(date,'28/08/2016', 103),599.88)

select * from Employees;


---------------select all feilds---------------

select * from towns;

select * from departments;

select * from Employees;

----------select all feilds and order them---------------

select * from towns order by name asc;

select * from departments order by name asc;

select * from Employees order by salary desc;

---------select some feilds-----------

select name from towns order by name asc;

select name from departments order by name asc;

select firstname,lastname,jobtitle,salary from Employees order by salary desc;

--------increase employees salary---------------

update Employees set Salary *= 1.10;

select Salary from Employees;

