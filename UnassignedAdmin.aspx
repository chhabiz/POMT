<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true" CodeBehind="UnassignedAdmin.aspx.cs" Inherits="CurriculumMapping.UnassignedAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Oops! Sorry - Mapping Tool</title>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article">
                        <div id="heading2">
                            Sorry your admin account needs to be assigned to a college before you can use any of the features.
                            Please contact your immediate super admin.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
