
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.416' 
BEGIN

	ALTER TABLE PayrollGroup ADD 
		PayGroupTerminatedALCompensationIsSkipRoundingRule INT NULL,
		RecordCreatedDateTime DATETIME NULL,
		RecordCreatedBy INT NULL,
		RecordLastModifiedDateTime DATETIME NULL,
		RecordLastModifiedBy INT NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.418'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





