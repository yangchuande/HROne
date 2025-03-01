using System;
using System.Collections;
using System.Text;
using HROne.Common;
using HROne.Lib.Entities;
using CrystalDecisions.CrystalReports.Engine;
using HROne.DataAccess;

namespace HROne.Reports.Employee
{
    public class EmployeeYearOfServiceProcess : GenericReportProcess
    {
        private ArrayList values;
        private DateTime AsOfDate;

        public EmployeeYearOfServiceProcess(DatabaseConnection dbConn, ArrayList EmpList, DateTime AsOfDate)
            : base(dbConn)
        {
            this.values = EmpList;
            this.AsOfDate = AsOfDate;
        }

        public override ReportDocument GenerateReport()
        {
            if (values.Count > 0)
            {

                DataSet.EmployeeDetail ds = new DataSet.EmployeeDetail();

                DataSet.EmployeeDetail.HierarchyLevelDataTable HierarchyLevelTable = ds.HierarchyLevel;
                DBFilter hierarchyLevelFilter = new DBFilter();
                hierarchyLevelFilter.add("HLevelSeqNo", true);
                ArrayList HierarchyLevelList = EHierarchyLevel.db.select(dbConn, hierarchyLevelFilter);
                foreach (EHierarchyLevel HierarchyLevel in HierarchyLevelList)
                {
                    DataSet.EmployeeDetail.HierarchyLevelRow row = HierarchyLevelTable.NewHierarchyLevelRow();
                    row.HLevelCode = HierarchyLevel.HLevelCode;
                    row.HLevelDesc = HierarchyLevel.HLevelDesc;
                    row.HLevelID = HierarchyLevel.HLevelID;
                    row.HLevelSeqNo = HierarchyLevel.HLevelSeqNo;
                    HierarchyLevelTable.Rows.Add(row);
                }

                int currentDummyPosID = 0;
                int currentDummyHierarchyID = 0;
                foreach (int EmpID in values)
                {
                    EmployeeDetailProcess.ImportEmployeeDetailRow(dbConn, ds.employeedetail, EmpID, AsOfDate);



                    {
                        DataSet.EmployeeDetail.EmpPositionInfoDataTable empPosTable = ds.EmpPositionInfo;
                        EEmpPositionInfo empPos = AppUtils.GetLastPositionInfo(dbConn, AsOfDate, EmpID);

                        if (empPos == null)
                        {
                            currentDummyPosID--;
                            DataSet.EmployeeDetail.EmpPositionInfoRow row = empPosTable.NewEmpPositionInfoRow();
                            row.EmpPosID = currentDummyPosID;
                            row.EmpID = EmpID;

                            empPosTable.AddEmpPositionInfoRow(row);

                            DataSet.EmployeeDetail.EmpHierarchyDataTable empHierarchyTable = ds.EmpHierarchy;
                            foreach (EHierarchyLevel hLevel in HierarchyLevelList)
                            {
                                currentDummyHierarchyID--;
                                DataSet.EmployeeDetail.EmpHierarchyRow empHierarchyRow = empHierarchyTable.NewEmpHierarchyRow();

                                empHierarchyRow.EmpHierarchyID = currentDummyHierarchyID;
                                empHierarchyRow.EmpID = EmpID;
                                empHierarchyRow.EmpPosID = currentDummyPosID;
                                empHierarchyRow.HLevelID = hLevel.HLevelID;
                                empHierarchyRow.HLevelSeqNo = hLevel.HLevelSeqNo;

                                empHierarchyTable.AddEmpHierarchyRow(empHierarchyRow);
                            }

                        }
                        else
                        {
                            DataSet.EmployeeDetail.EmpPositionInfoRow row = empPosTable.NewEmpPositionInfoRow();

                            row.CompanyID = empPos.CompanyID;
                            row.EmpID = empPos.EmpID;
                            row.EmpPosEffFr = empPos.EmpPosEffFr;
                            row.EmpPosEffTo = empPos.EmpPosEffTo;
                            row.EmpPosID = empPos.EmpPosID;
                            row.LeavePlanID = empPos.LeavePlanID;
                            row.PayGroupID = empPos.PayGroupID;

                            EPosition position = new EPosition();
                            position.PositionID = empPos.PositionID;
                            if (EPosition.db.select(dbConn, position))
                            {
                                row.PositionCode = position.PositionCode;
                                row.PositionDesc = position.PositionDesc;
                                row.PositionID = position.PositionID;
                            }

                            ERank rank = new ERank();
                            rank.RankID = empPos.RankID;
                            if (ERank.db.select(dbConn, rank))
                            {
                                row.RankCode = rank.RankCode;
                                row.RankDesc = rank.RankDesc;
                                row.RankID = rank.RankID;
                            }

                            row.StaffTypeID = empPos.StaffTypeID;

                            empPosTable.AddEmpPositionInfoRow(row);

                            DataSet.EmployeeDetail.EmpHierarchyDataTable empHierarchyTable = ds.EmpHierarchy;
                            foreach (EHierarchyLevel hLevel in HierarchyLevelList)
                            {
                                DBFilter empHierarchyFilter = new DBFilter();
                                empHierarchyFilter.add(new Match("EmpPosID", empPos.EmpPosID));
                                empHierarchyFilter.add(new Match("HLevelID", hLevel.HLevelID));

                                ArrayList empHierarchyList = EEmpHierarchy.db.select(dbConn, empHierarchyFilter);

                                DataSet.EmployeeDetail.EmpHierarchyRow empHierarchyRow = empHierarchyTable.NewEmpHierarchyRow();
                                empHierarchyRow.EmpID = EmpID;
                                empHierarchyRow.EmpPosID = empPos.EmpPosID;
                                empHierarchyRow.HLevelID = hLevel.HLevelID;
                                empHierarchyRow.HLevelSeqNo = hLevel.HLevelSeqNo;

                                if (empHierarchyList.Count > 0)
                                {
                                    EEmpHierarchy empHierarchy = (EEmpHierarchy)empHierarchyList[0];
                                    empHierarchyRow.EmpHierarchyID = empHierarchy.EmpHierarchyID;

                                    EHierarchyElement hElement = new EHierarchyElement();
                                    hElement.HElementID = empHierarchy.HElementID;
                                    EHierarchyElement.db.select(dbConn, hElement);
                                    empHierarchyRow.HElementCode = hElement.HElementCode;
                                    empHierarchyRow.HElementDesc = hElement.HElementDesc;
                                    empHierarchyRow.HElementID = hElement.HElementID;

                                }
                                else
                                {
                                    currentDummyHierarchyID--;
                                    empHierarchyRow.EmpHierarchyID = currentDummyHierarchyID;
                                }

                                empHierarchyTable.AddEmpHierarchyRow(empHierarchyRow);
                            }
                        }
                    }
                }

                DataSet.EmployeeDetail.PayrollGroupDataTable payrollGroupTable = ds.PayrollGroup;
                ArrayList payrollGroupList = EPayrollGroup.db.select(dbConn, new DBFilter());
                foreach (EPayrollGroup payrollGroup in payrollGroupList)
                {
                    DataSet.EmployeeDetail.PayrollGroupRow row = payrollGroupTable.NewPayrollGroupRow();
                    row.PayGroupCode = payrollGroup.PayGroupCode;
                    row.PayGroupDesc = payrollGroup.PayGroupDesc;
                    row.PayGroupID = payrollGroup.PayGroupID;
                    payrollGroupTable.Rows.Add(row);
                }

                DataSet.EmployeeDetail.PositionDataTable PositionTable = ds.Position;
                ArrayList PositionList = EPosition.db.select(dbConn, new DBFilter());
                foreach (EPosition Position in PositionList)
                {
                    DataSet.EmployeeDetail.PositionRow row = PositionTable.NewPositionRow();
                    row.PositionCode = Position.PositionCode;
                    row.PositionDesc = Position.PositionDesc;
                    row.PositionID = Position.PositionID;
                    PositionTable.Rows.Add(row);
                }

                DataSet.EmployeeDetail.BankListDataTable BankListTable = ds.BankList;
                ArrayList BankListList = EBankList.db.select(dbConn, new DBFilter());
                foreach (EBankList BankList in BankListList)
                {
                    DataSet.EmployeeDetail.BankListRow row = BankListTable.NewBankListRow();
                    row.BankCode = BankList.BankCode;
                    row.BankName = BankList.BankName;
                    BankListTable.Rows.Add(row);
                }


                //System.Data.DataSet ds = new System.Data.DataSet();                

                //string select;
                //string from;
                //DBFilter filter;
                //OR or;

                //foreach (int EmpID in values)
                //{

                    //from = "from EmpPersonalInfo e LEFT JOIN EmpTermination et ON et.EmpID=e.EmpID ";
                    //select = " e.*, et.EmpTermLastDate";
                    //filter = new DBFilter();
                    //filter.add(new Match("e.EmpID", EmpID));
                    //filter.loadData(ds, "employeedetail", null, select, from, null);

                    //from = "from EmpPositionInfo ";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                    //select = "* ";
                    //filter = new DBFilter();
                    //filter.add(new Match("EmpPosEffFr", "<=", AsOfDate));
                    //OR orEffToFilter = new OR();
                    //orEffToFilter.add(new Match("EmpPosEffTo", ">=", AsOfDate));
                    //orEffToFilter.add(new NullTerm("EmpPosEffTo"));
                    //filter.add(orEffToFilter);
                    //filter.add(new Match("EmpID", EmpID));
                    //filter.loadData(ds, "EmpPositionInfo", null, select, from, null);


                    //from = "from EmpRecurringPayment erp, PaymentCode pc";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                    //select = "* ";
                    //filter = new DBFilter();
                    //filter.add(new MatchField("erp.PayCodeID", "pc.PaymentCodeID"));
                    //filter.add(new Match("pc.PaymentTypeID", EPaymentType.SystemPaymentType.BasicSalaryPaymentType(dbConn).PaymentTypeID));
                    //filter.add(new Match("erp.EmpRPEffFr", "<=", AsOfDate));
                    //orEffToFilter = new OR();
                    //orEffToFilter.add(new Match("erp.EmpRPEffTo", ">=", AsOfDate));
                    //orEffToFilter.add(new NullTerm("erp.EmpRPEffTo"));
                    //filter.add(orEffToFilter);

                    //filter.add(new Match("EmpID", EmpID));
                    //filter.loadData(ds, "EmpRecurringPayment", null, select, from, null);
                //}
                //from = " from PayrollGroup ";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                //select = "* ";
                //filter = new DBFilter();
                //filter.loadData(ds, "PayrollGroup", null, select, from, null);

                //from = " from Position ";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                //select = "* ";
                //filter = new DBFilter();
                //filter.loadData(ds, "Position", null, select, from, null);

                //from = "from EmpHierarchy eh Left Join HierarchyElement he ON eh.HElementID=he.HElementID LEFT JOIN HierarchyLevel hl on hl.HLevelID=eh.HLevelID";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                //select = " eh.*, he.HElementCode, he.HElementDesc, hl.HLevelSeqNo";
                //filter = new DBFilter();
                //filter.add("HLevelSeqNo", true);
                //filter.loadData(ds, "EmpHierarchy", null, select, from, null);

                foreach (System.Data.DataRow row in ds.Tables["EmpHierarchy"].Rows)
                {
                    if (row.IsNull("HElementDesc"))
                        row["HElementDesc"] = "-";
                    if (string.IsNullOrEmpty(row["HElementDesc"].ToString()))
                        row["HElementDesc"] = "-";
                }

                //from = "from HierarchyLevel hl ";//EmpPos ON P.EmpID=EmpPos.EmpID AND EmpPos.EmpPosEffTo IS NULL LEFT JOIN Position Pos ON EmpPos.PositionID=Pos.PositionID";
                //select = " hl.* ";
                //filter = new DBFilter();
                //filter.add("HLevelSeqNo", true);
                //filter.loadData(ds, "HierarchyLevel", null, select, from, null);


                if (reportDocument == null)
                {
                    reportDocument = new ReportTemplate.Report_Employee_YearOfServiceList();
                }
                else
                {

                }




                reportDocument.SetDataSource(ds);
                reportDocument.SetParameterValue("AsOfDate", AsOfDate);

                return reportDocument;
            }
            else
                return null;
        }
    }
}
