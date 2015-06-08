
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0325' 
BEGIN

	ALTER TABLE LeavePlan ADD
		LeavePlanUseCommonLeaveYear int NULL,
		LeavePlanCommonLeaveYearStartMonth int NULL,
		LeavePlanCommonLeaveYearStartDay int NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0326'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





