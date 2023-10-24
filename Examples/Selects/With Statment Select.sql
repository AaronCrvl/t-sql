-- Using the WITH statement
with DeactivatedClients as (
 select p.PERSON_NAME, c.CLIENT_ID 
 from Client c(nolock) 
 inner join Person p(nolock) on p.PERSON_ID = c.PERSON_ID	
 where IS_ACTIVE = 0
)
select * from DeactivatedClients -- Short version of a existing table stored in object