
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0241' 
BEGIN

	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('ATT014','Roster Table Group', 'Attendance', 0)

	CREATE TABLE RosterTableGroup
	(
		RosterTableGroupID int NOT NULL IDENTITY (1, 1),
		RosterTableGroupCode NVARCHAR(200) NULL,
		RosterTableGroupDesc NVARCHAR(255) NULL,
		RosterClientID int NULL,
		RosterClientSiteID int NULL,
		CONSTRAINT PK_RosterTableGroup PRIMARY KEY CLUSTERED 
		(
			RosterTableGroupID
		) 
	)
		
	ALTER TABLE EmpPositionInfo ADD 
		RosterTableGroupID int NULL,
		EmpPosIsRosterTableGroupSupervisor int NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0242'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





