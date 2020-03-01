use PersonalTrainingProgram
go

-------------------------------------INSERT------------------------------------------------------
insert into Client(ClientID,Name,Phone,Email) values (1,'Ionut',0761234567,'ionut1@gmail.com')
insert into Client(ClientID,Name,Phone,Email) values (2,'Raul',0762236567,'raul2@gmail.com')
insert into Client(ClientID,Name,Phone,Email) values (3,'Tudor',0761294967,'tudor3@gmail.com')
insert into Client(ClientID,Name,Phone,Email) values (4,'Ciprian',0761136567,'ciprian4@gmail.com')
insert into Client(ClientID,Name,Phone,Email) values (5,'Claudiu',0761666567,'claudiu5@gmail.com')


insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (1,'Bench_press','with_the_bar_or_dumbell',8,4)
insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (2,'Incline_press','with the bar or dumbells',8,4)
insert into Exercise(ExerciseID,Name,Reps,Sets) values (3,'Deadlift',5,5)
insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (4,'Shoulder_press','with the bar or dumbells',10,4)
insert into Exercise(ExerciseID,Name,Description,Sets) values (5,'Pull-ups', 'with additional weight',5)
insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (6,'Triceps_extensions','with cable',12,4)
insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (7,'Squats','with bar or dumbell',5,5)
insert into Exercise(ExerciseID,Name,Description,Reps,Sets) values (8,'Biceps Curls','with bar or dumbell',10,5)


insert into Routine(RoutineID,Name,Description,ExerciseID) values (1,'Push','chest,triceps,shoulder',1)
insert into Routine(RoutineID,Name,Description,ExerciseID) values (2,'Pull','back,biceps',3)
insert into Routine(RoutineID,Name,Description,ExerciseID) values (3,'Legs','legs',7)
insert into Routine(RoutineID,Name,Description,ExerciseID) values (4,'Biceps','biceps',8)
insert into Routine(RoutineID,Name,Description,ExerciseID) values (5,'Triceps','triceps',6)
--this one violates integrity constraints
insert into Routine(RoutineID,Name,Description,ExerciseID) values (1,'Push','chest,triceps,shoulder',1)

insert into ClientRoutine(ClientID,RoutineID) values (1,4)
insert into ClientRoutine(ClientID,RoutineID) values (1,3)
insert into ClientRoutine(ClientID,RoutineID) values (2,1)
insert into ClientRoutine(ClientID,RoutineID) values (3,2)

insert into CaloricGoal(CaloricGoalID,NumberOfCalories) values (1,3000)
insert into CaloricGoal(CaloricGoalID,NumberOfCalories) values (2,2500)
insert into CaloricGoal(CaloricGoalID,NumberOfCalories) values (3,1800)
insert into CaloricGoal(CaloricGoalID,NumberOfCalories) values (4,2300)
insert into CaloricGoal(CaloricGoalID,NumberOfCalories) values (5,2000)

select * from CaloricGoal

--------------------------UPDATE--------------------
update CaloricGoal
set NumberOfCalories=NumberOfCalories+200
where NumberOfCalories<2100

update Client
set Phone=0763334444
where Name='Claudiu'

update Exercise
set Reps=Reps+1
where Sets<5

-----------------------------DELETE--------------------
delete from CaloricGoal
where NumberOfCalories>2900

delete from Routine
where Name='Triceps'

select * from CaloricGoal

---------------------SELECT QUERIES---------------------------------

--a 2 queries with the union operation; use UNION [ALL] and OR;
select * from Client
where Name like 'C_%'
union all
select* from Client
where Phone like '076_%'

select * from Client
where Name like 'T_%' OR Name like 'R_%'


--b.2 queries with the intersection operation; use INTERSECT and IN;
select * from Exercise 
where Reps>9
INTERSECT
select * from Exercise
where Sets<5

select * from Exercise
where Reps in ( select Reps from Exercise where Reps<=5)


--c.2 queries with the difference operation; use EXCEPT and NOT IN;
select * from Exercise
where Name like 'B_%'
except
select * from Exercise
where Sets>=5

Select * from Routine
where Name not in (select Name from Routine where Name like 'P_%')


--d.4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN; one query will join at least 3 tables, while another one will join at least two many-to-many relationships;


--e.2 queries using the IN operator to introduce a subquery in the WHERE clause; in at least one query, the subquery should include a subquery in its own WHERE clause;

--find name of the clients with routineId=1
select Client.Name
from Client 
where Client.ClientID IN (Select ClientRoutine.RoutineID from ClientRoutine where ClientID=1)

--find name of the exercises which can be done with a cable
select Exercise.Name
from Exercise
where Exercise.Description IN (select Exercise.Description from Exercise where Description like '_%cable')


--f.2 queries using the EXISTS operator to introduce a subquery in the WHERE clause;

select Exercise.Name from Exercise
where Sets=5 and exists( select * from Exercise where Exercise.Reps=5 )
	

select Client.ClientID from Client 
where exists ( select Client.ClientID from Client where Client.Name like 'C_%')


--g.2 queries with a subquery in the FROM clause; 




--h.4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

--i.4 queries using ANY and ALL to introduce a subquery in the WHERE clause; 2 of them should be rewritten with aggregation operators, while the other 2 should also be expressed with [NOT] IN.

--find the id of the exercices that have more reps than sets  equivalent with MAX
select Exercise.ExerciseID from Exercise
where Exercise.Reps>ALL(select Exercise.ExerciseID from Exercise where Exercise.Sets=Exercise.Reps)

--find the id of the caloric goals that has less calories than 2500  equivalent with MIN 
select CaloricGoal.CaloricGoalID from CaloricGoal
where CaloricGoal.NumberOfCalories<ANY (select CaloricGoal.CaloricGoalID from CaloricGoal where CaloricGoal.NumberOfCalories>2500)