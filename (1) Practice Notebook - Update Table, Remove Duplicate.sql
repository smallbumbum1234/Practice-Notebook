
-- View a list of database
SELECT name, database_id, create_date
FROM sys.databases;
GO

-- Create Database
Create database CatShop;

-- Use specific database
Use CatShop

-- Drop Database while it is using
USE master;
ALTER DATABASE [CatShop] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE [CatShop] ;

-- Create Table
Create database CatShop;

Create Table Cats
	(name Varchar (100),
	age int
	);

-- Adding Data to the table
Insert Into Cats(name, age)
Values ('Jetson', 7),
		('Max', 3),
		('Toto', 10);
-- Add ' as a text by put ' again in front of ' you want to put as a text.
Insert Into Cats(name, age)
Values ('Bob''''s', 10);

-- ADD Constraint after table was already created.
ALTER Table Cats
ALTER Column name Varchar (100) NOT NULL; -- Restrict from put blank in column name

SElect * From Cats

-- Add default value when we inset null to the column (After Create Table)
ALTER Table Cats
	Add default 'notfound' For name;
ALTER Table Cats
	Add default 0 For age;

Insert Into Cats(age)
Values ('');

-- Add Column
Alter Table Cats
ADD cat_id int -- Can't not set as not null because it added after other columns have value already.
PRIMARY KEY (cat_id);

-- Add id in column cat_id
UPDATE Cats SET cat_id = 1 WHERE name = 'Jetson'
UPDATE Cats SET cat_id = 2 WHERE name = 'Max'
UPDATE Cats SET cat_id = 3 WHERE name = 'Toto'
UPDATE Cats SET cat_id = 4 WHERE name = 'Bob''s'
UPDATE Cats SET cat_id = 5 WHERE name = 'Bob''''s'
UPDATE Cats SET cat_id = 6 WHERE name = ''
UPDATE Cats SET cat_id = 7 WHERE name = 'notfound'


-- Remove Duplicate data using windows function (But it delete all duplicate value doesn't one)
Delete from Cats
Where cat_id in
(
	-- 2. Select only the duplicated value.
	Select cat_id from (
		-- 1. Find which row has duplicated valuse by adding number of row to them if it has 2 row that means it is duplicated.
		select cat_id, ROW_NUMBER() over (partition by cat_id order by cat_id) as rownum from Cats
	) d
	Where rownum > 1
)

--Insert into Cats(cat_id, name, age)
--values (3, 'Toto', 10);

-- Remove Duplicate data using windows function and view (Remove the duplicated but left 1 row to make it unique)
Create View RownumforCats as
	select cat_id, age, name, ROW_NUMBER() over (partition by cat_id order by cat_id) as rownum
	from Cats;

Delete from RownumforCats Where rownum > 1;

--select * from RownumforCats;








