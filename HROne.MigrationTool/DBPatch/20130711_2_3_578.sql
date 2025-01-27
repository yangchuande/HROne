
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.3.577' 
BEGIN
	
	ALTER Table LeaveType ADD
		LeaveTypeIsESSRestrictNegativeBalanceAsOfToday INT NULL,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfApplicationDateFrom INT NULL,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfApplicationDateTo INT NULL,
		LeaveTypeIsESSRestrictNegativeBalanceAsOfEndOfLeaveYear INT NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.3.578'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





