
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.12.0293' 
BEGIN

	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('LEV005','Import Leave Balance Adjustment', 'Leave', 0)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.12.0294'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





