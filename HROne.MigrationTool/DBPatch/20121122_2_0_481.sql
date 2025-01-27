
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.480' 
BEGIN
	
	ALTER TABLE PayrollGroup DROP COLUMN
		PayGroupLeaveDefaultCutOffDay
	ALTER TABLE PayrollGroup ADD 
		PayGroupLeaveDefaultFirstCutOffDay int NULL
	ALTER TABLE PayrollGroup ADD 
		PayGroupLeaveDefaultNextCutOffDay int NULL
           
	UPDATE EmpRecurringPayment 
		SET	EmpRPUnitPeriodAsDaily = 0
		WHERE EmpRPUnitPeriodAsDaily IS NULL
		
	UPDATE EmpRecurringPayment 
		SET	EmpRPUnitPeriodAsDailyPayFormID  = 0
		WHERE EmpRPUnitPeriodAsDailyPayFormID IS NULL
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.481'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





