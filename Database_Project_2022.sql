--------------------------------------------------------------------------
## Pet Shelter Database
## Created by JJ Burns, Ernesto Delgado-Gallegos, Christian Hill
## ITEC 3335, Fall Semester 2022
--------------------------------------------------------------------------
DROP DATABASE IF EXISTS clearlake_shelter
;
CREATE DATABASE clearlake_shelter
;
USE clearlake_shelter
;

#Table Housekeeping
DROP TABLE IF EXISTS Animals;
DROP TABLE IF EXISTS MedSchedule;
DROP TABLE IF EXISTS Vet;
DROP TABLE IF EXISTS Pharmacy;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Units;
DROP TABLE IF EXISTS Pantry;
DROP TABLE IF EXISTS FoodSchedule;
DROP TABLE IF EXISTS Toys;

CREATE TABLE IF NOT EXISTS Employees(
	EmployeeID			INT NOT NULL AUTO_INCREMENT,
	Firstname 			VARCHAR(18),
	Lastname 			VARCHAR(18),
	JobRole				VARCHAR(1),
	Weeklyhours			INT,
	Pay					FLOAT,
	Telephone			VARCHAR(14),
PRIMARY KEY (EmployeeID)
)
;

CREATE TABLE IF NOT EXISTS Pantry(
	FoodID				INT NOT NULL AUTO_INCREMENT,
	Brand 				VARCHAR(18),
	Flavor 				VARCHAR(25),
	Form				VARCHAR(10),
	RetailPrice			VARCHAR(5),
PRIMARY KEY (FoodID)
)
;

CREATE TABLE IF NOT EXISTS FoodSchedule(
	FSchedID			INT NOT NULL AUTO_INCREMENT,
	FoodID 				INT,
	Portion				VARCHAR(25),
	MealTime			VARCHAR(25),
PRIMARY KEY (FSchedID),
FOREIGN KEY (FoodID) REFERENCES Pantry(FoodID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
)
;

CREATE TABLE IF NOT EXISTS Pharmacy(
	MedID				INT NOT NULL AUTO_INCREMENT,
	ShelfLife 			DATE,
	Brand 				VARCHAR(14),
    DrugName			VARCHAR(20),
    DrugForm			VARCHAR(20),
	DrugPrice			FLOAT,
PRIMARY KEY (MedID)
)
;

CREATE TABLE IF NOT EXISTS MedSchedule(
	MSchedID			INT NOT NULL AUTO_INCREMENT,
	Dosage 				VARCHAR(30),
	Frequency	 		VARCHAR (30),
PRIMARY KEY (MSchedID)
)
;

CREATE TABLE IF NOT EXISTS Vet(
	VetID				INT NOT NULL AUTO_INCREMENT,
	MedID 				INT,
	MSchedID 			INT,
	VetFName			VARCHAR(25),
    VetLName			VARCHAR(25),
    VetContact			VARCHAR(15),
PRIMARY KEY (VetID),
FOREIGN KEY (MedID) REFERENCES Pharmacy(MedID)
	ON UPDATE CASCADE
    ON DELETE CASCADE,
FOREIGN KEY (MSchedID) REFERENCES MedSchedule(MSchedID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
)
;

CREATE TABLE IF NOT EXISTS Animals (
	PetID				INT NOT NULL AUTO_INCREMENT,
	EmployeeID			INT,
	MSchedID			INT,
    FSchedID			INT,
	Gender				VARCHAR(1),
	Breed				VARCHAR(20),
	Age 				INT,
	PetName 			VARCHAR(20),
    Species				VARCHAR(1),
PRIMARY KEY (PetID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
	ON UPDATE CASCADE
    ON DELETE CASCADE,
FOREIGN KEY (MSchedID) REFERENCES MedSchedule(MSchedID)
	ON UPDATE CASCADE
    ON DELETE CASCADE,
FOREIGN KEY (FSchedID) REFERENCES FoodSchedule(FSchedID)
	ON UPDATE CASCADE
    ON DELETE CASCADE
)
;


CREATE TABLE IF NOT EXISTS Units(
	UnitNum				INT NOT NULL AUTO_INCREMENT,
	PetID 				INT,
	Size 				VARCHAR(3),
PRIMARY KEY (UnitNum),
FOREIGN KEY(PetID) REFERENCES Animals(PetID)
    ON DELETE CASCADE
    ON UPDATE CASCADE

)
;

CREATE TABLE IF NOT EXISTS Toys(
	ToyNum				INT NOT NULL AUTO_INCREMENT,
	UnitNum 			INT,
	ToyBrand			VARCHAR(20),
	ToyType				VARCHAR(20),
PRIMARY KEY (ToyNum),
FOREIGN KEY (UnitNum) REFERENCES Units(UnitNum)
	ON UPDATE CASCADE
    ON DELETE CASCADE
)
;

INSERT INTO MedSchedule (Dosage, Frequency) VALUES
('25mg', 'Once every morning'),
('1 Tablet', 'Twice a day, morning and night'),
('2 Capsules', 'Once daily with food'),
('3 Drops', 'Once before bed'),
('50mg', 'Once daily'),
('100mg', 'Once daily with food'),
('25mg', 'Twice a day morning and night'),
('Half a tablet', 'Twice a day, morning and night'),
('5 Drops', 'Mix in food morning and night'),
('25mg', 'Once daily')
;

INSERT INTO Pharmacy (ShelfLife, Brand, DrugName, DrugForm, DrugPrice) VALUES
('2024-04-24', 'NexGard', 'Afoxolaner', 'Chewable', 72.99),
('2025-05-25', 'Zoetis', 'Apoquel', 'Tablets', 12.53),
('2026-06-26', 'Heartgard', 'Ivermectin', 'Chewable', 67.99),
('2027-07-27', 'Zoetis', 'Simparica Trio', 'Tablet', 45.99),
('2028-08-28', 'Chewy', 'Carprofen', 'Caplets', 9.99), 
('2029-09-29', 'Chewy', 'Methimazole', 'Tablets', 12.49),
('2023-01-01', 'Dechra', 'Felimazole', 'Tablets', 9.99),
('2024-02-02', 'Chewy', 'Prednisolone', 'Tablets', 12.49),
('2024-04-04', 'Bravecto', 'Fluralaner', 'Drops', 20.99),
('2024-08-08', 'Cradelio', 'Lotilaner', 'Tablets', 19.99)
;

INSERT INTO Vet (MedID, MSchedID, VetFName, VetLName, VetContact) VALUES
(10, 1, 'Harrington', 'Hibbard', '832-200-200'),
(9, 2, 'Andrew', 'Burns', '832-200-201'),
(8, 3, 'Justin', 'Dunn', '832-200-202'),
(7, 4, 'Clinton', 'Loomis', '832-200-203'),
(6, 5, 'JJ', 'Burns', '832-200-204'),
(5, 6, 'Ernesto', 'Delgado-Gallegos', '832-200-205'),
(4, 7, 'Christian', 'Hill', '832-200-206'),
(3, 8, 'Mathias', 'Alden', '832-200-207'),
(2, 9, 'Joe', 'Haw', '832-200-208'),
(1, 10, 'Terry', 'West', '832-200-209')
;


INSERT INTO Employees (Firstname, Lastname, JobRole, WeeklyHours, Pay, Telephone) VALUES
('Aldo', 'Sebastian', 'E', 40, 18.00, '832-100-100'),
('Brady', 'Jones', 'E', 32, 14.00, '832-100-101'),
('John', 'Naisbitt', 'V', 20, NULL, '832-100-102'),
('Isaac', 'Potter', 'V', 18, NULL, '832-100-103'),
('Kevin', 'Trinh', 'V', 25, NULL, '832-100-104'),
('Schelling', 'Hibbard', 'E', 40, 17.00, '832-100-105'),
('Sumail', 'Hassan', 'V', 10, NULL, '832-100-106'),
('Steven', 'Tompary', 'V', 15, NULL, '832-100-107'),
('Joe', 'Byron', 'E', 38, 16.00, '832-100-108'),
('Kurt', 'Travis', 'V', 20, NULL, '832-100-109')
;

INSERT INTO Pantry (Brand, Flavor, Form, RetailPrice) VALUES
('JustFoodForDogs', 'Chicken & White Rice', 'Frozen', 15.99),
('JustFoodForDogs', 'Beef & Russet Potato', 'Frozen', 15.99),
('Kiwi Kitchens', 'Chicken Dinner', 'Dry', 12.99),
('Kiwi Kitchens', 'Lamb Diner', 'Dry', 13.99),
('Nulo Freestyle', 'Chicken & Mussel', 'Wet', 12.99),
('Meow Mix', 'Original Choice', 'Dry', 9.89),
('Purina ONE', 'Tender Blend', 'Dry', 14.49),
('Purina ONE', 'Indoor Advantage', 'Dry', 13.99),
('Blue Buffalo', 'Rocky Mountain Recipe', 'Dry', 9.99),
('Blue Buffalo', 'Natures Evolutionary', 'Dry', 10.99)
;

INSERT INTO FoodSchedule (FoodID, Portion, Mealtime) VALUES
(8, '1 Scoop', 'Morning and Night'),
(7, 'Half A Scoop', 'Morning, Afternoon, Night'),
(6, '2 Scoop', 'Once Daily'),
(3, '1 Scoop', 'Morning and Night'),
(9, '1/3 of a Package', 'Morning and Night'),
(10, '1/3 of a Package', 'Morning and Night'),
(2, '1/2 of a Can', 'Morning and Night'),
(1, '1/2 of a Can', 'Morning and Night'),
(5, '1 Scoop', 'Morning, Afternoon, Night'),
(4, 'Half A Scoop', 'Morning, Afternoon, Night')
;


INSERT INTO Animals (EmployeeID, MSchedID, FSchedID, Gender, Breed, Age, PetName, Species) VALUES
(3, 10, 1, 'M', 'Mix', 7, 'Duke', 'D'),
(4, 9, 2, 'M', 'Russian Blue', 11, 'Oscar', 'C'),
(3, 8, 3, 'M', 'Chihuahua Terrier', 6, 'Clancy', 'D'),
(5, 7, 4, 'F', 'American Shorthair', 8, 'Mariah', 'C'),
(3, 6, 5, 'M', 'Boxer', 9, 'Cassius', 'D'),
(5, 5, 6, 'F', 'Siamese', 4, 'Brandy', 'C'),
(10, 4, 7, 'F', 'Mix', 9, 'McKinley', 'D'),
(7, 3, 8, 'M', 'Pug', 4, 'Fred', 'D'),
(4, 2, 9, 'F', 'Golden Retriever', 6, 'Daisy', 'D'),
(8, 1, 10, 'M', 'Bulldog', 5, 'Pudge', 'D')
;

INSERT INTO Units (PetID, Size) VALUES
(1, 'LRG'),
(3, 'MED'),
(2, 'SML'),
(7, 'SML'),
(9, 'LRG'),
(8, 'LRG'),
(4, 'SML'),
(5, 'MED'),
(10, 'MED'),
(6, 'SML')
;

INSERT INTO Toys (UnitNum, ToyBrand, ToyType) VALUES
(3, 'KONG', 'Blue Dog Toy'),
(7, 'Chuckit!', 'Rubber Ball Tough'),
(1, 'Nylabone', 'Power Chew Dog Ring'),
(2, 'KONG', 'Floppy Knots'),
(4, 'KONG', 'SqueakAir'),
(10, 'Frisco', 'Bird Teaser'),
(5, 'Frisco', 'Colorful Springs'),
(8, 'Frisco', 'Basic Plush Mice'),
(6, 'KONG', 'Cat Scratcher'),
(9, 'KONG', 'Butterfly Cat Tracks')
;