/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name ~~ '%mon'


-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31'

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * FROM animals WHERE neutered = true

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon'

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Inside a Transaction

/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
Then roll back the change and verify that the species columns went back to the state before the transaction*/
BEGIN; -- start transaction
  UPDATE animals
  SET species = 'unspecified';
  SELECT species from animals; 
ROLLBACK;

  SELECT species from animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN;

UPDATE animals 
SET species = 'digimon'
WHERE name ~~ '%mon';

UPDATE animals 
SET species = 'pokemon'
WHERE species = NULL;

COMMIT

-- Delete all records and rollback after the delete
BEGIN;

DELETE FROM animals;

ROLLBACK;


-- Delete all animals born after Jan 1st, 2022.
--Create a savepoint for the transaction.
--Update all animals' weight to be their weight multiplied by -1.
--Rollback to the savepoint
--Update all animals' weights that are negative to be their weight multiplied by -1.
--Commit transaction


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save_point;
UPDATE animals SET weight_kg = -1 * weight_kg;
ROLLBACK TO SAVEPOINT save_point
UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
COMMIT

--How many animals are there?
SELECT COUNT(*) FROM animals

--How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0

--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals

--Who escapes the most, neutered or not neutered animals?
SELECT 

neutered, 
count(escape_attempts) AS no_of_escapes, 
SUM(escape_attempts) AS sum_of_escapes 

FROM animals

GROUP BY neutered

--What is the minimum and maximum weight of each type of animal?
SELECT 

species, 
MAX(weight_kg) AS maximum_weight, 
MIN(weight_kg) AS minimum_weight 

FROM animals

GROUP BY species

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT 

species, 
AVG(escape_attempts) AS avg_escape_attempts 

FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'

GROUP BY species

---------------------

SELECT animals.name, animals.owners_id, owners.full_name FROM animals 
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond ';

SELECT animals.name, species.name FROM animals 
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon'; 

SELECT animals.name, owners.full_name
FROM animals 
RIGHT JOIN owners ON animals.owners_id = owners.id;

SELECT species.name, COUNT(animals.name) AS count
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

SELECT animals.name, owners.full_name
FROM animals 
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners.id 
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals 
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) AS number_of_animals 
FROM animals 
JOIN owners ON animals.owners_id = owners.id
GROUP BY owners.full_name 
ORDER BY COUNT(animals.name) DESC LIMIT 1;


----------


SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC LIMIT 1


SELECT COUNT(DISTINCT animals_id)
FROM visits
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT DISTINCT vets.name
FROM specializations
RIGHT JOIN vets ON specializations.vets_id = vets.id;

SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND
visits.visit_date BETWEEN '2020-04-01' and '2020-08-30'


SELECT count(animals_id) as amount_of_visits, animals.name
FROM visits
JOIN animals
ON animals.id = visits.animals_id
GROUP BY animals_id, animals.name
ORDER BY COUNT(animals_id) DESC LIMIT 1;

SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date LIMIT 1;

SELECT animals.id as animal_id,
animals.name as animal_name,
vets.id as vet_id,
vets.name as vet_name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
ORDER BY visit_date LIMIT 1;

SELECT count(animals.name)
FROM visits
JOIN animals 
ON animals.id = visits.animals_id
JOIN specializations
ON specializations.vets_id = visits.vets_id
where animals.species_id <> specializations.species_id

SELECT species.name 
FROM visits 
JOIN vets 
ON visits.vets_id = vets.id
join animals on animals.id = visits.animals_id
join species on species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals_id, species.name
ORDER BY COUNT(animals_id) DESC LIMIT 1