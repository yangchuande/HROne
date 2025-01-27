
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.3.584' 
BEGIN

	DELETE FROM MPFParameter
	WHERE MPFParamEffFr>='2013-11-01'

	INSERT INTO MPFParameter (MPFParamEffFr, MPFParamMinMonthly, MPFParamMaxMonthly, MPFParamMinDaily, MPFParamMaxDaily, MPFParamEEPercent, MPFParamERPercent)
	VALUES ('2013-11-01', 7100, 25000, 280, 830, 5, 5)
		
		
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.3.588'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





