
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.517' 
BEGIN
           
	ALTER TABLE AttendancePlanAdditionalPayment ADD
		AttendancePlanAdditionalPaymentMaxLateMins INT NULL,
		AttendancePlanAdditionalPaymentMaxEarlyLeaveMins INT NULL,
		AttendancePlanAdditionalPaymentMinOvertimeMins INT NULL,
		AttendancePlanAdditionalPaymentRosterAcrossTime DATETIME NULL
	
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.518'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





