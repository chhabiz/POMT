<%@ Page Title="" Language="C#" MasterPageFile="~/ProgramAdmin/ProgramAdminMaster.master"
    AutoEventWireup="true" CodeBehind="ProgramAdminHome.aspx.cs" Inherits="CurriculumMapping.ProgramAdmin.ProgramAdminHome" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="progadminhead" runat="server">
    <title>Program Admin Home - Program Admin</title>
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
            <telerik:RadButton ID="butSelectLoginRole" runat="server" Text="Switch" OnClick="butSelectLoginRole_Click"></telerik:RadButton>
        </div>
        <div id="textcontent">
            <h3>
                Features</h3>
            <p class="homedesc">
                Create Accounts</p>
            <p>
                Provides an interface to create staff accounts under the same school that the program manager belongs to.</p>
            <p class="homedesc">
                Manage Accounts</p>
            <p>
                Provides an interface to view all staff accounts under the same school as the program manager, with the options
                 to search/filter. Also available is an option to activate/deactivate Staff accounts displayed.</p>
            <p class="homedesc">
                Create Course Offering</p>
            <p>
                Provides an interface to create course offerings under the program that the program manager is responsible for.</p>
            <p class="homedesc">
                Manage Course Offering</p>
            <p>
                Provides an interface to view all course offerings under the program that the program manager is responsible for, with the options
                 to search/filter. Also available is an option to activate/deactivate course offerings displayed.</p>
            <h3>
                Form Review</h3>
            <p class="homedesc">
                My Forms</p>
            <p>
                Provides an interface to view forms assigned to staff members and their statuses. The program manager search/filter for
                 forms from the list and view/edit/approve/reject the forms submitted by Staff members under his purview</p>
        </div>
    </div>
</asp:Content>
