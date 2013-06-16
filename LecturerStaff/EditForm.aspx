<%@ Page Title="" Language="C#" MasterPageFile="~/LecturerStaff/LecturerMaster.master" AutoEventWireup="true" CodeBehind="EditForm.aspx.cs" Inherits="CurriculumMapping.LecturerStaff.EditForm" %>

<asp:Content ID="Content2" ContentPlaceHolderID="lecthead" runat="server">
    <title>Edit Form - Staff</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="formdata">
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
                <br />
                <asp:GridView ID="GridView2" runat="server">
                </asp:GridView>
                <br />
                <asp:GridView ID="GridView3" runat="server">
                </asp:GridView>
                <br />
                <asp:GridView ID="GridView4" runat="server">
                </asp:GridView>
                <asp:GridView ID="GridView5" runat="server">
                </asp:GridView>
                <br />
                <asp:GridView ID="GridView6" runat="server">
                </asp:GridView>
                <br />
            </div>
        </div>
        <asp:Panel ID="pnl_ProgramAdmin" runat="server">
            <asp:Button ID="btn_Approve" runat="server" Text="Approve" 
                onclick="btn_Approve_Click" />
            <asp:Button ID="btn_Reject" runat="server" Text="Reject" 
                onclick="btn_Reject_Click" />
            <asp:TextBox ID="txt_comment" runat="server"></asp:TextBox>
        </asp:Panel>
    </div>
</asp:Content>
