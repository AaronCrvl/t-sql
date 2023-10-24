USE [USER_DATABASE]
GO

ALTER PROCEDURE [dbo].[PR_CLEAN_OLD_DATA]
AS
BEGIN	
    -- only keep registers with less then 1 year since creation
	-- apenas registros com menos 1 anos desde sua criação 
	delete from WebServiceLog where CREATION_DATE < getdate() - 360
	
    -- only keep registers with less then 10 days since creation
	-- apenas registros com menos 10 dias desde sua criação 
	delete from MessageQueue where CREATION_DATE < getdate() - 10

    -- only keep registers with less then 180 days since creation
	-- apenas registros com menos 180 dias desde sua criação 
	delete from JobQueueExecutionLog where REGISTER_DATE < getdate()  -180

	-- only keep registers with less then 1 year since creation
	-- apenas registros com menos 1 anos desde sua criação 
	delete from UserLog where  REGISTER_DATE < getdate() - 360
	delete from UserLog where ID_LOG in (select ID_LOG from UserLogDetail(nolock) where CREATION_DATE < getdate() - 360)
END