-- With Subquerie
SELECT DISTINCT *
FROM Person p (NOLOCK)
INNER JOIN Client c (NOLOCK) ON p.PERSON_ID = c.PERSON_ID
WHERE c.CLIENT_ID IN (
		SELECT c.CLIENT_ID
		FROM ClienteContract cc(NOLOCK)
		INNER JOIN ContractStatus sc(NOLOCK) ON cc.CONTRACT_STATUS_ID = sc.CONTRACT_STATUS_ID		
		WHERE 1=1
        AND cc.IS_ACTIVE = 1 
        AND c.CLIENT_ID NOT IN (24294, 25656, 656556, 58789) -- random client id that can be excluded form the search
    )
AND c.IS_ACTIVE = 1	
ORDER BY CONTRACT_ID
,CLIENT_ID
,PERSON_ID;	