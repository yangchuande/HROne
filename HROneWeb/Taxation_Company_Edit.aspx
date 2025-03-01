<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Taxation_Company_Edit.aspx.cs"    Inherits="Taxation_Company_Edit" MasterPageFile="~/MainMasterPage.master" %>

<%@ Register Src="~/controls/DetailToolBar.ascx" TagName="DetailToolBar" TagPrefix="tb" %>
<%@ Register Src="~/controls/RecordListFooter.ascx" TagName="RecordListFooter" TagPrefix="tb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainContentPlaceHolder" runat="server">

        <input type="hidden" id="TaxCompID" runat="server" name="ID" />
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_page_title">
            <tr>
                <td>
                    <asp:Label runat="server" Text="Taxation Company Details" />
                </td>
            </tr>
        </table>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_section_title">
            <tr>
                <td>
                    <%=CurID<=0?HROne.Common.WebUtility.GetLocalizedString("Add"):HROne.Common.WebUtility.GetLocalizedString("Edit") %>
                    <asp:Label runat="server" Text="Taxation Company" />
                </td>
            </tr>
        </table>
        
            
                
        
        <table width="100%" cellpadding="0" cellspacing="0" class="pm_button_section">
            <tr>
                <td>
                    <tb:DetailToolBar id="toolBar" runat="server"
                     NewButton_Visible="false" 
                     EditButton_Visible="false" 
                     OnBackButton_Click="Back_Click"
                     OnSaveButton_Click ="Save_Click"
                     OnDeleteButton_Click="Delete_Click"
                      />
                </td>
                <td align="right">
                    <asp:Button ID="btnHelp" runat="server" CSSClass="button" Text=" Help" Visible="false" UseSubmitBehavior="false" OnClientClick="openHelp(); return false;"/>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="toolbar"/>
        </Triggers>
        <ContentTemplate>
                    <table border="0" width="100%" cellspacing="0" cellpadding="0" class="pm_field_section">
                        <col width="30%" />
                        <col width="70%" />
                        <tr>
                            <td class="pm_field_title" colspan="4">
                                <asp:Label runat="server" Text="Detail" />
                            </td>
                        </tr>
                        <tr>
                            <td class="pm_field_header">
                                <asp:Label runat="server" Text="Name of Employer" />:
                            </td>
                            <td class="pm_field">
                                <asp:TextBox ID="TaxCompEmployerName" runat="Server"  />
                            </td>
                        </tr>
                        <tr>
                            <td class="pm_field_header">
                                <asp:Label runat="server" Text="Address of Employer" />:
                            </td>
                            <td class="pm_field">
                                <asp:TextBox ID="TaxCompEmployerAddress" runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="pm_field_header">
                                <asp:Label runat="server" Text="Tax File No." />:
                            </td>
                            <td class="pm_field">
                                <asp:TextBox ID="TaxCompSection" runat="Server" /> - <asp:TextBox ID="TaxCompERN" runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="pm_field_header">
                                <asp:Label runat="server" Text="Designation" />:
                            </td>
                            <td class="pm_field">
                                <asp:TextBox ID="TaxCompDesignation" runat="Server" />
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="pm_section_title">
                        <tr>
                            <td>
                                <asp:Label runat="server" Text="Company List" />
                            </td>
                        </tr>
                    </table>
                    <table border="0" width="100%" class="pm_list_section" cellspacing="0" cellpadding="1">
                        <col width="26px" />
                        <col width="200px" />
                        <tr>
                            <td class="pm_list_header">
                            </td>
                            <td align="left" class="pm_list_header">
                                <asp:LinkButton runat="server" ID="_CompanyCode" OnClick="ChangeOrder_Click" Text="Code"/>
                            </td>
                            <td align="left" class="pm_list_header">
                                <asp:LinkButton runat="server" ID="_CompanyName" OnClick="ChangeOrder_Click" Text="Name"/>
                            </td>
                        </tr>
                        <asp:Repeater ID="Repeater" runat="server" OnItemDataBound="Repeater_ItemDataBound">
                            <ItemTemplate>
                                <tr>
                                    <td class="pm_list" align="center">
                                        <asp:CheckBox ID="ItemSelect" runat="server" />
                                    </td>
                                    <td class="pm_list">
                                        <%#sbinding.getValue(Container.DataItem, "CompanyCode")%>
                                    </td>
                                    <td class="pm_list">
                                        <%#sbinding.getValue(Container.DataItem, "CompanyName")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                    <tb:RecordListFooter id="ListFooter" runat="server"
                        ShowAllRecords="true" visible="true" 
                      />

        </ContentTemplate> 
        </asp:UpdatePanel> 
</asp:Content> 