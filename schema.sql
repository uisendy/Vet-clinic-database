/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id	INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	date_of_birth	DATE NOT NULL,
	escape_attempts	INT NOT NULL,
	neutered	BOOLEAN NOT NULL,
	weight_kg FLOAT(4) NOT NULL,
	PRIMARY KEY(id)
);

/* adding column species to the animals table*/

ALTER TABLE animals 
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	full_name varchar(100),
	age int
);

CREATE TABLE species (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name varchar(100)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN species_id int;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) 
REFERENCES species(id)
ON DELETE CASCADE;


ALTER TABLE animals 
ADD COLUMN owners_id int;

ALTER TABLE animals
ADD FOREIGN KEY (owners_id) 
REFERENCES owners(id)
ON DELETE CASCADE;