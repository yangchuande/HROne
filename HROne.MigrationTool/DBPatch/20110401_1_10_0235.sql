
DECLARE @DBVERSION as varchar(100);
set @DBVERSION = (Select ParameterValue from SystemParameter where ParameterCode='DBVERSION');

IF @DBVERSION='1.10.0231' 
BEGIN

	ALTER TABLE PayrollGroup ADD
		PayGroupPayAdvanceCompareTotalPaymentOnly int NULL
		
	Update TaxPayment
		Set TaxPayDesc='Any Other Rewards, Allowances or Perquisites. Nature: '
		Where TaxPayDesc='Any Other Rewards, Alloeances or Perquisites. Nature: '

	Update TaxPayment
		Set TaxPayDesc='Other Rewards, Allowances or Perquisites, e.g. Bonus, Education Benefits, Shares'
		Where TaxPayDesc='Other Rewards, Alloeances or Perquisites, e.g. Bonus, Education Benefits, Shares'

	INSERT INTO SystemFunction
    (	FunctionCode
       ,Description
       ,FunctionCategory
       ,FunctionIsHidden)
     VALUES
           ('RPT210','Statutory Minimum Wage Summary Report', 'Payroll & MPF Reports', 0)

   	-- Insert version of Database --
	Update SystemParameter 
	set ParameterValue='1.10.0235'
	where ParameterCode='DBVERSION';
	print ('Upgrade Successfully');

END
ELSE
print ('Incorrect Version: ' + @DBVERSION);





