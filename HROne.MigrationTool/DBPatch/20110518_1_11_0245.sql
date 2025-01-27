
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0244' 
BEGIN

		
	ALTER TABLE AttendancePlan ADD 
		AttendancePlanUseBonusAmountByRecurringPayment int NULL,
		AttendancePlanProrataBonusforNewJoin int NULL,
		AttendancePlanProrataBonusforTerminated int NULL
		
	ALTER TABLE EmpRecurringPayment ADD 
		EmpRPIsNonPayrollItem int NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0245'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





