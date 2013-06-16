<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true"
    CodeBehind="CreateAdmin.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.CreateAdmin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>Create Admin - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <telerik:RadFormDecorator ID="FormDecorator1" runat="server" DecoratedControls="All" />
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label runat="server" SkinID="SkinLabel">
                    STAFF ID</asp:Label>
            <telerik:RadTextBox ID="txt_staffId" name="username" runat="server" class="text"
                SkinID="SkinTextBox" />
            <asp:RequiredFieldValidator ID="val_staffid_required" runat="server" ErrorMessage="Staff ID is required."
                ControlToValidate="txt_staffId" ForeColor="Red"></asp:RequiredFieldValidator>
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
            <telerik:RadTextBox ID="txt_retype_password" runat="server" TextMode="Password"></telerik:RadTextBox>
            <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToValidate="txt_retype_password" 
            ControlToCompare="txt_password" ErrorMessage="Passwords must match" Text="*">
            </asp:CompareValidator>
            <br />
            <br />
            <asp:Label runat="server" SkinID="SkinLabel">
                    FIRSTNAME</asp:Label>
            <asp:TextBox runat="server" ID="txt_firstname" name="firstname" class="text" />
            <asp:RequiredFieldValidator ID="val_firstname_required" runat="server" ErrorMessage="First name is required."
                ControlToValidate="txt_firstname" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label runat="server" SkinID="SkinLabel">
                    LASTNAME</asp:Label>
            <telerik:RadTextBox runat="server" ID="txt_lastname" />
            <asp:RequiredFieldValidator ID="val_lastname_required" runat="server" ErrorMessage="Last name is required."
                ControlToValidate="txt_lastname" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label runat="server" SkinID="SkinLabel"> EMAIL </asp:Label>
            <telerik:RadTextBox runat="server" ID="txt_email" name="email" class="text" SkinID="SkinTextBox" />
            <asp:RequiredFieldValidator ID="val_email_required" runat="server" ErrorMessage="Email is required."
                ControlToValidate="txt_email" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="reg_email_val" runat="server" ErrorMessage="Invalid Email format"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txt_email"
                ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label runat="server" SkinID="SkinLabel">
                    PHONE</asp:Label>
            <telerik:RadTextBox runat="server" ID="txt_phone" name="phone" class="text" SkinID="SkinTextBox" />
            <asp:RequiredFieldValidator ID="val_phone_required" runat="server" ErrorMessage="Phone number is required."
                ControlToValidate="txt_phone" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="reg_phone_invalid" runat="server" ErrorMessage="Invalid Phone number"
                ValidationExpression="^[0-9]+$" ControlToValidate="txt_phone" ForeColor="Red"
                Text="*"></asp:RegularExpressionValidator>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Create Admin" />
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
