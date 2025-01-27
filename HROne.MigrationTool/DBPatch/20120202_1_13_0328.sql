
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0327' 
BEGIN

	ALTER TABLE MPFScheme ADD
		MPFSchemeTrusteeCode NVARCHAR(50) NULL
		
	CREATE INDEX IDX_EmpPayroll_EmpID ON EmpPayroll 
	(
		EmpID 
	)
		  
	CREATE INDEX IDX_EmpPayroll_PayPeriodID ON EmpPayroll 
	(
		PayPeriodID 
	)

	CREATE INDEX IDX_EmpPayroll_PayBatchID ON EmpPayroll 
	(
		PayBatchID 
	)

	CREATE INDEX IDX_PaymentRecord_PayRecMethod ON PaymentRecord 
	(
		PayRecMethod 
	)


	CREATE INDEX IDX_MPFRecord_EmpPayrollID ON MPFRecord 
	(
		EmpPayrollID 
	)

	CREATE INDEX IDX_ORSORecord_EmpPayrollID ON ORSORecord 
	(
		EmpPayrollID 
	)
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0328'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





