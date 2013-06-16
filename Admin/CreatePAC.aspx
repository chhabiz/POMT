<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="CreatePAC.aspx.cs" Inherits="CurriculumMapping.Common.CreatePAC" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Create PAC Group - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">Category:</asp:Label>
            <telerik:RadComboBox ID="lst_category" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">PAC Group Name:</asp:Label>
            <telerik:RadTextBox ID="txt_pacgroup" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_pacgroup_required" runat="server" ErrorMessage="Group name is required."
                ControlToValidate="txt_pacgroup" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Create">
            </telerik:RadButton>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server"></asp:Label>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;<div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
