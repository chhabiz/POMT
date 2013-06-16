<%@ Page Title="" Language="C#" MasterPageFile="~/LecturerStaff/LecturerMaster.master"
    AutoEventWireup="true" CodeBehind="LecturerStaffHome.aspx.cs" Inherits="CurriculumMapping.LecturerStaff.LecturerStaffHome" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="lecthead" runat="server">
    <title>Staff Home - Staff</title>
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
                My Forms</p>
            <p>
                Provides an interface which displays the Courses assigned to the current Lectuer/Staff.
                Clicking on the forms allow a Lecturer/Staff member to view the course details or
                edit and submit them to the relevant program manager for approval.</p>
        </div>
    </div>
</asp:Content>
