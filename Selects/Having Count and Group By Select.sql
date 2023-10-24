-- Using Count and Group By
select p.PERSON_NAME, COUNT(CLIENT_ID) -- Count number of people with the same first name
from Client c (nolock)
inner join Person p (nolock) on p.PERSON_ID = c.PERSON_ID	
where 1=1
and PERSON_NAME = 'Peter%'
and IS_ACTIVE = 1
group by PERSON_NAME 
having COUNT(id_cliente) > 0;