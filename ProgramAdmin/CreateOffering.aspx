<%@ Page Title="" Language="C#" MasterPageFile="~/ProgramAdmin/ProgramAdminMaster.master"
    AutoEventWireup="true" CodeBehind="CreateOffering.aspx.cs" Inherits="CurriculumMapping.ProgramAdmin.CreateOffering" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="progadminhead" runat="server">
    <title>Create Offering - Program Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <telerik:RadFormDecorator ID="RadDecorator2" runat="server" DecoratedControls="All" />
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label ID="Label10" runat="server" SkinID="SkinLabel">Program:</asp:Label>
            <asp:DropDownList ID="lst_program" runat="server" OnSelectedIndexChanged="lst_prog_SelectedIndexChanged" AutoPostBack="true" Width="250px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">Course:</asp:Label>
            <asp:DropDownList ID="lst_course" runat="server" Width="250px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">Calendar Year:</asp:Label>
            <telerik:RadDatePicker ID="lst_calendaryear" runat="server">
            <%--<telerik:RadCalendar ID="lst_calendaryear" runat="server" CultureInfo="en-IN" EnableMultiSelect="False"
                SelectedDate="" ViewSelectorText="x">--%>
                
                </telerik:RadDatePicker>
            <%--</telerik:RadCalendar>--%>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" SkinID="SkinLabel">Calendar Semester:</asp:Label>
            <telerik:RadComboBox ID="lst_calsem" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Semester 1" Value="1" />
                    <telerik:RadComboBoxItem runat="server" Text="Semester 2" Value="2" />
                </Items>
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label8" runat="server" SkinID="SkinLabel">Program Year:</asp:Label>
            <telerik:RadComboBox ID="lst_pyear" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Year1" Value="1" />
                    <telerik:RadComboBoxItem runat="server" Text="Year2" Value="2" />
                    <telerik:RadComboBoxItem runat="server" Text="Year3" Value="3" />
                    <telerik:RadComboBoxItem runat="server" Text="Year4" Value="4" />
                    <telerik:RadComboBoxItem runat="server" Text="Year5" Value="5" />
                    <telerik:RadComboBoxItem runat="server" Text="Year6" Value="5" />
                </Items>
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" SkinID="SkinLabel">Program Semester:</asp:Label>
            <telerik:RadComboBox ID="lst_psem" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Semester1" Value="1" />
                    <telerik:RadComboBoxItem runat="server" Text="Semester2" Value="2" />
                </Items>
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" SkinID="SkinLabel">Coordinator:</asp:Label>
            <telerik:RadComboBox ID="lst_coordinator" runat="server">
            </telerik:RadComboBox>
            <asp:RequiredFieldValidator ID="requiredFieldCoordinator" runat="server" ControlToValidate="lst_coordinator"
             ErrorMessage="Please choose a coordinator(required)" Text="*">
            </asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" SkinID="SkinLabel">Co Taught:</asp:Label>
            <telerik:RadComboBox ID="lst_cotaught" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="No" Value="false" />
                    <telerik:RadComboBoxItem runat="server" Text="Yes" Value="true" />
                </Items>
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" SkinID="SkinLabel">Syllabus:</asp:Label>
            <telerik:RadTextBox ID="txt_syllabus" runat="server" TextMode="MultiLine">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="txt_syllabus_required" runat="server" ErrorMessage="Syllabus is required."
                ControlToValidate="txt_syllabus" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" SkinID="SkinLabel">Comments to Lecturer:</asp:Label>
            <telerik:RadTextBox ID="txt_comments" runat="server" TextMode="MultiLine">
            </telerik:RadTextBox>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" Text="Create" OnClick="btn_Submit_Click">
            </telerik:RadButton>
            <br /><br />
            <asp:Label ID="Label4" runat="server"></asp:Label>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;<div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
