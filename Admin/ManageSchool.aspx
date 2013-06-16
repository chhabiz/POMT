<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="ManageSchool.aspx.cs" Inherits="CurriculumMapping.Admin.ManageSchool" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage School - Admin</title>
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
                                        &nbsp;
                                    </th>
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        College
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Description
                                    </th>
                                    <th>
                                        Active
                                    </th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
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
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CollegeLabel" runat="server" Text='<%# Eval("College.name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
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
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CollegeLabel" runat="server" Text='<%# Eval("College.name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="6">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IdLabel2" runat="server" Text="Id"></asp:Label>
                                    </td>
                                    <td>
                                         <telerik:RadNumericTextBox ID="IdTextBox" runat="server" DataType="Int32" 
                                            DbValue='<%# Bind("Id") %>' NumberFormat-DecimalDigits="0" 
                                            Skin="<%#Container.OwnerListView.Skin %>" Width="155" ReadOnly="true"/>
                                        <%--<asp:Label ID="RadTextBox1" runat="server" Text='<%# Eval("Id") %>' Enabled="false">
                                        </asp:Label>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CollegeLabel2" runat="server" AssociatedControlID="CollegeTextBox"
                                            Text="College"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CollegeTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("College.name") %>'
                                            Width="155" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("Name") %>'
                                            Width="155" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DescriptionLabel2" runat="server" AssociatedControlID="DescriptionTextBox"
                                            Text="Description"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("Description") %>'
                                            Width="155" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActiveLabel2" runat="server" AssociatedControlID="ActiveCheckBox"
                                            Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' />
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
                                        <asp:Label ID="CollegeLabel2" runat="server" AssociatedControlID="CollegeTextBox"
                                            Text="College"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CollegeTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("College") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Name") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DescriptionLabel2" runat="server" AssociatedControlID="DescriptionTextBox"
                                            Text="Description"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Description") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActiveLabel2" runat="server" AssociatedControlID="ActiveCheckBox"
                                            Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' />
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
                    <div class="RadListView RadListView_Windows7">
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
                            <asp:Label ID="CollegeLabel" runat="server" Text='<%# Eval("College") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllSchools"
                TypeName="School" UpdateMethod="updateSchool">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" DefaultValue="0" Name="collegeId"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <p>
                <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
            </p>
        </div>
    </div>
</asp:Content>
