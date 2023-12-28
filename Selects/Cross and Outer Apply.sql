-- Goal:  Find clients with wrong last receipt info on the client table, accordng to the receipt table and the generate receipt task's that have failed.
select 
	c.CLIENT_ID,	
	c.LAST_RECEIPT_ISSUED_DATE,
	ra.INVOICE_DUE_DATE,
	ra.ISSUED_YEAR_MONTH,
	ra.CLIENT_ID,
	ta.TASK_ID
from Client c(nolock)
-- Alter results
cross apply (
		select top 1 * 
		from Receipt r(nolock) 
		where 1=1
		and c.CLIENT_ID = r.CLIENT_ID 
		and r.RECEIPT_STATUS <> 2 -- Canceled
		order by r.INVOICE_DUE_DATE desc
		) ra -- Line with the last issued receipt info
-- Don't alter results
outer apply (
		select top 1 * 
		from ApplicationTask a(nolock) 
		where 1=1
		and a.CLIENT_ID = c.CLIENT_ID and a.EXECUTION_ERROR = 1 and a.TASK_TYPE = 102
		) ta -- Line with last generate receipt task with error info
where 1=1
and Year(c.LAST_RECEIPT_ISSUED_DATE) <>  Year(ra.INVOICE_DUE_DATE)   -- Different from last receipt em
	or (Year(c.ISSUED) = Year(ra.INVOICE_DUE_DATE) and Month(c.ISSUED) <> Month(ra.INVOICE_DUE_DATE)) -- Same year, different dates
and c.CLIENT_CONTRACT_STATUS <> 6523 -- Canceled
and c.ACTIVE = 1
order by c.CLIENT_ID desc;