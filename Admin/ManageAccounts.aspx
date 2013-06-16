<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="ManageAccounts.aspx.cs" Inherits="CurriculumMapping.Admin.ManageAccounts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage Accounts - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1" ApplyButtonText="Filter Search" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" DataKeyNames="staffid"
                DataSourceID="SqlDataSource1" Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;
                                    </th>
                                    <th>
                                        StaffId
                                    </th>
                                    <th>
                                        FirstName
                                    </th>
                                    <th>
                                        LastName
                                    </th>
                                    <th>
                                        Designation
                                    </th>
                                    <th>
                                        Active
                                    </th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
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
                            <asp:Label ID="StaffIdLabel" runat="server" Text='<%# Eval("StaffId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DesignationLabel" runat="server" Text='<%# getDesignation(Eval("Designation")) %>' />
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
                            <asp:Label ID="StaffIdLabel" runat="server" Text='<%# Eval("StaffId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DesignationLabel" runat="server" Text='<%# getDesignation(Eval("Designation"))  %>' />
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
                                        <asp:Label ID="StaffIdLabel2" runat="server" Text="StaffId"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="StaffIdLabel1" runat="server" Text='<%# Eval("StaffId") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FirstNameLabel2" runat="server" AssociatedControlID="FirstNameTextBox"
                                            Text="FirstName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("FirstName") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="EmailIDTextBox"
                                            Text="Email ID"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="EmailIDTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("EmailId") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneLabel" runat="server" AssociatedControlID="PhoneTextBox"
                                            Text="Phone Number"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("PhoneNumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" AssociatedControlID="LastNameTextBox"
                                            Text="LastName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("LastName") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DesignationLabel2" runat="server" AssociatedControlID="DesignationTextBox"
                                            Text="Designation"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="DesignationTextBox" runat="server" DataType="Int32"
                                            DbValue='<%# Bind("Designation") %>' NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" ReadOnly="true" />
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
                                        <asp:Label ID="StaffIdLabel2" runat="server" Text="StaffId"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="StaffIdTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("StaffId") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FirstNameLabel2" runat="server" AssociatedControlID="FirstNameTextBox"
                                            Text="FirstName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("FirstName") %>' Enabled="false" ReadOnly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LastNameLabel2" runat="server" AssociatedControlID="LastNameTextBox"
                                            Text="LastName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("LastName") %>' Enabled="false" ReadOnly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DesignationLabel2" runat="server" AssociatedControlID="DesignationTextBox"
                                            Text="Designation"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="DesignationTextBox" runat="server" DataType="Int32"
                                            DbValue='<%# Bind("Designation") %>' NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" Enabled="false" ReadOnly="true" />
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
                            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                CssClass="rlvBDel" Text=" " ToolTip="Delete" />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="StaffIdLabel" runat="server" Text='<%# Eval("StaffId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DesignationLabel" runat="server" Text='<%# getDesignation(Eval("Designation")) %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>'
                                Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:CMT_CS %>" 
                InsertCommand="INSERT INTO [Staff] ([StaffId], [FirstName], [LastName], [Designation], [Active]) VALUES (@StaffId, @FirstName, @LastName, @Designation, @Active)"
                OldValuesParameterFormatString="original_{0}" SelectCommand="GetAllAccountsUnderAdmin" SelectCommandType="StoredProcedure"
                UpdateCommand="UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Designation] = @Designation, [EmailId] = @EmailId, [PhoneNumber] = @PhoneNumber, [Active] = @Active WHERE [StaffId] = @original_StaffId"
                ProviderName="<%$ ConnectionStrings:CMT_CS.ProviderName %>">
                <InsertParameters>
                    <asp:Parameter Name="StaffId" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Designation" Type="Int32" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Designation" Type="Int32" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="original_StaffId" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                    <asp:Parameter Name="original_Designation" Type="Int32" />
                    <asp:Parameter Name="original_Active" Type="Boolean" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenfieldadminid" DefaultValue="" 
                        Name="adminId" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField runat="server" ID="hiddenfieldadminid" />
        </div>
    </div>
</asp:Content>
