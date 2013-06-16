<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="UserDoc.aspx.cs" Inherits="CurriculumMapping.UserDoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>User Manual - Mapping Tool</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="activeLink" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article2">
                        <iframe src="CMT-User Document 1.0.pdf" width="890px" height="630px"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
