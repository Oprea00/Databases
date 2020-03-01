create database Game
go
use Game 
go 

create table Kindergartens(
	Kid int primary key identity,
	KName varchar(50),
	KCity varchar(50))

create table Children(
	Childid int primary key identity,
	Forename varchar(50),
	Surname varchar(50),
	Gender varchar(50),
	Birth date,
	Kid int foreign key references Kindergartens(Kid)
	)
drop table Games
create table Teachers(
	Teacherid int primary key identity,
	Forename varchar(50),
	Surname varchar(50),
	Kid int foreign key references Kindergartens(Kid))

create table Games(
	Gameid int primary key identity,
	GName varchar(50) unique,
	Difficulty int ,
	Age int)

drop table PlaySessions
create table PlaySessions(
	Playid int primary key identity,
	Gameid int foreign key references Games(Gameid),
	GDate date,
	GTime time)

drop table ChildrenPlay
create table ChildrenPlay(
	Childid int foreign key references Children(Childid),
	Playid int foreign key references PlaySessions(Playid),
	constraint pk_CPS primary key(Childid,Playid))


insert into Kindergartens values ('Nr1','Cluj napoca'),('Nr2','Cluj Napoca')
insert into Children values ('Mihu', 'Rebeca','female','2003-09-29' ,1),('Staicu','Tudor','male','1999-05-04',2),('Trif','Ionut','male','2000-02-07',2)
insert into Teachers values ('Ghita','Romanta',2),('Dehelean','Ovidiu',1)
insert into Games values ('LOL',4,7),('NuTESuparaFrate',1,3)
insert into PlaySessions values (1,'2003-09-29','16:00:00'),(2,'2020-01-29','10:00:00')
insert into ChildrenPlay values (1,2),(2,3)


create procedure DeleteGame @GName varchar(50)
as 
	declare @name varchar(50)
	
	delete from Games where @GName=GName
go

insert into Games values ('aaa',1,1)
exec DeleteGame 'aaa'
select * from Games

create view V1
as 
	select G.GName 
	from Games G inner join PlaySessions ps on G.Gameid=ps.Gameid inner join ChildrenPlay cp on ps.Playid=cp.Playid
	group by G.GName
	having count(*)=(select count(*) from Children)
go 

select * from V1 

create or alter function f1(@n int)
returns table
as 
	return 
	select distinct K.KName as ceva
	from  Kindergartens K inner join Teachers T on K.Kid=T.Kid 
	group by K.KName
	having count(TeacherId)>=@n

go

insert into Teachers values ('Ghita','Ioan',2)
select * from f1(2)