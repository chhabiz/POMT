<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ManageCourse.aspx.cs" Inherits="CurriculumMapping.Admin.ManageCourse" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage Course - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
<div class="maincontent">
        <div id="textcontent">

         <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">School Name:</asp:Label>
            <telerik:RadComboBox ID="lst_school" runat="server" AutoPostBack="True" 
                onselectedindexchanged="lst_school_SelectedIndexChanged">
            </telerik:RadComboBox>
            <br />
            <br />
            
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1" ApplyButtonText="FilterSearch" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" 
                DataSourceID="ObjectDataSource1" Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width:100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;</th>
                                    <th>
                                        Code</th>
                                    <th>
                                        Title</th>
                                    <th>
                                        CreditValue</th>
                                   
                                    <th>
                                        School</th>
                                    <th>
                                        ProgramYear</th>
                                    <th>
                                        ProgramSem</th>
                                    <th>
                                        Active</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="10">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PageSize="12">
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
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                        </table>
                    </div>
</LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CreditValueLabel" runat="server" 
                                Text='<%# Eval("CreditValue") %>' />
                        </td>
                        
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" Text='<%# Eval("School.Name") %>' />
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
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="rlvA">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CreditValueLabel" runat="server" 
                                Text='<%# Eval("CreditValue") %>' />
                        </td>
                        
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" Text='<%# Eval("School.Name") %>' />
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
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="10">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" 
                                            Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code") %>'  Enabled=false/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TitleLabel2" runat="server" AssociatedControlID="TitleTextBox" 
                                            Text="Title"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="TitleTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Eval("Title") %>'  Enabled=false/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CreditValueLabel2" runat="server" 
                                            AssociatedControlID="CreditValueTextBox" Text="CreditValue"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="CreditValueTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Eval("CreditValue") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>"  Enabled=false/>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <asp:Label ID="SchoolLabel2" runat="server" AssociatedControlID="SchoolTextBox" 
                                            Text="School"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="SchoolTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Eval("School.Name") %>' Enabled=false />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramYearLabel2" runat="server" 
                                            AssociatedControlID="ProgramYearTextBox" Text="ProgramYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramYearTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Eval("ProgramYear") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" Enabled=false />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramSemLabel2" runat="server" 
                                            AssociatedControlID="ProgramSemTextBox" Text="ProgramSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramSemTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Eval("ProgramSem") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" Enabled=false/>
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
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                            CssClass="rlvBUpdate" Text=" " ToolTip="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
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
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" 
                                            Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TitleLabel2" runat="server" AssociatedControlID="TitleTextBox" 
                                            Text="Title"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="TitleTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Title") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CreditValueLabel2" runat="server" 
                                            AssociatedControlID="CreditValueTextBox" Text="CreditValue"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="CreditValueTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("CreditValue") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td>
                                        <asp:Label ID="SchoolLabel2" runat="server" AssociatedControlID="SchoolTextBox" 
                                            Text="School"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="SchoolTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("School") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramYearLabel2" runat="server" 
                                            AssociatedControlID="ProgramYearTextBox" Text="ProgramYear"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramYearTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramYear") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramSemLabel2" runat="server" 
                                            AssociatedControlID="ProgramSemTextBox" Text="ProgramSem"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="ProgramSemTextBox" runat="server" 
                                            DataType="Int32" DbValue='<%# Bind("ProgramSem") %>' 
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
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
                                        <telerik:RadButton ID="PerformInsertButton" runat="server" CommandName="PerformInsert" 
                                            CssClass="rlvBAdd" Text=" " ToolTip="Insert" />
                                        <telerik:RadButton ID="CancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
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
                            <telerik:RadButton ID="DeselectButton" runat="server" CausesValidation="False" 
                                CommandName="Deselect" CssClass="rlvBSel" Text=" " ToolTip="Deselect" />
                            <telerik:RadButton ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CreditValueLabel" runat="server" 
                                Text='<%# Eval("CreditValue") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" Text='<%# Eval("School.Name") %>' />
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
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                SelectMethod="GetAllCourses" TypeName="Course" UpdateMethod="updateCourse">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lst_school" DefaultValue="1" Name="schoolId" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Code" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </UpdateParameters>
            </asp:ObjectDataSource>

        </div>
    </div>
</asp:Content>
