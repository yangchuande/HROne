
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='2.3.582' 
BEGIN
	
	CREATE TABLE LoginAudit
	(
		LoginAuditID INT NOT NULL IDENTITY (1, 1),
		UserID INT NULL,
		LoginAuditLoginID NVARCHAR(255) NULL,
		LoginAuditLoginMachine NVARCHAR(255) NULL,
		LoginAuditLoginIPAddress NVARCHAR(255) NULL,
		LoginAuditLoginAgent NTEXT NULL,
		LoginAuditLoginDateTime DATETIME NULL,
		LoginAuditIsLoginFail INT NULL,
		LoginAuditLoginErrorMesage NVARCHAR(255) NULL,
		CONSTRAINT PK_LoginAudit PRIMARY KEY CLUSTERED 
		(
			LoginAuditID
		) 		
	)

	CREATE TABLE ESSLoginAudit
	(
		ESSLoginAuditID INT NOT NULL IDENTITY (1, 1),
		EmpID INT NULL,
		ESSLoginAuditLoginID NVARCHAR(255) NULL,
		ESSLoginAuditLoginMachine NVARCHAR(255) NULL,
		ESSLoginAuditLoginIPAddress NVARCHAR(255) NULL,
		ESSLoginAuditLoginAgent NTEXT NULL,
		ESSLoginAuditLoginDateTime DATETIME NULL,
		ESSLoginAuditIsLoginFail INT NULL,
		ESSLoginAuditLoginErrorMesage NVARCHAR(255) NULL,
		CONSTRAINT PK_ESSLoginAudit PRIMARY KEY CLUSTERED 
		(
			ESSLoginAuditID
		) 		
	)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='2.3.584'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





