
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.535' 
BEGIN

	ALTER TABLE Authorizer ADD
		AuthorizerSkipEmailAlert INT NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.536'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





