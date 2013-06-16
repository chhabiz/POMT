<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="CreateSchool.aspx.cs" Inherits="CurriculumMapping.Common.CreateSchool" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Create School - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">College Name:</asp:Label>
            <telerik:RadComboBox ID="lst_college" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">School Name:</asp:Label>
            <telerik:RadTextBox ID="txt_school" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_schoolname_required" runat="server" ErrorMessage="School name is required."
                ControlToValidate="txt_school" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" SkinID="SkinLabel">Description:</asp:Label>
            <telerik:RadTextBox ID="txt_description" runat="server" TextMode="MultiLine">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_schooldesc_required" runat="server" ErrorMessage="Description is required."
                ControlToValidate="txt_description" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
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
