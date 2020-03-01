use PersonalTrainingProgram

--version 1  a. modify the type of a column
GO
CREATE OR ALTER PROCEDURE V1
AS
BEGIN
	ALTER TABLE Measurements
	ALTER COLUMN Chest SMALLINT
END

EXEC V1

GO
CREATE OR ALTER PROCEDURE RV1
AS
BEGIN
	ALTER TABLE Measurements
	ALTER COLUMN Chest INT
END 

EXEC RV1

--version 2  b. add / remove a column;
GO 
CREATE OR ALTER PROCEDURE V2
AS
BEGIN
	ALTER TABLE Nutrients
	ADD Fibre int
END

EXEC V2

GO
CREATE OR ALTER PROCEDURE RV2
AS
BEGIN
	ALTER TABLE Nutrients
	DROP COLUMN Fibre
END 

EXEC RV2 

--version 3  c. add / remove a DEFAULT constraint;
GO 
CREATE OR ALTER PROCEDURE V3
AS
BEGIN
	ALTER TABLE Nutrients
	ADD CONSTRAINT df_Nutrients DEFAULT 120 FOR Protein
END 

EXEC V3

GO
CREATE OR ALTER PROCEDURE RV3
AS
BEGIN
	ALTER TABLE Nutrients
	DROP CONSTRAINT df_Nutrients
END

EXEC RV3 

--version 4   d. add / remove a primary key;
--create table NewTable(
--	Nid int not null)
--drop table NewTable

GO 
CREATE OR ALTER PROCEDURE V4
AS
BEGIN
	ALTER TABLE NewTable
	ADD CONSTRAINT pk_New PRIMARY KEY(Nid)
END 

EXEC V4 

GO 
CREATE OR ALTER PROCEDURE RV4
AS
BEGIN
	ALTER TABLE NewTable
	DROP CONSTRAINT pk_New
END 

EXEC RV4 

--version 5  e. add / remove a candidate key;
GO
CREATE OR ALTER PROCEDURE V5
AS
BEGIN
	ALTER TABLE PayBill
	ADD CONSTRAINT uq_PayBill UNIQUE(Amount)
END

EXEC V5 

GO 
CREATE OR ALTER PROCEDURE RV5
AS
BEGIN
	ALTER TABLE PayBill
	DROP CONSTRAINT uq_PayBill
END

EXEC RV5 

--version 6  f. add / remove a foreign key;
GO
CREATE OR ALTER PROCEDURE V6
AS
BEGIN
	ALTER TABLE NewTable
	add NutrientsID int not null
	alter table NewTable
	add constraint fk_Nutrients foreign key(NutrientsID) references Nutrients(NutrientsId)
END

exec V6 

GO 
CREATE OR ALTER PROCEDURE RV6
AS
BEGIN
	alter table NewTable
	drop constraint fk_Nutrients
	alter table newTable
	drop column NutrientsID
END

exec RV6 

--version 7   g. create / remove a table.
GO
CREATE OR ALTER PROCEDURE V7
AS
BEGIN 
	CREATE TABLE V7Table(
	Vid int primary key identity,
	VName varchar(50))
END
EXEC V7
--Select * from V7Table

GO
CREATE OR ALTER PROCEDURE RV7
AS
BEGIN
	
	DROP TABLE V7Table
END 

exec RV7


DROP TABLE IF EXISTS VersionTable 
CREATE TABLE VersionTable(
	id int IDENTITY (1,1) NOT NULL,
	currentVersion int)
	
INSERT INTO VersionTable values(0)



GO
CREATE OR ALTER PROCEDURE main1 @newVersion INT
AS
BEGIN
	
	DECLARE @nextStep varchar(30)
	DECLARE @currentVersion INT
	SET @currentVersion = (SELECT currentVersion from VersionTable)

	if ISNUMERIC(@newVersion) != 1
	BEGIN
		print('Not a number')
		return 1 
	END
	
	SET @newVersion = cast(@newVersion as INT)
	if @newVersion < 0 or @newVersion > 7
	BEGIN
		print('Invalid number')
		return 2 
	END

	while @currentVersion < @newVersion
	begin
		SET @currentVersion = @currentVersion + 1
		SET @nextStep = 'V' + convert(varchar(3), @currentVersion)
		execute @nextStep
		print(@currentVersion)
	end

	while @currentVersion > @newVersion
	begin
		SET @currentVersion = @currentVersion - 1
		SET @nextStep = 'RV' + convert(varchar(3), @currentVersion)
		execute @nextStep
		print(@currentVersion)
	end

	truncate table VersionTable
	insert into VersionTable values(@newVersion)
END

