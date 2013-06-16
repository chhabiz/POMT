<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="ForgotPassword.aspx.cs" Inherits="CurriculumMapping.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Password Recovery - Mapping Tool</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article2">
                        <div id="heading">
                            Retrieve Password</div>
                        <br />
                        <p>
                            Please enter your registered User ID and Email address to retrieve your password</p>
                        <p>
                            <asp:Label ID="lblUsername" runat="server" Text="Username: " SkinID="SkinLabel" />
                            <asp:TextBox ID="txtUsername" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername"
                                ErrorMessage="Please Enter Username" SetFocusOnError="True" Text="*" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:Label ID="lblEmail" runat="server" Text="Email Address: " SkinID="SkinLabel" />
                            <asp:TextBox ID="txtEmail" runat="server" />
                            <asp:RequiredFieldValidator ID="RV1" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Please Enter EmailID" SetFocusOnError="True" Text="*" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="reg_email_val" runat="server" ErrorMessage="Invalid Email format"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail"
                                ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
                            <br />
                            <br />
                            <asp:Button ID="btnPass" runat="server" Text="Submit" OnClick="btnPass_Click" />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                            <asp:Label ID="lblMessage" runat="server" Text="" />
                            <asp:Label ID="Label1" runat="server" Text="" />
                            <asp:Label ID="Label2" runat="server" Text="" />
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
