
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.2.563' 
BEGIN

	UPDATE PaymentCode
	SET PaymentCodeIsProrataStatutoryHoliday=PaymentCodeIsProrataLeave
	WHERE PaymentCodeIsProrataStatutoryHoliday IS NULL

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.2.565.3'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





