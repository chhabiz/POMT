<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="CurriculumMapping.Login" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Login - Mapping Tool</title>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="activeLink" runat="server">
     <li><a href="index.aspx"><span>Home</span></a></li>
    <li><a href="about.aspx"><span>About Us</span></a></li>
    <li class="active"><a href="login.aspx"><span>Login</span></a></li>
</asp:Content>
--%>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article2">
                        <div id="heading">
                            Login</div>
                        <br />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btn_Submit">
                            <p>
                                <asp:Label runat="server" SkinID="SkinLabel">Username:</asp:Label>
                                <telerik:RadTextBox ID="txt_Staff" runat="server">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please type in your name"
                                    Text="*" ControlToValidate="txt_Staff"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label runat="server" SkinID="SkinLabel">Password:</asp:Label>
                                <telerik:RadTextBox ID="txt_Password" runat="server" TextMode="Password">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please type in your password"
                                    Text="*" ControlToValidate="txt_Password"></asp:RequiredFieldValidator>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
                                    ShowSummary="false" />
                                <telerik:RadButton ID="btn_Submit" OnClick="btn_Submit_Click" runat="server" Text="Login">
                                </telerik:RadButton>
                                <br />
                                <br />
                                <a href="ForgotPassword.aspx">Forgot Password?</a>
                            </p>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
