
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.0.483' 
BEGIN
	
	CREATE TABLE CompanyBankAccount
	(
		CompanyBankAccountID INT NOT NULL IDENTITY (1, 1),
		CompanyBankAccountBankCode nvarchar(30) NULL,
		CompanyBankAccountBranchCode nvarchar(30) NULL,
		CompanyBankAccountAccountNo nvarchar(255) NULL,
		CompanyBankAccountHolderName nvarchar(255) NULL,
		CONSTRAINT PK_CompanyBankAccount PRIMARY KEY CLUSTERED 
		(
			CompanyBankAccountID
		) 
	)
	           
	CREATE TABLE CompanyBankAccountMap
	(
		CompanyBankAccountMapID INT NOT NULL IDENTITY (1, 1),
		CompanyID INT NULL,
		CompanyBankAccountID INT NULL,
		CONSTRAINT PK_CompanyBankAccountMap PRIMARY KEY CLUSTERED 
		(
			CompanyBankAccountMapID
		)
	)
			
   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.1.485'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





