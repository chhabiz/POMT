<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="CreateProgram.aspx.cs" Inherits="CurriculumMapping.Admin.CreateProgram" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Create Program - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
<div class="maincontent">
        <div id="textcontent">
            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">College Name:</asp:Label>
            <telerik:RadComboBox ID="lst_college" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
           
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">School Name:</asp:Label>
            <telerik:RadComboBox ID="lst_school" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />

            <asp:Label ID="Label7" runat="server" SkinID="SkinLabel">Program Code:</asp:Label>
            <telerik:RadTextBox ID="txt_progcode" runat="server">
            </telerik:RadTextBox>
             <asp:RequiredFieldValidator ID="val_progcode_required" runat="server" 
                ErrorMessage="Program Code is required." 
                ControlToValidate="txt_progcode" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Label ID="Label5" runat="server" SkinID="SkinLabel">Program Name:</asp:Label>
            <telerik:RadTextBox ID="txt_program" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_program_required" runat="server" 
                ErrorMessage="Program name is required." 
                ControlToValidate="txt_program" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Label ID="Label6" runat="server" SkinID="SkinLabel">Program Manager:</asp:Label>
            <telerik:RadComboBox ID="lst_pmanager" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />

             <asp:Label ID="Label2" runat="server" SkinID="SkinLabel">Description:</asp:Label>
            <telerik:RadTextBox ID="txt_description" runat="server"  TextMode="MultiLine">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_desc_required" runat="server" 
                ErrorMessage="Description is required." 
                ControlToValidate="txt_description" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" SkinID="SkinLabel">AQF Level:</asp:Label>
            <telerik:RadComboBox ID="lst_aqflevel" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label8" runat="server" SkinID="SkinLabel">PAC1:</asp:Label>
            <telerik:RadComboBox ID="lst_pac1" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" SkinID="SkinLabel">PAC2:</asp:Label>
            <telerik:RadComboBox ID="lst_pac2" runat="server" AutoPostBack="True">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label10" runat="server" SkinID="SkinLabel">PAC3:</asp:Label>
            <telerik:RadComboBox ID="lst_pac3" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Create">
            </telerik:RadButton>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server"></asp:Label>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;<div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
