
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.11.0248' 
BEGIN

	ALTER Table EmpPositionInfo ADD
		EmpPosRemark NTEXT NULL
		
	ALTER TABLE RequestLeaveApplication ADD
		RequestLeaveAppHasMedicalCertificate INT NULL
		
	ALTER TABLE EmpRequest ADD
		EmpRequestRejectReason NTEXT NULL
		
	Update EmpPayroll
		SET EmpPayTotalWorkingHours=0
		WHERE EmpPayTotalWorkingHours IS NULL

		
	UPDATE PayrollProrataFormula
		SET PayFormDesc='Payment within Payroll Cycle / ([Calendar Days - Rest Days] within Payroll Cycle)'
		WHERE PayFormCode='SYS004'
		
	UPDATE MPFSCHEME
		SET MPFSchemeDesc='AXA MPF - SMART PLAN'
		WHERE MPFSchemeCode='MT00180'
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.11.0249'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





