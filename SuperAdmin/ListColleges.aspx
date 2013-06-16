<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true"
    CodeBehind="ListColleges.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.ListColleges" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>List Colleges - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1"
                    ApplyButtonText="Filter Search" Skin="Windows7" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="ods_GetAllColleges"
                AllowPaging="True" Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;</th>
                                    <th>
                                        Id</th>
                                    <th>
                                        Name</th>
                                    <th>
                                        Description</th>
                                    <th>
                                        Active</th>
                                    <th>
                                        Admin</th>
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
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                        <td>
                            <asp:Label ID="AdminLabel" runat="server" Text='<%# Eval("Admin.ID") %>' />
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
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                        <td>
                            <asp:Label ID="AdminLabel" runat="server" Text='<%# Eval("Admin.ID") %>' />
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
                                            NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" ReadOnly="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Eval("Name") %>' ReadOnly="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DescriptionLabel2" runat="server" AssociatedControlID="DescriptionTextBox"
                                            Text="Description"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Eval("Description") %>' ReadOnly="true"/>
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
                                    <td>
                                        <asp:Label ID="AdminLabel2" runat="server" AssociatedControlID="AdminTextBox" Text="Admin"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="AdminTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Eval("Admin.Id") %>'  ReadOnly="true"/>
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
                                    <td>
                                        <asp:Label ID="AdminLabel2" runat="server" AssociatedControlID="AdminTextBox" Text="Admin"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="AdminTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Admin") %>' />
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
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                        <td>
                            <asp:Label ID="AdminLabel" runat="server" Text='<%# Eval("Admin") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <%--<telerik:RadButton ID="btn_Update" runat="server" onclick="btn_Update_Click" 
                Text="Update" />--%>
            <br />
            <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            <asp:ObjectDataSource ID="ods_GetAllColleges" runat="server" SelectMethod="GetAllColleges"
                TypeName="College" UpdateMethod="updateCollege">
                <UpdateParameters>
                    <asp:Parameter Name="Active" Type="Boolean" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
