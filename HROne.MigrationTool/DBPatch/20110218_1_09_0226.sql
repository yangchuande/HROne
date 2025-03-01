
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.09.0220' 
BEGIN

	CREATE TABLE Tmp_RequestLeaveApplication
	(
		RequestLeaveAppID int NOT NULL IDENTITY (1, 1),
		EmpID int NULL,
		RequestLeaveCodeID int NULL,
		RequestLeaveAppUnit nvarchar(50) NULL,
		RequestLeaveAppDateFrom datetime NULL,
		RequestLeaveAppDateTo datetime NULL,
		RequestLeaveAppTimeFrom datetime NULL,
		RequestLeaveAppTimeTo datetime NULL,
		RequestLeaveDays real NULL,
		RequestLeaveAppRemark ntext NULL,
		RequestLeaveAppCreateDate datetime NULL
	)  ON [PRIMARY]
		 TEXTIMAGE_ON [PRIMARY]
	SET IDENTITY_INSERT Tmp_RequestLeaveApplication ON
	IF EXISTS(SELECT * FROM RequestLeaveApplication)
		 EXEC('INSERT INTO Tmp_RequestLeaveApplication (RequestLeaveAppID, EmpID, RequestLeaveCodeID, RequestLeaveAppUnit, RequestLeaveAppDateFrom, RequestLeaveAppDateTo, RequestLeaveAppTimeFrom, RequestLeaveAppTimeTo, RequestLeaveDays, RequestLeaveAppRemark, RequestLeaveAppCreateDate)
			SELECT RequestLeaveAppID, EmpID, RequestLeaveCodeID, RequestLeaveAppUnit, RequestLeaveAppDateFrom, RequestLeaveAppDateTo, RequestLeaveAppTimeFrom, RequestLeaveAppTimeTo, RequestLeaveDays, CONVERT(ntext, RequestLeaveAppRemark), RequestLeaveAppCreateDate FROM RequestLeaveApplication WITH (HOLDLOCK TABLOCKX)')
	SET IDENTITY_INSERT Tmp_RequestLeaveApplication OFF
	DROP TABLE RequestLeaveApplication
	EXECUTE sp_rename N'Tmp_RequestLeaveApplication', N'RequestLeaveApplication', 'OBJECT' 
	ALTER TABLE RequestLeaveApplication ADD CONSTRAINT
		PK_RequestLeaveApplication PRIMARY KEY CLUSTERED 
		(
			RequestLeaveAppID
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]



   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.09.0226'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





