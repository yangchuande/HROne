
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0245' 
BEGIN

		
	ALTER TABLE AttendancePlan ADD 
		AttendancePlanAbsentProrataPayFormID int NULL,
		AttendancePlanCompensateLateByOT int NULL,
		AttendancePlanTerminatedHasBonus int NULL
		
	ALTER Table RosterCode ADD
		RosterCodeLunchDurationHour REAL NULL
		
	ALTER TABLE WorkHourPattern ADD
		WorkHourPatternSunWorkHoursPerDay REAL NULL,
		WorkHourPatternSunLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternMonWorkHoursPerDay REAL NULL,
		WorkHourPatternMonLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternTueWorkHoursPerDay REAL NULL,
		WorkHourPatternTueLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternWedWorkHoursPerDay REAL NULL,
		WorkHourPatternWedLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternThuWorkHoursPerDay REAL NULL,
		WorkHourPatternThuLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternFriWorkHoursPerDay REAL NULL,
		WorkHourPatternFriLunchTimeHoursPerDay REAL NULL,
		WorkHourPatternSatWorkHoursPerDay REAL NULL,
		WorkHourPatternSatLunchTimeHoursPerDay REAL NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0246'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





