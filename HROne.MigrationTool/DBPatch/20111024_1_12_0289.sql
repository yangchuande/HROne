
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.12.0285' 
BEGIN

	ALTER TABLE AttendanceRecord ADD 
		AttendanceRecordWorkStartLocation NVARCHAR(255) NULL,
		AttendanceRecordWorkEndLocation NVARCHAR(255) NULL,
		AttendanceRecordLunchOutLocation NVARCHAR(255) NULL,		
		AttendanceRecordLunchInLocation NVARCHAR(255) NULL		

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.12.0289'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





