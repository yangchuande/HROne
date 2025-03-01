
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.14.378' 
BEGIN

	UPDATE SystemFunction
	SET Description='P-fund Plan Setup'
	WHERE FunctionCode='MPF004';

	ALTER TABLE AuditTrail ADD
		ParentAuditTrailID INT NULL;
	
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.14.380'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





