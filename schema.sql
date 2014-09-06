CREATE DATABASE wisdom;

CREATE TABLE categories(
	id serial primary key,
	name varchar(150),
	description text,
	upvotes integer,
	downvotes integer
);

CREATE TABLE posts(
	id serial primary key,
	author varchar(150),
	source varchar(200),
	posted_by varchar(150),
	quote text,
	expires_on date,
	upvotes integer,
	downvotes integer,
	category_id integer
);

CREATE TABLE comments(
	id serial primary key,
	say varchar(255),
	post_id integer
);

CREATE TABLE subscribers(
);

-- NOTES BELOW

-- To enter Postgres Terminal
psql

-- To quit psql
\q

-- To create database
CREATE DATABASE jungle;

-- To connect to a database
\c;

-- To create a table in my database
CREATE TABLE monkeys (name varchar(50), age integer);

-- To add an entry
INSERT INTO monkeys (name, age) VALUES ('Brutus', 13);
INSERT INTO monkeys (name, age) VALUES ('Cletus', 4);

-- Return all entries on a table
SELECT * FROM monkeys;

-- Return entries based on a specified attribute
SELECT * FROM birds WHERE name = 'Lola';

-- Add a serialized ID to the table
CREATE TABLE mechanic (id serial primary key, name varchar(50));

-- Let Postgres assign the ID, you don't have to worry about it!
INSERT INTO mechanic (name) VALUES ('Fred');






