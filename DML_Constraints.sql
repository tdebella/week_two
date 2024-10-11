--I want to create two tables with a relationship
--I can accomplish this with primary keys and foreign keys
--The Foreign Key of one table points to the Primary Key of another table. This is how we establish relationships!!

--This schema will track employees and their roles

--roles table
CREATE TABLE roles(

	role_id serial PRIMARY KEY, --The primary key UNIQUELY IDENTIFIES each record in the table
	--serial is an auto-incrementing int datatype - perfect for primary keys which must be unique
	--whenever we insert a new record, the primary key will get automatically generated and incremented for us
	
	role_title TEXT UNIQUE, -- now, every role record must have a UNIQUE value for role_title
	role_salary int CHECK(role_salary > 20000) --thanks to the check constraint, salaries cannot be < 20,000

);

--employees table (has a FOREIGN KEY to the roles table!) "Every Employee has a Role"
CREATE TABLE employees(

	employee_id serial PRIMARY KEY, --remember, the PK is like a unique identifier for a record 
	first_name TEXT NOT NULL, --every employee must have a value for first name
	last_name TEXT NOT NULL,
	role_id_fk int REFERENCES roles(role_id) --This is a FOREIGN KEY. (note the "references" keyword)
	--THIS IS HOW WE ESTABLISH RELATIONSHIPS BETWEEN TABLES. Now every Employee has a Role
	--Every Employee must have a Role, but Role doesn't necessarily depend on Employee

);


--Data Manipulation Language (DML)-------------------------

--SELECT, INSERT, UPDATE, DELETE


/*INSERT some data into my tables 
 
 We specify what table and columns we're inserting data into
 We don't need to add values for any auto-incrementing fields (like serial primary keys)
 
 Each pair of parenthesis will be a different record in the table */

INSERT INTO roles(role_title, role_salary)
VALUES ('Manager', 100000), ('Cashier', 40000), ('Fry Cook', 35000), ('Marketing Director', 100000); 

--we can use SELECT to view data in the table
SELECT * FROM roles; -- * means "everything"... "select everything from the roles tables"

INSERT INTO employees(first_name, last_name, role_id_fk)
VALUES ('Spongebob', 'Squarepants', 3), ('Squidward', 'Tentacles', 2), 
('Eugene', 'Krabs', 1), ('Sheldon', 'Plankton', 4);

SELECT * FROM employees;


--the WHERE clause----------------------------------------

--In a SELECT, the WHERE clause helps us filter results

--SELECT all roles where the salary is equals to 100,000 (=)
SELECT * FROM roles WHERE role_salary = 100000;

--SELECT all roles where the salary is less than 100,000 (<)
SELECT * FROM roles WHERE role_salary < 100000;
--This is a SUBQUERY - "Select all roles where the salary is less than the manager's salary)
SELECT * FROM roles WHERE role_salary < (SELECT role_salary FROM roles WHERE role_title = 'Manager')

--all roles with a salary between 40,000 and 90,000 (BETWEEN & AND)
SELECT * FROM roles WHERE role_salary BETWEEN 40000 AND 90000 

--all employees with names starting with 'S' (LIKE & %)
SELECT * FROM employees WHERE first_name LIKE 'S%'

--The % can be used anywhere to denote values that don't matter
--all employees with an 'e' in their first name
SELECT * FROM employees WHERE first_name LIKE '%e%'

--Employees named Eugene or Sheldon (OR)
SELECT * FROM employees WHERE first_name = 'Eugene' OR first_name = 'Sheldon'

--Same thing as above, but using the IN operator instead (which could be shorter, depending on # of checks)
--In checks for records with columns that have a match IN the values in parenthesis
SELECT * FROM employee WHERE first_name IN ('Eugene', 'Sheldon')


--ORDER BY---------------------------------

--Lets us order things in ascending or descending order (ascending by default)
SELECT * FROM roles ORDER BY role_salary --numeric
SELECT * FROM employees ORDER BY first_name --alphabet

--we can say "desc" for descending order
SELECT * FROM roles ORDER BY role_salary desc

--FUNCTIONS-------------------------------

--Scalar functions can take in up to one value, and they return one value
SELECT now(); --returns the current date/time
SELECT upper('this text will be returned all uppercase')

--Aggregate functions can take in multiple values and return one value 
SELECT avg(role_salary) FROM roles --gets the average
SELECT sum(role_salary) FROM roles --gets the sum
SELECT count(employee_id) FROM employees --gives us a number of records that are returned
SELECT count(employee_id) FROM employees WHERE role_id_fk = 1


--GROUP BY will merge rows together based on matching column values
SELECT count(*) FROM roles GROUP BY role_salary;

--Maybe I want the role_salary as well, so the ResultSet is more clear
SELECT role_salary, count(*) FROM roles GROUP BY role_salary;

--HAVING is like a WHERE clause, but it can only be used after a GROUP BY. 
--WHERE will not work after GROUP BY
SELECT role_salary, count(*) FROM roles GROUP BY role_salary HAVING role_salary = 100000;

--This is because the WHERE clause only works after a selection from tables (only works on raw table data)
--"WHERE does NOT work on values that have been aggregated by GROUP BY" - nice QC line?


--UPDATE--------------------------------------

--We can use UPDATE to update records - let's say cashiers got a raise
UPDATE roles SET role_salary = 45000 WHERE role_title = 'Cashier';

--NOTE: the WHERE clause is very important here, otherwise we'd set every role to have the same salary

SELECT * FROM roles; --NOTE: we could just run the previous select from above

--DELETE (and a note about CASCADE)--------------------------------------

--We can use DELETE to delete records - squidward is making too much money now - let's fire him
DELETE FROM employees WHERE first_name = 'Squidward';

SELECT * FROM employees;

--Let's try to delete a Role (and see why it doesn't work)
DELETE FROM roles WHERE role_title = 'Manager'
--Can't do it! There are employee records that are pointing to the Manager role
--"If you try to delete records or tables that are references by other records or tables, you can't"

/* Why can't we delete?
  
   This is a built in rule, to promote REFERENTIAL INTEGRITY
   "We can't have records that refer to other records that don't exist" - those are called orphan records 
  
  In order for this delete to work, we would have to say "ON DELETE CASCADE" in our foreign key column
  observe below: (not actually going to run this table creation) */

CREATE TABLE employees(
	employee_id serial PRIMARY KEY, 
	first_name TEXT NOT NULL, 
	last_name TEXT NOT NULL,
	role_id_fk int REFERENCES roles(role_id) ON DELETE CASCADE -- this also works for ON UPDATE CASCADE
);

--we could have also done ON DELETE SET NULL if we want to preserve the record but not FK








