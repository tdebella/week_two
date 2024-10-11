--To create a new schema (which we'll for every individual project):
--right click the schemas folder -> create new schema -> give it a name
--right click the new schema -> sql editor -> new sql script

--Data Definition Language (DDL): CREATE, ALTER, TRUNCATE, DROP
--DDL is any SQL command that relates to the STRUCTURE of your database and its tables

--the CREATE commands lets us create DB table
CREATE TABLE users(
	--username is the name of a column (attribute/property) in the users table
	--TEXT is the datatype. It's a basic text-based type like String in Java
	username TEXT
);

--we can view this table by right clicking the schema -> view diagram
--OR you can double click the table and view table-specific properties and diagram
--REMEMBER TO RIGHT CLICK -> REFRESH THE SCHEMA AFTER MAKING NEW TABLES!
	--otherwise, they won't show up

--OH NO!! I forgot to add a column for user's age! I can ALTER the table to add it
ALTER TABLE users ADD user_age int;

--we can use DROP to delete a table and all of its data
DROP TABLE users;

--we can use TRUNCATE to delete all of the data from a table (but leave the table)
TRUNCATE TABLE users;


--DATA TYPES---------------------------------------------

--I'm going to make a horribly designed table to list out some datatypes
--Why is this table bad? No primary key, not normalized, bad column names. Don't make tables like this

CREATE TABLE datatypes(

	small_number int2, --2 bytes. used for smaller numbers (like a short in Java)
	normal_number int, --4 bytes, most common integer type
	big_number int8, --8 bytes, used for very large numbers (like a long in Java)
	normal_decimal decimal(10, 2), --2 parameters (total # of digits, total # of decimal places)
	--this decimal will be 8 integers followed by 2 decimal places^
	
	"boolean" boolean, --double quotes allow you to use keywords as column names
	
	fixed_length_text char(2), --TEXT datatype that can ONLY hold the amount of characters given
	variable_length_text varchar(15), --TEXT datatype that can hold UP TO the amount of characters given
	unlimited_length_text TEXT --unlimited length, I mostly use this one
	
	--notice no comma after the last column, that's just a SQL thing.
	
);

--there are A LOT MORE DATATYPES THAN THIS!! Feel free to look into them
--I mostly just use int, decimal, boolean, and text






