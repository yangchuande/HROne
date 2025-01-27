
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.436' 
BEGIN

	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('ECH000','e-channel Notification', 'e-channel', 0)

	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('ECH001','Submit Autopay File', 'e-channel', 0)
           
	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('ECH002','Submit MPF Contribution File', 'e-channel', 0)
           

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.0.446'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





