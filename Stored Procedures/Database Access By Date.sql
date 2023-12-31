USE [USER_DATABASE]
GO

ALTER PROCEDURE [dbo].[PR_LOG_ACCESS] 
(
		@INITIAL_DATE	AS DATE
	,	@FINAL_DATE		AS DATE
)
AS
	SELECT		    R.DATE
	,				R.HOUR	
	,				R.START		
	,				R.IP_ADDRESS
	,				R.SESSION
	,				R.USER			AS	LOGIN
	,				R.DURATION
	FROM			dbo.fnListClientAcess( @INITIAL_DATE, @FINAL_DATE, NULL ) R
	ORDER BY 	R.INITIAL_DATE