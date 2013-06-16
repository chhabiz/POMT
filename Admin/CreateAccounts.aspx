<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="CreateAccounts.aspx.cs" Inherits="CurriculumMapping.Admin.CreateAccounts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Create Accounts - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">USERNAME</asp:Label>
            <telerik:RadTextBox ID="txt_ID" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_id_required" runat="server" ErrorMessage="Username is required."
                ControlToValidate="txt_ID" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" SkinID="SkinLabel">PASSWORD</asp:Label>
            <telerik:RadTextBox ID="txt_password" runat="server" TextMode="Password">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_password_required" runat="server" ErrorMessage="Password is required."
                ControlToValidate="txt_password" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regex_password" runat="server" ErrorMessage="Password must be a combination of lowercase, uppercase, (number and/or a special character)"
                ControlToValidate="txt_password" ValidationExpression="((?=.*[^a-zA-Z])(?=.*[a-z])(?=.*[A-Z])(?!\s).{8,})"
                ForeColor="Red" Text="*">
            </asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="RetypeLabel" runat="server" SkinID="SkinLabel">RE-TYPE PASSWORD</asp:Label>
            <telerik:RadTextBox ID="txt_retype_password" runat="server" TextMode="Password">
            </telerik:RadTextBox>
            <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToValidate="txt_retype_password"
                ControlToCompare="txt_password" ErrorMessage="Passwords must match" Text="*">
            </asp:CompareValidator>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">FIRSTNAME</asp:Label>
            <telerik:RadTextBox ID="txt_firstname" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_firstname_required" runat="server" ErrorMessage="First name is required."
                ControlToValidate="txt_firstname" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" SkinID="SkinLabel">LASTNAME</asp:Label>
            <telerik:RadTextBox ID="txt_lastname" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_lastname_required" runat="server" ErrorMessage="Last name is required."
                ControlToValidate="txt_lastname" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" SkinID="SkinLabel">E-MAIL</asp:Label>
            <telerik:RadTextBox ID="txt_email" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_email_required" runat="server" ErrorMessage="Email is required."
                ControlToValidate="txt_email" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="reg_email_val" runat="server" ErrorMessage="Invalid Email format"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txt_email"
                ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" SkinID="SkinLabel">PHONE</asp:Label>
            <telerik:RadTextBox ID="txt_phone" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_phone_required" runat="server" ErrorMessage="Phone number is required."
                ControlToValidate="txt_phone" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="reg_phone_invalid" runat="server" ErrorMessage="Invalid Phone number"
                ValidationExpression="^[0-9]+$" ControlToValidate="txt_phone" ForeColor="Red"
                Text="*"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" SkinID="SkinLabel">DESIGNATION</asp:Label>
            <telerik:RadComboBox ID="DropDownListDesignation" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" OnClick="btn_Submit_Click" runat="server" Text="Create Account">
            </telerik:RadButton>
            <!-- This is the status message label -->
            <br />
            <br />
            <asp:Label ID="status" runat="server"></asp:Label>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
