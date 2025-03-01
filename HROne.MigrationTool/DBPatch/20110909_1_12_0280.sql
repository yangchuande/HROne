
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.12.0273' 
BEGIN

	--	Add DROP INDEX for some of the client that may created the index by themselves
	--DROP INDEX IDX_EmpPositionInfo_EmpID ON EmpPositionInfo 

	CREATE INDEX IDX_EmpPositionInfo_EmpID ON EmpPositionInfo 
	(
		EmpID 
	)
		
	CREATE INDEX IDX_EmpPositionInfo_CompanyID ON EmpPositionInfo 
	(
		CompanyID 
	)

	CREATE INDEX IDX_EmpPositionInfo_RankID ON EmpPositionInfo 
	(
		RankID 
	)

	Update MPFSCHEME
	SET MPFSchemeDesc='AIA MPF - Prime Value Choice'
	WHERE MPFSchemeCode='MT00172'

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.12.0280'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





