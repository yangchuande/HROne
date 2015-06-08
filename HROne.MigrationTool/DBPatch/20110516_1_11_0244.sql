
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0242' 
BEGIN

		
	ALTER TABLE Users ADD 
		UserIsKeepConnected int NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0244'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





