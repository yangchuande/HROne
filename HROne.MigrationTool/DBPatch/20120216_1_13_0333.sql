
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0329' 
BEGIN

	UPDATE LeavePlan
	SET LeavePlanCommonLeaveYearStartMonth=1
	WHERE LeavePlanCommonLeaveYearStartMonth IS NULL
	AND LeavePlanUseCommonLeaveYear<>0

	UPDATE LeavePlan
	SET LeavePlanCommonLeaveYearStartDay=1
	WHERE LeavePlanCommonLeaveYearStartDay IS NULL
	AND LeavePlanUseCommonLeaveYear<>0

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0333'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





