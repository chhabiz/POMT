<%@ Page Title="" Language="C#" MasterPageFile="~/LecturerStaff/LecturerMaster.master"
    AutoEventWireup="true" CodeBehind="MyPendingForms.aspx.cs" Inherits="CurriculumMapping.LecturerStaff.MyPendingForms" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="lecthead" runat="server">
    <title>My Forms - Staff</title>
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
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" DataSourceID="ObjectDataSource1"
                Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        CourseOffering
                                    </th>
                                    <th>
                                        Status
                                    </th>
                                    <th>
                                        ActionDate
                                    </th>
                                    <th>
                                        Comments
                                    </th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server">
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
                        <div style="display: none">
                            <telerik:RadCalendar ID="rlvSharedCalendar" runat="server" RangeMinDate="<%#new DateTime(1900, 1, 1) %>"
                                Skin="<%#Container.Skin %>" />
                        </div>
                        <div style="display: none">
                            <telerik:RadTimeView ID="rlvSharedTimeView" runat="server" Skin="<%# Container.Skin %>" />
                        </div>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:HyperLink ID="CourseOfferingLink" NavigateUrl='<%# determineURL(Eval("Status.Id"),Eval("CourseOffering.Id"), Eval("CourseOffering.Course.Title"))%>'
                                Target="_self" runat="server" Text='<%# String.Format("{0}-{1}",Eval("CourseOffering.Course.Code"), Eval("CourseOffering.Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status.StatusName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ActionDateLabel" runat="server" Text='<%# Eval("ActionDate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="rlvA">
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:HyperLink ID="CourseOfferingLink" NavigateUrl='<%# determineURL(Eval("Status.Id"),Eval("CourseOffering.Id"), Eval("CourseOffering.Course.Title"))%>'
                                Target="_self" runat="server" Text='<%# String.Format("{0}-{1}",Eval("CourseOffering.Course.Code"), Eval("CourseOffering.Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status.StatusName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ActionDateLabel" runat="server" Text='<%# Eval("ActionDate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="6">
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
                                        <asp:Label ID="CourseOfferingLabel2" runat="server" AssociatedControlID="CourseOfferingTextBox"
                                            Text="CourseOffering"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CourseOfferingTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("CourseOffering.Course.Title") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="StatusLabel2" runat="server" AssociatedControlID="StatusTextBox" Text="Status"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="StatusTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Status") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActionDateLabel2" runat="server" AssociatedControlID="ActionDateTextBox"
                                            Text="ActionDate"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadDateTimePicker ID="ActionDateTextBox" runat="server" DbSelectedDate='<%# Bind("ActionDate") %>'
                                            MinDate="<%#new DateTime(1900, 1, 1) %>" SharedCalendarID='<%# Container.OwnerListView.FindControl("rlvSharedCalendar").UniqueID %>'
                                            SharedTimeViewID='<%# Container.OwnerListView.FindControl("rlvSharedTimeView").UniqueID %>'
                                            Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CommentsLabel2" runat="server" AssociatedControlID="CommentsTextBox"
                                            Text="Comments"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CommentsTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Comments") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="rlvBUpdate"
                                            Text=" " ToolTip="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="6">
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
                                        <asp:Label ID="CourseOfferingLabel2" runat="server" AssociatedControlID="CourseOfferingTextBox"
                                            Text="CourseOffering"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CourseOfferingTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("CourseOffering") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="StatusLabel2" runat="server" AssociatedControlID="StatusTextBox" Text="Status"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="StatusTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Status") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActionDateLabel2" runat="server" AssociatedControlID="ActionDateTextBox"
                                            Text="ActionDate"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadDateTimePicker ID="ActionDateTextBox" runat="server" DbSelectedDate='<%# Bind("ActionDate") %>'
                                            MinDate="<%#new DateTime(1900, 1, 1) %>" SharedCalendarID='<%# Container.OwnerListView.FindControl("rlvSharedCalendar").UniqueID %>'
                                            SharedTimeViewID='<%# Container.OwnerListView.FindControl("rlvSharedTimeView").UniqueID %>'
                                            Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CommentsLabel2" runat="server" AssociatedControlID="CommentsTextBox"
                                            Text="Comments"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CommentsTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Comments") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="rlvBAdd"
                                            Text=" " ToolTip="Insert" />
                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EmptyDataTemplate>
                    <div class="RadListView RadListView_Default">
                        <div class="rlvEmpty">
                            There are no items to be displayed.</div>
                    </div>
                </EmptyDataTemplate>
                <SelectedItemTemplate>
                    <tr class="rlvISel">
                        <td>
                            <asp:Button ID="DeselectButton" runat="server" CausesValidation="False" CommandName="Deselect"
                                CssClass="rlvBSel" Text=" " ToolTip="Deselect" />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:HyperLink ID="CourseOfferingLink" NavigateUrl='<%# determineURL(Eval("Status.Id"),Eval("CourseOffering.Id"), Eval("CourseOffering.Course.Title"))%>'
                                Target="_self" runat="server" Text='<%# String.Format("{0}-{1}",Eval("CourseOffering.Course.Code"), Eval("CourseOffering.Course.Title")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status.StatusName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ActionDateLabel" runat="server" Text='<%# Eval("ActionDate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CommentsLabel" runat="server" Text='<%# Eval("Comments") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetLecturerFormList"
                TypeName="MyForm">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" DefaultValue="0" Name="lecturer" PropertyName="Value"
                        Type="Object" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <br />
        </div>
    </div>
</asp:Content>
