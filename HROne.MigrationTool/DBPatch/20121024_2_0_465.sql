
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.463' 
BEGIN
	
	ALTER TABLE AttendanceFormula ADD 
		AttendanceFormulaIsUseRosterCodeForDefaultWorkHourPerDay INT NULL

           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.465'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





