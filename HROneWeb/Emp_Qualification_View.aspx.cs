using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using HROne.DataAccess;
//using perspectivemind.validation;
using HROne.Lib.Entities;

public partial class Emp_Qualification_View : HROneWebPage
{
    private const string FUNCTION_CODE = "PER004";
    public Binding binding;
    public DBManager db = EEmpQualification.db;
    public EEmpQualification obj;
    public int CurID = -1;
    public int CurEmpID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebUtils.CheckAccess(Response, Session, FUNCTION_CODE, WebUtils.AccessLevel.Read))
            return;
        toolBar.FunctionCode = FUNCTION_CODE;

        binding = new Binding(dbConn, db);
        binding.add(EmpQualificationID);
        binding.add(EmpID);
        binding.add(new LabelVLBinder(db,QualificationID, EQualification.VLQualification));
        binding.add(EmpQualificationInstitution);
        binding.add(new LabelVLBinder(db, EmpQualificationLearningMethod, EEmpQualification.VLLearningMethod));
        binding.add(EmpQualificationFrom);
        binding.add(EmpQualificationTo);
        binding.add(EmpQualificationRemark);
        binding.init(Request, Session);

        if (!int.TryParse(DecryptedRequest["EmpQualificationID"], out CurID))
            CurID = -1;

        if (!int.TryParse(DecryptedRequest["EmpID"], out CurEmpID))
            CurEmpID = -1;


        EmpID.Value = CurEmpID.ToString();

        HROne.Common.WebUtility.WebControlsLocalization(this, this.Controls);

        if (!Page.IsPostBack)
        {
            if (CurID > 0)
                loadObject();
            else
                toolBar.DeleteButton_Visible = false;
        }
    }
    protected bool loadObject() 
    {
	    obj=new EEmpQualification();
	    bool isNew=WebFormWorkers.loadKeys(db, obj, DecryptedRequest);

        DBFilter filter = new DBFilter();
        filter.add(new Match("EmpID", CurEmpID));
        filter.add(WebUtils.AddRankFilter(Session, "EmpID", true));
        if (EEmpPersonalInfo.db.count(dbConn, filter) == 0)
            if (CurEmpID <= 0)
                return false;
            else
                HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "~/AccessDeny.aspx");

        if (!db.select(dbConn, obj))
            if (CurID <= 0)
                return false;
            else
                HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "~/AccessDeny.aspx");

        if (obj.EmpID != CurEmpID)
            if (CurID <= 0)
                return false;
            else
                HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "~/AccessDeny.aspx");

	    Hashtable values=new Hashtable();
	    db.populate(obj,values);
	    binding.toControl(values);


        return true;
    }


    protected void Delete_Click(object sender, EventArgs e)
    {

        EEmpQualification c = new EEmpQualification();
        c.EmpQualificationID = CurID;
        db.select(dbConn, c);
        WebUtils.StartFunction(Session, FUNCTION_CODE, c.EmpID);
        db.delete(dbConn, c);
        WebUtils.EndFunction(dbConn);
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "EmpTab_SkillSet_View.aspx?EmpID=" + EmpID.Value);
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "Emp_Qualification_Edit.aspx?EmpQualificationID=" + EmpQualificationID.Value + "&EmpID=" + EmpID.Value);
    }

    protected void Back_Click(object sender, EventArgs e)
    {
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "EmpTab_SkillSet_View.aspx?EmpID=" + EmpID.Value);
    }
}
