--Loading Data into Data Tables
.mode "column"
.separator ","
.import csv/Weapons.csv Weapons
.import csv/Perks.csv Perks
.import csv/Throwables.csv Throwables
.import csv/Attachments.csv Attachments
.import csv/Kill_Streaks.csv Kill_Streaks
.import csv/Maps.csv Maps

-- CREATE TABLE Character(
-- C_ID Decimal(3,0) NOT NULL,
-- C_Name Char(25) NOT NULL
-- );

-- CREATE TABLE Perks_to_Character(
-- PC_ID Decimal(3,0) NOT NULL,
-- C_ID Decimal(3,0) NOT NULL,
-- P_ID Decimal(3,0) NOT NULL
-- );

-- CREATE TABLE Throwables_to_Character(
-- PC_ID Decimal(3,0) NOT NULL,
-- C_ID Decimal(3,0) NOT NULL,
-- T_ID Decimal(3,0) NOT NULL
-- );

-- CREATE TABLE KillStreaks_to_Character(
-- PC_ID Decimal(3,0) NOT NULL,
-- C_ID Decimal(3,0) NOT NULL,
-- KS_ID Decimal(3,0) NOT NULL
-- );


--Project Queries
Select "1--------------";
.headers on
--1 What maps are large maps
SELECT Maps_Name as Name, Maps_Size as Size
FROM Maps
WHERE Maps_Size = 'L'
ORDER BY Maps_Name ASC; 

.headers off

Select "2--------------";
.headers on
--2 What maps are in LA
SELECT Maps_Name as Name, Maps_Location as Location
FROM Maps
WHERE Maps_Location = 'Los Angeles'
ORDER BY Maps_Name ASC; 

.headers off

Select "3--------------";
.headers on
--3 Find the highest damage weapon
SELECT Weapon_Name as Name, Weapon_Type as Type
FROM Weapons
WHERE Weapon_DMG = (SELECT MAX(Weapon_DMG) FROM Weapons)
GROUP BY Weapon_Name;

.headers off

Select "4--------------";
.headers on
--4 Average Kill Streak cost
SELECT AVG(KillStreak_Points) as AVG_Points
FROM Kill_Streaks;

.headers off

Select "5--------------";
.headers on
--5 Count number of maps
SELECT count(*) as Total_Maps
FROM Maps;

.headers off

Select "6--------------";
.headers on
--6 Find Sniper Rifle with Lowest Range
SELECT Weapon_Name as Name, Weapon_Range as Range
FROM Weapons
WHERE Weapon_Type = 'SNIPER' AND 
    Weapon_Range = (SELECT MAX(Weapon_Range) FROM Weapons WHERE Weapon_Type = 'SNIPER');

.headers off

SELECT "7--------------";
.headers on
--7 Find the SMG with the higest Accuracy
SELECT Weapon_Name as Name, Weapon_Range as Range
FROM Weapons
WHERE Weapon_Type = 'SMG' AND 
    Weapon_Range = (SELECT MAX(Weapon_Range) FROM Weapons WHERE Weapon_Type = 'SMG')
GROUP BY Weapon_Name;

.headers off

SELECT "8--------------";
.headers on
--8 What attachments increase DMG
SELECT Attach_Name as Name
FROM Attachments
WHERE Attach_DMG = 1
GROUP BY Attach_Name;

.headers off

SELECT "9--------------";
.headers on
--9 Finding perks that are immune
SELECT Perk_name
FROM Perks
WHERE Perk_Desc LIKE '%immune%';

.headers off

SELECT "10--------------";
.headers on
--10 What Weapons have higher DMG than the AVG
SELECT Weapon_Name as Name, Weapon_Type as Type, Weapon_DMG as DMG
FROM Weapons
WHERE Weapon_DMG >= (SELECT AVG(Weapon_DMG) FROM Weapons)
GROUP BY Weapon_Name;

.headers off

SELECT "11--------------";
.headers on
--11 Highest cost KillStreak
SELECT MAX(KillStreak_Points) as Max_Points
FROM Kill_Streaks;

.headers off

SELECT "12--------------";
.headers on
--12 How many lethal throwables are there
SELECT Throwable_Name as Name
FROM Throwables
WHERE Throwable_Type = 'Lethal';

.headers off

SELECT "13--------------";
.headers on
--13 What perks give mobility
SELECT Perk_Name
FROM Perks
WHERE Perk_Mobility = 1 AND
    Perk_Defense = 0 AND
    Perk_Upgrades = 0
ORDER BY Perk_Name ASC;

.headers off

SELECT "14--------------";
.headers on
--14 Insert a new Map
INSERT INTO
Maps(Maps_ID, Maps_Name, Maps_Size, Maps_Location)
VALUES("16", "Studio", "M", "Los Angeles");

.headers off

SELECT "15--------------";
.headers on
--14 Insert a new Weapon
INSERT INTO
Weapons(Weapon_ID, Weapon_Name, Weapon_Category, Weapon_Type, Weapon_FireRate, Weapon_DMG, Weapon_Range, Weapon_Accuracy)
VALUES("39", "Piece Keeper", "Primary", "AR", "15", "14", "11", "16");


.headers off

SELECT "16--------------";
.headers on
--16 Print all details for MP7
SELECT
    Weapon_Name as Name,
    Weapon_FireRate as Fire_Rate,
    Weapon_DMG as DMG,
    Weapon_Range as Range,
    Weapon_Accuracy as Accuracy
FROM Weapons
WHERE Weapon_Name = 'MP7';

.headers off

SELECT "17--------------";
.headers on
--17 Delete a Map
DELETE FROM Maps
WHERE Maps_Name = 'Yemen';

.headers off

SELECT "18--------------";
.headers on
--18 Find the category and typing of the weapon Weapon name would be changed depending on what the user inoputs
SELECT Weapon_Name as Name, Weapon_Category as Category, Weapon_Type as Type
FROM Weapons
WHERE Weapon_Name = 'MP7';

.headers off

SELECT "19--------------";
.headers on
--19 Find attachment that reduces "recoil"
SELECT Attach_name
FROM Attachments
WHERE Attach_Desc LIKE '%recoil%';

.headers off

SELECT "20--------------";
.headers on
--20 Delete a Weapon
DELETE FROM Weapons
WHERE Weapon_Name = 'SMR';

.headers off