
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.08.0210' 
BEGIN

	Update LeaveType
		Set LeaveTypeIsUseWorkHourPattern = 1
	UPDATE LeaveType
		SET LeaveTypeIsSkipStatutoryHolidayChecking = 0
	UPDATE LeaveType
		SET LeaveTypeIsSkipPublicHolidayChecking = 0

	UPDATE LeaveType
		SET LeaveTypeIsUseWorkHourPattern = 0
		WHERE LeaveType='MAL'
		OR LeaveType='SLCAT1' 
		OR LeaveType='SLCAT2' 
		OR LeaveType='INJURY' 
		
	UPDATE LeaveType
		SET LeaveTypeIsSkipStatutoryHolidayChecking = 1
		WHERE LeaveType='MAL'

	UPDATE LeaveType
		SET LeaveTypeIsSkipPublicHolidayChecking = 1
		WHERE LeaveType='MAL'
		OR LeaveType='SLCAT1' 
		OR LeaveType='SLCAT2' 
		OR LeaveType='INJURY' 

	Alter Table PayrollGroup ADD
		PayGroupTerminatedALCompensationEligibleAfterProrata int NULL,
		PayGroupTerminatedALCompensationEligiblePeriod int NULL,
		PayGroupTerminatedALCompensationEligibleUnit int NULL,
		PayGroupTerminatedALCompensationEligibleCheckEveryCommonLeaveYear int NULL

	Alter Table LeavePlan ADD
		LeavePlanUseCommonLeaveYear int NULL,
		LeavePlanCommonLeaveYearStartMonth int NULL,
		LeavePlanCommonLeaveYearStartDay int NULL
	

	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.08.0211'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





