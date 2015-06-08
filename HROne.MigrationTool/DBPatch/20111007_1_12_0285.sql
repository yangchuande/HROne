
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.12.0281' 
BEGIN

	
	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('RPT212','Long Service Payment / Severance Payment Estimation List', 'Payroll & MPF Reports', 0)

		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.12.0285'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





