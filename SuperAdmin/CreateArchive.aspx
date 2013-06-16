<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true" CodeBehind="CreateArchive.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.CreateArchive" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>Create Archive - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
<div class="maincontent">
        <div id="textcontent">
           <h4>Create Archive</h4>
           <p>This allows you to create an archive which reflects the current state of the system.
            The created archives list can be viewed under the "Generate Report" link/page.</p>
            <p>Once an archive is created it is denoted by a timestamp</p>
            <telerik:RadButton ID="btn_createArchive" runat="server" Text="Create Archive" 
                onclick="btn_createArchive_Click">
            </telerik:RadButton>
           <br />
            <asp:Label ID="Label1" runat="server"></asp:Label>
           
        </div>
    </div>
</asp:Content>
