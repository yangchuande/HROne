
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.12.0311' 
BEGIN

		
	ALTER TABLE YEBPlan ADD
		YEBPlanEligiblePeriodIsCheckEveryYEBYear int null,
		YEBPlanEligiblePeriodIsExcludeMax3MonthsProbation int null
		

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.12.0312'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





