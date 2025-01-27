
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.1.485' 
BEGIN
	
	CREATE TABLE PayrollGroupLeaveCodeSetupOverride
	(
		PayrollGroupLeaveCodeSetupOverrideID INT NOT NULL IDENTITY (1, 1),
		PayrollGroupID INT NULL,
		LeaveCodeID INT NULL,
		PayrollGroupLeaveCodeSetupLeaveAllowPaymentCodeID INT NULL,
		PayrollGroupLeaveCodeSetupLeaveAllowFormula INT NULL,
		PayrollGroupLeaveCodeSetupLeaveDeductPaymentCodeID INT NULL,
		PayrollGroupLeaveCodeSetupLeaveDeductFormula INT NULL,
		CONSTRAINT PK_PayrollGroupLeaveCodeSetupOverride PRIMARY KEY CLUSTERED 
		(
			PayrollGroupLeaveCodeSetupOverrideID
		) 
	)
	           
	INSERT INTO CompanyBankAccount
		(CompanyBankAccountBankCode, CompanyBankAccountBranchCode, CompanyBankAccountAccountNo, CompanyBankAccountHolderName)
	SELECT DISTINCT 
		CompanyBankCode, CompanyBranchCode, CompanyBankAccountNo, CompanyBankHolderName
	FROM Company c
	WHERE NOT EXISTS
	(
		SELECT * 
		FROM CompanyBankAccount cba
		WHERE cba.CompanyBankAccountBankCode=c.CompanyBankCode
		AND cba.CompanyBankAccountBranchCode=c.CompanyBranchCode
		AND cba.CompanyBankAccountAccountNo=c.CompanyBankAccountNo
		AND cba.CompanyBankAccountHolderName=c.CompanyBankHolderName
	)
	AND CompanyBankCode<>CompanyBranchCode
	AND CompanyBranchCode<>CompanyBankAccountNo
	AND CompanyBankAccountNo<>CompanyBankHolderName

	INSERT INTO CompanyBankAccountMap
		(CompanyBankAccountID, CompanyID)
	SELECT cba.CompanyBankAccountID, c.CompanyID
	FROM CompanyBankAccount cba, Company c
	WHERE cba.CompanyBankAccountBankCode=c.CompanyBankCode
	AND cba.CompanyBankAccountBranchCode=c.CompanyBranchCode
	AND cba.CompanyBankAccountAccountNo=c.CompanyBankAccountNo
	AND cba.CompanyBankAccountHolderName=c.CompanyBankHolderName

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.486'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





