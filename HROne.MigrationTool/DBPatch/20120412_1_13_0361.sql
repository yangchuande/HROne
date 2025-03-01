
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0358' 
BEGIN

	--	Add DROP INDEX for some of the client that may created the index by themselves
	--DROP INDEX IDX_EmpPositionInfo_EmpID ON EmpPositionInfo 

	CREATE INDEX IDX_AuditTrailDetail_AuditTrailID ON AuditTrailDetail 
	(
		AuditTrailID
	)
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0361'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





