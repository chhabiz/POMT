<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="InactiveUser.aspx.cs" Inherits="CurriculumMapping.InactiveUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Oops! Inactive Account - Mapping Tool</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article">
                        <div id="heading2">
                            Sorry your account is inactive. You do not have access to the features, please contact
                            your immediate supervisor (Super Admin / Admin / Program Manager).
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
