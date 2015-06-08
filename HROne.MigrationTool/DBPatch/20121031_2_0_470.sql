
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.465' 
BEGIN
	
	ALTER TABLE EmpRecurringPayment ALTER COLUMN 
		EmpRPRemark NTEXT NULL

           
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.470'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





