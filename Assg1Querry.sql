create database PersonalTrainingProgram 
go
use PersonalTrainingProgram
go

create table Client(
	ClientID int primary key,
	Name varchar(50),
	Phone int,
	Email varchar(50) )


create table PayBill(
	PayID int foreign key references Client(ClientID),
	Amount float,
	constraint pk_PayBill primary key(PayID)) 

create table Measurements(
	MeasurementsID int foreign key references Client(ClientID),
	Chest int,
	Arms int,
	Waist int
	constraint pk_MeasurementsID primary key(MeasurementsID))


create table CaloricGoal(
	CaloricGoalID int foreign key references Client(ClientID),
	NumberOfCalories int,
	constraint pk_CaloricGoalID primary key(CaloricGoalID))
	

create table Exercise(
	ExerciseID int primary key,
	Name varchar(50),
	Description varchar(50),
	Reps int,
	Sets int)

create table Routine(
	RoutineID int primary key,
	Name varchar(50),
	Description varchar(50),
	ExerciseID int foreign key references Exercise(ExerciseID))

create table ObjectiveAchieved(
	ObjectiveID int foreign key references Client(ClientID),
	Achieved bit,
	constraint pk_ObjectiveID primary key(ObjectiveID))


create table ClientRoutine(
	ClientID int foreign key references Client(ClientID),
	RoutineID int foreign key references Routine(RoutineID),
	Constraint pk_ClientRoutine primary key (ClientID,RoutineID))


create table FinalObjective(
	FinalObjectiveID int foreign key references ObjectiveAchieved(ObjectiveID) ,
	ObjectiveType varchar(30),
	constraint pk_FinalObjective primary key (FinalObjectiveID))


create table Nutrients(
	NutrientsID int primary key,
	Protein int,
	Carbohydrates int,
	Fats int,
	CaloricGoalID int foreign key references CaloricGoal(CaloricGoalID))


