<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true"
    CodeBehind="SuperAdminHome.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.SuperAdminHome" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>Super Admin Home - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="login">
            <asp:Label ID="lblSwitchMessage" runat="server"></asp:Label>
            <asp:Label ID="lblLog" runat="server">Logged in as: </asp:Label>
            <asp:Label ID="lblLoggedInUser" runat="server"></asp:Label><br />
        </div>
        <div id="textcontent">
            <h3>
                Features</h3>
            <p class="homedesc">
                Create Admin</p>
            <p>
                Provides and interface for the Super Admin to add an Admin account.</p>
            <p class="homedesc">
                Create College</p>
            <p>
                Provides an interface for the Super Admin to add a College.</p>
            <p class="homedesc">
                Manage Admins</p>
            <p>
                Provides an interface for the Super Admin to view/activate/deactivate admin account(s).</p>
            <p class="homedesc">
                Manage Colleges</p>
            <p>
                Provides an interface for the Super Admin to view/activate/deactivate college(s).</p>
            <p class="homedesc">
                Assign Admin</p>
            <p>
                Provides an interface for the Super Admin to assign admin to college(s)</p>
            <h3>
                Reporting</h3>
            <p class="homedesc">
                Generate Report</p>
            <p>
                Allows a super admin to generate reports, view and print them by selecting different
                programs offered</p>
            <p class="homedesc">
                Create Archive</p>
            <p>
                Provides an interface to create a snapshot of the system in the current state. This
                is then available under the Generate Report option under archives</p>
        </div>
    </div>
</asp:Content>
