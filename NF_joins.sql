--This demo will demonstrate Normal Forms 1-3 and Joins (at the end)

/* 1st Normal Forms (we do NOT want this in our projects or ever)
 * 
 *
 * Rules:
 * 1) Tables must have primary keys (can be a composite key - PK made up of multiple columns)
 * 2) Columns must be atomic (columns must track the smallest pieces of data possible) */

CREATE TABLE snacks(
	--notice no typical serial int primary key 
	snack_name TEXT,
	snack_calories int,
	snack_taste TEXT,
	snack_brand TEXT,
	snack_brand_hq TEXT, 
	PRIMARY KEY(snack_name, snack_brand) --this is a composite key
	--it's made up of multiple columns to uniquely identify a record
);

INSERT INTO snacks(snack_name, snack_calories, snack_taste, snack_brand, snack_brand_hq)
values('PB crackers', 100, 'sweet/savory', 'Tollhouse', 'Kentucky'),
('BBQ Chips', 150, 'savory', 'Lays', 'Ohio'),
('Oreos', 200, 'sweet', 'Mondelez', 'Wisconsin'),
('BBQ Chips', 150, 'savory', 'Utz', 'Wyoming');

SELECT * FROM snacks

DROP TABLE snacks; 

/*2nd Normal Form (this is better, but we still haven't achieved 3NF, which is the goal
 * 
 * 1) Be in 1NF
 * 2) Remove partial dependencies (a single column primary key is the best way to achieve this
 * 	-This is a great reason to keep using our serial int primary keys */

CREATE TABLE snacks(
	snack_id serial PRIMARY KEY, 
	snack_name TEXT,
	snack_calories int,
	snack_taste TEXT,
	snack_brand TEXT,
	snack_brand_hq TEXT 
);

INSERT INTO snacks(snack_name, snack_calories, snack_taste, snack_brand, snack_brand_hq)
values('PB crackers', 100, 'sweet/savory', 'Tollhouse', 'Kentucky'),
('BBQ Chips', 150, 'savory', 'Lays', 'Ohio'),
('Oreos', 200, 'sweet', 'Mondelez', 'Wisconsin'),
('BBQ Chips', 150, 'savory', 'Utz', 'Wyoming');

SELECT * FROM snacks;

DROP TABLE snacks;


/* 3rd Normal Form - This is how we want our tables structured 
 * 
 * Rules:
 * 1) Be in 2NF
 * 2) Remove Transitive Dependencies (we need to split our tables according to their topic
 * 	In other words, tables must have a SINGLE RESPONSIBILITY. 
 * 	-One table deals with snacks, another with brands */

--We should do Brands first, since Snack depends on it
CREATE TABLE brands(
	brand_id serial PRIMARY KEY,
	brand_name TEXT,
	brand_hq TEXT 
);

INSERT INTO brands(brand_name, brand_hq)
VALUES ('Tollhouse', 'Kentucky'), ('Lays', 'Ohio'), ('Mondelez', 'Wisconsin'), 
('Utz', 'Wyoming'), ('Nestle', 'Maryland');

SELECT * FROM brands;

CREATE TABLE snacks(
	snack_id serial PRIMARY KEY, 
	snack_name TEXT,
	snack_calories int,
	snack_taste TEXT,
	brand_id_fk int REFERENCES brands(brand_id)
);


INSERT INTO snacks(snack_name, snack_calories, snack_taste, brand_id_fk)
values('PB crackers', 100, 'sweet/savory', 1),
('BBQ Chips', 150, 'savory', 2),
('Oreos', 200, 'sweet', 3),
('BBQ Chips', 150, 'savory', 4),
('Girl Dinner', 200, 'misc.', NULL);

SELECT * FROM snacks;


--JOINS-----------------------------------

--INNER JOIN---/

--return all records with matching data (typically PK/FK) in both tables
--"if the two tables have records with PK/FK matches, include them in the ResultSet"
SELECT * FROM snacks INNER JOIN brands ON brand_id_fk = brand_id;
--Notice: We don't get the "Girl Dinner" snack or the "Nestle" brand, because there are no PK/FK matches


--FULL OUTER JOIN---/

--return everything.
SELECT * FROM snacks FULL OUTER JOIN brands ON brand_id_fk = brand_id;


--LEFT JOIN---/

--returns everything from the left table and matchings records on the right table
SELECT * FROM snacks LEFT JOIN brands ON brand_id_fk = brand_id;
--Notice: no Nestle, it doesn't match anything on the left table


--RIGHT JOIN---/

--returns everything from the right table and matching records on the left table
SELECT * FROM snacks RIGHT JOIN brands ON brand_id_fk = brand_id;
--Notice: no Girl Dinner, it doesn't match anything on the right table


--RIGHT VS LEFT?? This is determined by the position of the table name around the JOIN syntax
--LEFT_TABLE [JOIN] RIGHT_TABLE


