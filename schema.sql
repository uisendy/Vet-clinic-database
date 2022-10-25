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

----------

CREATE table vets (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name varchar,
	age int,
	date_of_graduation date
);


CREATE table specializations (
	species_id int,
	vets_id int,
	PRIMARY KEY (species_id, vets_id),
	FOREIGN KEY (species_id) REFERENCES species(id),
	FOREIGN KEY (vets_id) REFERENCES vets(id)
);

create table visits (
	animals_id int,
	vets_id int,
  visit_date date,
	PRIMARY KEY (animals_id, vets_id, visit_date),
	FOREIGN KEY (animals_id) REFERENCES animals(id),
	FOREIGN KEY (vets_id) REFERENCES vets(id)
);