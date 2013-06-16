<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="AdminHome.aspx.cs" Inherits="CurriculumMapping.Admin.AdminHome" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Admin Home - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="login">
            <asp:Label ID="lblSwitchMessage" runat="server"></asp:Label>
            <asp:Label ID="lblLog" runat="server">Logged in as: </asp:Label>
            <asp:Label ID="lblLoggedInUser" runat="server"></asp:Label><br />
            <telerik:RadComboBox ID="comboLoginRoles" runat="server" Width="144px">
                <Items>
                    <telerik:RadComboBoxItem Text="Administrator" runat="server" />
                    <telerik:RadComboBoxItem Text="Program Manager" runat="server" />
                    <telerik:RadComboBoxItem Text="Staff" runat="server" />
                </Items>
            </telerik:RadComboBox>
            <telerik:RadButton ID="butSelectLoginRole" runat="server" Text="Switch" OnClick="butSelectLoginRole_Click">
            </telerik:RadButton>
        </div>
        <div id="textcontent">
            <h3>
                Features</h3>
            <p class="homedesc">
                Create Accounts</p>
            <p>
                Provides an interface for the Admin to create a program manager or a staff account</p>
            <p class="homedesc">
                Manage Accounts</p>
            <p>
                Provides an interface to view program manager and staff accounts and also activate/deactive
                them</p>
            <p class="homedesc">
                Create School</p>
            <p>
                Provides an interface to create a School. ex: School of Computer Science</p>
            <p class="homedesc">
                Manage School</p>
            <p>
                Provides an interface to view the list of schools and also activate/deactivate them</p>
            <p class="homedesc">
                Create Program</p>
            <p>
                Provides an interface to add a new Program. ex: MC060 (Master of Computer Science)</p>
            <p class="homedesc">
                Manage Program</p>
            <p>
                Provides an interface to view list of available programs and also to activate/deactive
                them</p>
            <p class="homedesc">
                Create Course</p>
            <p>
                Provides an interface to create a course</p>
            <p class="homedesc">
                Manage Course</p>
            <p>
                Provides an interface to view list of available courses and also to activate/deactive
                them</p>
            <p class="homedesc">
                Assign Course to Program</p>
            <p>
                Provides an interface to assign courses to programs</p>
            <h3>
                Register Attributes</h3>
            <p>
                Attributes are categorized under six criteria. Each of the links:<br />
                Unit Learning Outcomes, Assessment Task, Learning Experience, Triple-I Curriculum
                Themes, Learning Resource, ABCD, provide an interface for adding attributes under
                their criterion.</p>
            <p>
                The respective interfaces also provide options to view, search/filter and activate
                and deactivate attributes.</p>
        </div>
    </div>
</asp:Content>
