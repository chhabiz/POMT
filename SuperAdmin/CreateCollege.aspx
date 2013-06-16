<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true"
    CodeBehind="CreateCollege.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.CreateCollege" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>Create College - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label runat="server" SkinID="SkinLabel">
                    College Name (required)</asp:Label>
            <telerik:RadTextBox ID="txt_collegename" runat="server" />
            <asp:RequiredFieldValidator ID="val_collegename_required" runat="server" ErrorMessage="College name is required."
                ControlToValidate="txt_collegename" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label runat="server" SkinID="SkinLabel">
                    Description (required)</asp:Label>
            <telerik:RadTextBox runat="server" ID="txt_collegedesc" TextMode="MultiLine" />
            <asp:RequiredFieldValidator ID="val_collegedesc_required" runat="server" ErrorMessage="Description is required."
                ControlToValidate="txt_collegedesc" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Create College" />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server"></asp:Label>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;<div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
