<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="CreateCourse.aspx.cs" Inherits="CurriculumMapping.Admin.CreateCourse" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cctrl" Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Create Course - Admin</title>
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
            <telerik:RadComboBox ID="lst_school" runat="server" AutoPostBack="True">
            </telerik:RadComboBox>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" SkinID="SkinLabel">Course Code:</asp:Label>
            <telerik:RadTextBox ID="txt_coursecode" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_course_required" runat="server" ErrorMessage="Course code is required."
                ControlToValidate="txt_coursecode" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" SkinID="SkinLabel">Course Title:</asp:Label>
            <telerik:RadTextBox ID="txt_course" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="val_coursename_required" runat="server" ErrorMessage="Course name is required."
                ControlToValidate="txt_course" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
           
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllCourses"
                TypeName="Course">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lst_school" DefaultValue="0" Name="schoolId" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" SkinID="SkinLabel">Course Prerequisites:</asp:Label>
            <cctrl:DropDownCheckBoxes ID="dd_prerequisites" runat="server" DataValueField="Code" DataTextField="Title" SkinID="SkinDDCB" DataSourceID="ObjectDataSource1" ></cctrl:DropDownCheckBoxes>
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" SkinID="SkinLabel">Credit Value:</asp:Label>
            <telerik:RadTextBox ID="txt_creditval" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="txt_credit_required" runat="server" ErrorMessage="Credit value is required."
                ControlToValidate="txt_creditval" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="reg_credit_invalid" runat="server" ErrorMessage="Invalid Credit value"
                ValidationExpression="^[0-9]{2}$" ControlToValidate="txt_creditval" ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="Label10" runat="server" SkinID="SkinLabel">OUA Equivalent:</asp:Label>
            <telerik:RadTextBox ID="txt_oua_equivalent" runat="server">
            </telerik:RadTextBox>
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
            <asp:Label ID="Label8" runat="server" SkinID="SkinLabel">Program Year:</asp:Label>
            <telerik:RadComboBox ID="lst_pyear" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Year1" Value="1" />
                    <telerik:RadComboBoxItem runat="server" Text="Year2" Value="2" />
                    <telerik:RadComboBoxItem runat="server" Text="Year3" Value="3" />
                    <telerik:RadComboBoxItem runat="server" Text="Year4" Value="4" />
                    <telerik:RadComboBoxItem runat="server" Text="Year5" Value="5" />
                    <telerik:RadComboBoxItem runat="server" Text="Year6" Value="6" />
                </Items>
            </telerik:RadComboBox>
            <br />
            <br />
            <telerik:RadButton ID="btn_Submit" runat="server" Text="Create" OnClick="btn_Submit_Click">
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
