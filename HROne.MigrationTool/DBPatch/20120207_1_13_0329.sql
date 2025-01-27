
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.13.0328' 
BEGIN

	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='HSBC'
		WHERE MPFSchemeCode='MT00555'
		OR MPFSchemeCode='MT00245'
		OR MPFSchemeCode='MT00261'
		  
	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='HangSeng'
		WHERE MPFSchemeCode='MT00253'
		OR MPFSchemeCode='MT0027A'

	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='AIA'
		WHERE MPFSchemeCode='MT00431'
		OR MPFSchemeCode='MT00156'
		OR MPFSchemeCode='MT00172'

	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='AXA'
		WHERE MPFSchemeCode='MT00180'

	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='BOCI'
		WHERE MPFSchemeCode='MT00091'
		OR MPFSchemeCode='MT00105'

	UPDATE MPFScheme
		SET MPFSchemeTrusteeCode='Manulife'
		WHERE MPFSchemeCode='MT00377'
		OR MPFSchemeCode='MT00482'

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.13.0329'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





