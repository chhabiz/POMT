<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="logout.aspx.cs" Inherits="CurriculumMapping.logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>You have been signed out! - Mapping Tool</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div id="logout">
                        You have been successfully logged out. Click here to <a href="Login.aspx">LOGIN</a> again
                    </div>
                </div>
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
