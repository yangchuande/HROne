
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.490' 
BEGIN

	CREATE TABLE AuthorizerDelegate
	(
		AuthorizerDelegateID INT NOT NULL IDENTITY (1, 1),
		EmpID INT NULL,
		AuthorizerDelegateEmpID INT NULL,
		CONSTRAINT PK_AuthorizerDelegate PRIMARY KEY CLUSTERED 
		(
			AuthorizerDelegateID
		) 
	)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.491'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





