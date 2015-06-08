
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.504' 
BEGIN

	ALTER TABLE MPFRecord ADD
		CostCenterID INT NULL

	ALTER TABLE ORSORecord ADD
		CostCenterID INT NULL
           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.513'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





