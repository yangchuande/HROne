
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.539' 
BEGIN

	DROP TABLE EmpRosterTableGroup
	
	CREATE TABLE EmpRosterTableGroup
	(
		EmpRosterTableGroupID INT NOT NULL IDENTITY (1, 1),
		EmpID INT NULL,
		EmpRosterTableGroupEffFr DATETIME NULL,
		EmpRosterTableGroupEffTo DATETIME NULL,
		RosterTableGroupID INT NULL,
		EmpRosterTableGroupIsSupervisor INT NULL,
		CONSTRAINT PK_EmpRosterTableGroup PRIMARY KEY CLUSTERED 
		(
			EmpRosterTableGroupID
		) 
	)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.541'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





