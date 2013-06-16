<%@ Page Title="" Language="C#" MasterPageFile="~/ProgramAdmin/ProgramAdminMaster.master"
    AutoEventWireup="true" CodeBehind="ManageOffering.aspx.cs" Inherits="CurriculumMapping.ProgramAdmin.ManageOffering" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="progadminhead" runat="server">
    <title>Manage Offering - Program Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1"
                    ApplyButtonText="Filter Search" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:radcombobox runat="server" ID="lst_program" AutoPostBack="true" OnSelectedIndexChanged="lst_prog_SelectedIndexChanged"></telerik:radcombobox>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <br />
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" DataSourceID="ObjectDataSource1"
                Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        Id</th>
                                    <th>
                                        Course</th>
                                    <th>
                                        CalendarYear</th>
                                    <th>
                                        ProgramYear</th>
                                    <th>
                                        ProgramSem</th>
                                    <th>
                                        Coordinator</th>
                                    <th>
                                        Cotaught</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="10">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server" Skin="Windows7">
                                            <Fields>
                                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
                                                <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                                <telerik:RadDataPagerButtonField FieldType="NextLast" />
                                            </Fields>
                                        </telerik:RadDataPager>
                                    </td>
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                        </table>
                        <div style="display:none">
                            <telerik:RadCalendar ID="rlvSharedCalendar" runat="server" 
                                RangeMinDate="<%#new DateTime(1900, 1, 1) %>" Skin="<%#Container.Skin %>" />
                        </div>
                        <div style="display:none">
                            <telerik:RadTimeView ID="rlvSharedTimeView" runat="server" 
                                Skin="<%# Container.Skin %>" />
                        </div>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CourseLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Course.Code"), Eval("Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="CalendarYearLabel" runat="server" 
                                Text='<%# Eval("CalendarYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramYearLabel" runat="server" 
                                Text='<%# Eval("ProgramYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramSemLabel" runat="server" 
                                Text='<%# Eval("ProgramSem") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CoordinatorLabel" runat="server" 
                                Text='<%# Eval("Coordinator.Id") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="CotaughtCheckBox" runat="server" 
                                Checked='<%# Eval("Cotaught") %>' Enabled="false" />
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="rlvA">
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CourseLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Course.Code"), Eval("Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="CalendarYearLabel" runat="server" 
                                Text='<%# Eval("CalendarYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramYearLabel" runat="server" 
                                Text='<%# Eval("ProgramYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramSemLabel" runat="server" 
                                Text='<%# Eval("ProgramSem") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CoordinatorLabel" runat="server" 
                                Text='<%# Eval("Coordinator.Id") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="CotaughtCheckBox" runat="server" 
                                Checked='<%# Eval("Cotaught") %>' Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="10">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IdLabel2" runat="server" AssociatedControlID="IdTextBox" Text="Id"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="IdTextBox" runat="server" DataType="Int32" DbValue='<%# Bind("Id") %>'
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CourseLabel2" runat="server" AssociatedControlID="CourseTextBox" Text="Course"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CourseTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Course") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CalendarYearLabel2" runat="server" AssociatedControlID="CalendarYearTextBox"
                                            Text="CalendarYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadDateTimePicker ID="CalendarYearTextBox" runat="server" 
                                            DbSelectedDate='<%# Bind("CalendarYear") %>' 
                                            MinDate="<%#new DateTime(1900, 1, 1) %>" 
                                            SharedCalendarID='<%# Container.OwnerListView.FindControl("rlvSharedCalendar").UniqueID %>' 
                                            SharedTimeViewID='<%# Container.OwnerListView.FindControl("rlvSharedTimeView").UniqueID %>' 
                                            Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CalendarSemLabel2" runat="server" AssociatedControlID="CalendarSemTextBox"
                                            Text="CalendarSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="CalendarSemTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("CalendarSem") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramYearLabel2" runat="server" AssociatedControlID="ProgramYearTextBox"
                                            Text="ProgramYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramYearTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramYear") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramSemLabel2" runat="server" AssociatedControlID="ProgramSemTextBox"
                                            Text="ProgramSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramSemTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramSem") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CoordinatorLabel2" runat="server" 
                                            AssociatedControlID="CoordinatorTextBox" Text="Coordinator"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CoordinatorTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Coordinator.Id") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CotaughtLabel2" runat="server" 
                                            AssociatedControlID="CotaughtCheckBox" Text="Cotaught"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="CotaughtCheckBox" runat="server" 
                                            Checked='<%# Bind("Cotaught") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SyllabusLabel2" runat="server" 
                                            AssociatedControlID="SyllabusTextBox" Text="Syllabus"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SyllabusTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Syllabus") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActiveLabel2" runat="server" 
                                            AssociatedControlID="ActiveCheckBox" Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                            Checked='<%# Bind("Active") %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="10">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IdLabel2" runat="server" AssociatedControlID="IdTextBox" Text="Id"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="IdTextBox" runat="server" DataType="Int32" DbValue='<%# Bind("Id") %>'
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CourseLabel2" runat="server" AssociatedControlID="CourseTextBox" Text="Course"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CourseTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Course") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CalendarYearLabel2" runat="server" AssociatedControlID="CalendarYearTextBox"
                                            Text="CalendarYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadDateTimePicker ID="CalendarYearTextBox" runat="server" 
                                            DbSelectedDate='<%# Bind("CalendarYear") %>' 
                                            MinDate="<%#new DateTime(1900, 1, 1) %>" 
                                            SharedCalendarID='<%# Container.OwnerListView.FindControl("rlvSharedCalendar").UniqueID %>' 
                                            SharedTimeViewID='<%# Container.OwnerListView.FindControl("rlvSharedTimeView").UniqueID %>' 
                                            Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CalendarSemLabel2" runat="server" AssociatedControlID="CalendarSemTextBox"
                                            Text="CalendarSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="CalendarSemTextBox" runat="server" DataType="Int32"
                                            DbValue='<%# Bind("CalendarSem") %>' NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramYearLabel2" runat="server" AssociatedControlID="ProgramYearTextBox"
                                            Text="ProgramYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramYearTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramYear") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramSemLabel2" runat="server" AssociatedControlID="ProgramSemTextBox"
                                            Text="ProgramSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramSemTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramSem") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CoordinatorLabel2" runat="server" AssociatedControlID="CoordinatorTextBox"
                                            Text="Coordinator"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CoordinatorTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Coordinator") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CotaughtLabel2" runat="server" 
                                            AssociatedControlID="CotaughtCheckBox" Text="Cotaught"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="CotaughtCheckBox" runat="server" 
                                            Checked='<%# Bind("Cotaught") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SyllabusLabel2" runat="server" 
                                            AssociatedControlID="SyllabusTextBox" Text="Syllabus"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SyllabusTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Syllabus") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActiveLabel2" runat="server" 
                                            AssociatedControlID="ActiveCheckBox" Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                            Checked='<%# Bind("Active") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" 
                                            CssClass="rlvBAdd" Text=" " ToolTip="Insert" />
                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EmptyDataTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <div class="rlvEmpty">
                            There are no items to be displayed.</div>
                    </div>
                </EmptyDataTemplate>
                <SelectedItemTemplate>
                    <tr class="rlvISel">
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CourseLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Course.Code"), Eval("Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="CalendarYearLabel" runat="server" 
                                Text='<%# Eval("CalendarYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CalendarSemLabel" runat="server" 
                                Text='<%# Eval("CalendarSem") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramYearLabel" runat="server" 
                                Text='<%# Eval("ProgramYear") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramSemLabel" runat="server" 
                                Text='<%# Eval("ProgramSem") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CoordinatorLabel" runat="server" 
                                Text='<%# Eval("Coordinator") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="CotaughtCheckBox" runat="server" 
                                Checked='<%# Eval("Cotaught") %>' Enabled="false" />
                        </td>
                        <td>
                            <asp:Label ID="SyllabusLabel" runat="server" Text='<%# Eval("Syllabus") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllOfferings"
                TypeName="CourseOffering">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" DefaultValue="0" Name="programCode"
                        PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
