
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.08.0213' 
BEGIN

	Create Table EmailLog
	(
		EmailLogID int NOT NULL IDENTITY (1, 1),
		EmailLogToAddress NVARCHAR(250) NULL,
		EmailLogStartTime datetime NULL,
		EmailLogEndTime datetime NULL,
		EmailLogTrialCount INT NULL,
		EmailLogIsFail INT NULL,
		EmailLogErrorMessage NTEXT NULL,
		CONSTRAINT PK_EmailLog PRIMARY KEY CLUSTERED 
		(
			EmailLogID
		)
	)
	
	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.08.0218'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





