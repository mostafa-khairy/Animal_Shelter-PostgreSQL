-- cross join 
select *
from staff
cross join staff_roles ;


--
select *
from staff  
join staff_roles
on 1=1 ;

--

select ad.*, an.breed, an.implant_chip_id 
from animals an
join adoptions ad
on an.species = ad.species
and 
an.name = ad.name ;

--
select ad.*, an.breed, an.implant_chip_id 
from animals an
left join adoptions ad
on an.species = ad.species
and 
an.name = ad.name ;


-- query for animal adoptions and info. about their adopters
select *
from animals an
join adoptions ad
on an.species = ad.species
and 
an.name = ad.name
join persons pe
on pe.email = ad.adopter_email ;

--
select *
from animals an
left join
(adoptions ad
join persons pe
on pe.email = ad.adopter_email )
on an.species = ad.species
and 
an.name = ad.name ;


/*
Animal vaccinations report.
---------------------------
Write a query to report all animals and their vaccinations.
Animals that have not been vaccinated should be included.
The report should include the following attributes:
Animal's name, species, breed, and primary color,
vaccination time and the vaccine name,
the staff member's first name, last name, and role.
*/

select an.name, an.species, an.breed, an.primary_color, va.vaccination_time,
va.vaccine, st.role, pe.first_name, pe.last_name 
from animals an 
left join vaccinations va 
on an.species = va.species
and 
an.name = va.name
left join staff_assignments st
on st.email = va.email 
left join persons pe
on pe.email = st.email 
ORDER BY an.Species, an.Name, an.Breed, va.Vaccination_Time DESC;


-- another way to force join order as needed

select an.name, an.species, an.breed, an.primary_color, va.vaccination_time,
va.vaccine, st.role, pe.first_name, pe.last_name 
from animals an 
left join  (
vaccinations va 
join staff_assignments st
on st.email = va.email 
join persons pe
on pe.email = st.email )
on an.species = va.species
and 
an.name = va.name
ORDER BY an.species, an.name, an.breed, va.vaccination_time DESC;




-- query to return all dog except (breed = 'bullmastiffs'), involving a null

-- this query didn't return (breed = null) 
select *
from animals 
where species = 'Dog'
and 
breed != 'Bullmastiff';

-- to query every breed and involving a null

select *
from animals 
where species = 'Dog'
and (
breed != 'Bullmastiff'
or
breed  isnull);

-- to check about the result 

select
(select count(*) 
from animals
where species = 'Dog' )
-
(select count(*)
from animals
where breed = 'Bullmastiff') as check ;



 
-- people were born in the same year 
select * from persons;

select extract(year from birth_date) as Year , count(*) as Number_of_persons  
from persons
group by extract(year from birth_date) ;



-- age instead of their year born 

select  ( extract(year from current_timestamp) - extract(year from birth_date)) as Year , count(*) as Number_of_persons  
from persons
group by extract(year from birth_date)
order by 1 desc ;



-- find how many potential hoarders our shelter serves  
 
select adopter_email, count(*) as Number_of_adoptions
from adoptions 
group by 1
order by 2 desc ;


-- find how many potential hoarders our shelter serves 
-- only persons who adapted more than one animals 

select adopter_email, count(*) as Number_of_adoptions
from adoptions 
group by 1
having count(*) > 1
order by 2 desc ;



/*
Animal vaccination report
--------------------------
Write a query to report the number of vaccinations each animal has received.
Include animals that were never adopted.
Exclude all rabbits.
Exclude all Rabies vaccinations.
Exclude all animals that were last vaccinated on or after October first, 2019.
The report should return the following attributes:
Animals Name, Species, Primary Color, Breed,
and the number of vaccinations this animal has received,
-- Guidelines
Use the correct logical join types and force order if needed.
Use the  correct logical group by expressions.
*/
select * from vaccinations ;


select an.name, an.Species, (an.Primary_Color), an.breed, count(va.vaccine) as number_of_vaccinations
from animals an
left join vaccinations va
on an.name = va.name and an.species = va.species
where an.Species != 'Rabbit' and (va.vaccine != 'Rabies' or va.vaccine  isnull)
group by 1, 2
HAVING max(va.vaccination_time )< '2019-10-01' or max(va.vaccination_time ) isnull
ORDER by an.Species, an.Name ;


-- 



















































































