<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="UnauthorizedPage.aspx.cs" Inherits="CurriculumMapping.UnauthorizedPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article">
                        <div id="heading">
                            You do not have sufficient privileges to access this area.
                            Back to <a id="anchorHome" runat="server">Home</a> page.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
