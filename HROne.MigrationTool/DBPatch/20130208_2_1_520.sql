
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.519' 
BEGIN
           
	CREATE TABLE eChannelAuthorizedSignature
	(
		eChannelAuthorizedSignatureID INT NOT NULL IDENTITY (1, 1),
		UserID INT NULL,
		CONSTRAINT PK_eChannelAuthorizedSignature PRIMARY KEY CLUSTERED 
		(
			eChannelAuthorizedSignatureID
		) 
	)
			
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.520'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





