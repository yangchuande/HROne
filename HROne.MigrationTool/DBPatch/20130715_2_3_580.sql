
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.3.578' 
BEGIN
	
	ALTER TABLE PayrollGroup ADD
		PayGroupTerminatedPaymentInLieuMonthlyBaseMethodAlternative NVARCHAR(100) NULL,
		PayGroupTerminatedPaymentInLieuDailyFormulaAlternative INT NULL,
		PayGroupTerminatedLSPSPMonthlyBaseMethodAlternative NVARCHAR(100) NULL

	UPDATE LeaveType 
	SET LeaveTypeIsESSRestrictNegativeBalanceAsOfToday=1,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfApplicationDateFrom=1,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfApplicationDateTo=1,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfEndOfLeaveYear=1
	WHERE LeaveType='COMPENSATION'

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.3.580'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





