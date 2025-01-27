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

public partial class ESS_AuthorizationGroup_AddAuthorizer : HROneWebPage
{
    private const string FUNCTION_CODE = "SEC004";
    public Binding binding;
    public DBManager db = EEmpPersonalInfo.db;
    public EAuthorizationGroup obj;
    public int CurID = -1;
    protected SearchBinding addAuthorizerBinding;
    protected ListInfo info;
    protected DataView view;
    

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!WebUtils.CheckAccess(Response, Session, FUNCTION_CODE, WebUtils.AccessLevel.ReadWrite))
            return;
        
        //toolBar.FunctionCode = FUNCTION_CODE;

        binding = new Binding(dbConn, EAuthorizationGroup.db);
        binding.add(AuthorizationGroupID);
        binding.add(AuthorizationCode);
        binding.add(AuthorizationDesc);
        binding.init(Request, Session);

        addAuthorizerBinding = new SearchBinding(dbConn, EEmpPersonalInfo.db);
        addAuthorizerBinding.initValues("EmpStatus", null, EEmpPersonalInfo.VLEmpStatus, null);
        addAuthorizerBinding.init(DecryptedRequest, null);

        info = ListFooter.ListInfo;

        if (!int.TryParse(DecryptedRequest["AuthorizationGroupID"], out CurID))
            CurID = -1;

        HROne.Common.WebUtility.WebControlsLocalization(this, this.Controls);
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            EmployeeSearchControl1.EmpStatusValue = "A";

            if (CurID > 0)
            {
                loadObject();
                view = loadData(info, db, Repeater);
            }
            else
            {
                //toolBar.DeleteButton_Visible = false;
            }
        }
    }
    protected bool loadObject() 
    {
        obj = new EAuthorizationGroup();
        bool isNew = WebFormWorkers.loadKeys(EAuthorizationGroup.db, obj, DecryptedRequest);
        if (!EAuthorizationGroup.db.select(dbConn, obj))
		    return false;

	    Hashtable values=new Hashtable();
        EAuthorizationGroup.db.populate(obj, values);
	    binding.toControl(values);



        return true;
    }

    public DataView loadData(ListInfo info, DBManager db, Repeater repeater)
    {
        DBFilter filter = addAuthorizerBinding.createFilter();

        //if (info != null && info.orderby != null && !info.orderby.Equals(""))
        //    filter.add(info.orderby, info.order);

        string select = "e.* ";
        string from = "from [" + EEmpPersonalInfo.db.dbclass.tableName + "] e ";//LEFT JOIN " + EEmpPositionInfo.db.dbclass.tableName + " p ON c.EmpID=p.EmpID AND p.EmpPosEffTo IS NULL";

        filter.add(WebUtils.AddRankFilter(Session, "e.EmpID", true));
        

        DBFilter empAuthorizerFilter = new DBFilter();
        empAuthorizerFilter.add(new MatchField("e.empid", "ar.empid"));
        empAuthorizerFilter.add(new Match("ar.AuthorizationGroupID", CurID));

        filter.add(new Exists(EAuthorizer.db.dbclass.tableName + " ar", empAuthorizerFilter, true));

        DBFilter empInfoFilter = EmployeeSearchControl1.GetEmpInfoFilter(AppUtils.ServerDateTime(), AppUtils.ServerDateTime());
        empInfoFilter.add(new MatchField("e.EmpID", "ee.EmpID"));
        filter.add(new Exists(EEmpPersonalInfo.db.dbclass.tableName + " ee", empInfoFilter));

        DataTable table = filter.loadData(dbConn, null, select, from);
        table = EmployeeSearchControl1.FilterEncryptedEmpInfoField(table, info);
        view = new DataView(table);
        ListFooter.Refresh();

        if (repeater != null)
        {
            repeater.DataSource = view;
            repeater.DataBind();
        }

        return view;
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        info.page = 0;
        view = loadData(info, db, Repeater);

    }
    protected void Reset_Click(object sender, EventArgs e)
    {
        addAuthorizerBinding.clear();
        EmployeeSearchControl1.Reset();
        EmployeeSearchControl1.EmpStatusValue = "A";
        info.page = 0;
        //info = new ListInfo();
        //int page = 0;
        //info.loadState(Request, page);

        //foreach (RepeaterItem item in HierarchyLevel.Items)
        //{
        //    DropDownList c = (DropDownList)item.FindControl("HElementID");
        //    c.SelectedIndex = 0;
        //}
        view = loadData(info, db, Repeater);

    }

    //protected void FirstPage_Click(object sender, EventArgs e)
    //{
    //    //loadState();
    //    //info.page = 0;
    //    view = loadData(info, db, Repeater);

    //}
    //protected void PrevPage_Click(object sender, EventArgs e)
    //{
    //    //loadState();
    //    //info.page--;
    //    view = loadData(info, db, Repeater);

    //}
    //protected void NextPage_Click(object sender, EventArgs e)
    //{
    //    //loadState();
    //    //info.page++;
    //    view = loadData(info, db, Repeater);

    //}
    //protected void LastPage_Click(object sender, EventArgs e)
    //{
    //    //loadState();

    //    //info.page = Int32.Parse(NumPage.Value);
    //    view = loadData(info, db, Repeater);

    //}
    protected void ChangeOrder_Click(object sender, EventArgs e)
    {
        LinkButton l = (LinkButton)sender;
        String id = l.ID.Substring(1);
        //loadState();
        if (info.orderby == null)
            info.order = true;
        else if (info.orderby.Equals(id))
            info.order = !info.order;
        else
            info.order = true;
        info.orderby = id;

        view = loadData(info, db, Repeater);

    }
    protected void Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataRowView row = (DataRowView)e.Item.DataItem;
        CheckBox cb = (CheckBox)e.Item.FindControl("ItemSelect");
        WebFormUtils.LoadKeys(EEmpPersonalInfo.db, row, cb);
        e.Item.FindControl("ItemSelect").Visible = true;//toolBar.DeleteButton_Visible;
    }



    protected void Back_Click(object sender, EventArgs e)
    {
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "ESS_AuthorizationGroup_View.aspx?AuthorizationGroupID=" + CurID);
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {

        WebUtils.StartFunction(Session, FUNCTION_CODE);
        foreach (RepeaterItem item in Repeater.Items)
        {
            CheckBox cb = (CheckBox)item.FindControl("ItemSelect");
            CheckBox AuthorizerIsReadOnly = (CheckBox)item.FindControl("AuthorizerIsReadOnly");
            CheckBox AuthorizerSkipEmailAlert = (CheckBox)item.FindControl("AuthorizerSkipEmailAlert");
            if (cb.Checked)
            {
                EEmpPersonalInfo o = new EEmpPersonalInfo();
                WebFormUtils.GetKeys(EEmpPersonalInfo.db, o, cb);

                DBFilter empAuthorizerFilter = new DBFilter();
                empAuthorizerFilter.add(new Match("empid", o.EmpID));
                empAuthorizerFilter.add(new Match("AuthorizationGroupID", CurID));
                if (EAuthorizer.db.count(dbConn, empAuthorizerFilter) <= 0)
                {
                    EAuthorizer authorizer = new EAuthorizer();
                    authorizer.EmpID = o.EmpID;
                    authorizer.AuthorizationGroupID = CurID;
                    authorizer.AuthorizerIsReadOnly = AuthorizerIsReadOnly.Checked;
                    authorizer.AuthorizerSkipEmailAlert = AuthorizerSkipEmailAlert.Checked;
                    EAuthorizer.db.insert(dbConn, authorizer);
                }

            }

        }
        WebUtils.EndFunction(dbConn);

        ArrayList list = WebUtils.SelectedRepeaterItemToBaseObjectList(EEmpPersonalInfo.db, Repeater, "ItemSelect");
        foreach (EEmpPersonalInfo o in list)
        {
            DBFilter empAuthorizerFilter = new DBFilter();
            empAuthorizerFilter.add(new Match("empid", o.EmpID));
            empAuthorizerFilter.add(new Match("AuthorizationGroupID", CurID));
            if (EAuthorizer.db.count(dbConn, empAuthorizerFilter) <= 0)
            {
                WebUtils.StartFunction(Session, FUNCTION_CODE, o.EmpID);
                EAuthorizer authorizer = new EAuthorizer();
                authorizer.EmpID = o.EmpID;
                authorizer.AuthorizationGroupID = CurID;
                EAuthorizer.db.insert(dbConn, authorizer);
                WebUtils.EndFunction(dbConn);
            }
        }
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "ESS_AuthorizationGroup_View.aspx?AuthorizationGroupID=" + CurID);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        HROne.Common.WebUtility.RedirectURLwithEncryptedQueryString(Response, Session, "ESS_AuthorizationGroup_View.aspx?AuthorizationGroupID=" + CurID);
    }
}
