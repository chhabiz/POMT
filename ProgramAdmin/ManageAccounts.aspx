<%@ Page Title="" Language="C#" MasterPageFile="~/ProgramAdmin/ProgramAdminMaster.master"
    AutoEventWireup="true" CodeBehind="ManageAccounts.aspx.cs" Inherits="CurriculumMapping.ProgramAdmin.ManageAccounts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="progadminhead" runat="server">
    <title>Manage Accounts - Program Admin</title>
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
                                        staffid
                                    </th>
                                    <th>
                                        firstname
                                    </th>
                                    <th>
                                        lastname
                                    </th>
                                    <th>
                                        emailid
                                    </th>
                                    <th>
                                        phonenumber
                                    </th>
                                    <th>
                                        designation
                                    </th>
                                    <th>
                                        active
                                    </th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="8">
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
                            <asp:Label ID="staffidLabel" runat="server" Text='<%# Eval("staffid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="firstnameLabel" runat="server" Text='<%# Eval("firstname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastnameLabel" runat="server" Text='<%# Eval("lastname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emailidLabel" runat="server" Text='<%# Eval("emailid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="phonenumberLabel" runat="server" Text='<%# Eval("phonenumber") %>' />
                        </td>
                        <td>
                            <asp:Label ID="designationLabel" runat="server" Text='<%# getDesignation(Eval("designation")) %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="activeCheckBox" runat="server" Checked='<%# Eval("active") %>'
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
                            <asp:Label ID="staffidLabel" runat="server" Text='<%# Eval("staffid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="firstnameLabel" runat="server" Text='<%# Eval("firstname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastnameLabel" runat="server" Text='<%# Eval("lastname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emailidLabel" runat="server" Text='<%# Eval("emailid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="phonenumberLabel" runat="server" Text='<%# Eval("phonenumber") %>' />
                        </td>
                        <td>
                            <asp:Label ID="designationLabel" runat="server" Text='<%# getDesignation(Eval("designation"))%>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="activeCheckBox" runat="server" Checked='<%# Eval("active") %>'
                                Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="8">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="staffidLabel2" runat="server" Text="staffid"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="staffidLabel1" runat="server" Text='<%# Eval("staffid") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="firstnameLabel2" runat="server" AssociatedControlID="firstnameTextBox"
                                            Text="firstname"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="firstnameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("firstname") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lastnameLabel2" runat="server" AssociatedControlID="lastnameTextBox"
                                            Text="lastname"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="lastnameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("lastname") %>'  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="emailidLabel2" runat="server" AssociatedControlID="emailidTextBox"
                                            Text="emailid"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emailidTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("emailid") %>'  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="phonenumberLabel2" runat="server" AssociatedControlID="phonenumberTextBox"
                                            Text="phonenumber"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="phonenumberTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("phonenumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="designationLabel2" runat="server" AssociatedControlID="designationTextBox"
                                            Text="designation"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="designationTextBox" runat="server" DataType="Int32"
                                            DbValue='<%# Bind("designation") %>' NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" Readonly="true"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="activeLabel2" runat="server" AssociatedControlID="activeCheckBox"
                                            Text="active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="activeCheckBox" runat="server" Checked='<%# Bind("active") %>' />
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
                        <td colspan="8">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="staffidLabel2" runat="server" Text="staffid"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="staffidTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("staffid") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="firstnameLabel2" runat="server" AssociatedControlID="firstnameTextBox"
                                            Text="firstname"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="firstnameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("firstname") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lastnameLabel2" runat="server" AssociatedControlID="lastnameTextBox"
                                            Text="lastname"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="lastnameTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("lastname") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="emailidLabel2" runat="server" AssociatedControlID="emailidTextBox"
                                            Text="emailid"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="emailidTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("emailid") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="phonenumberLabel2" runat="server" AssociatedControlID="phonenumberTextBox"
                                            Text="phonenumber"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="phonenumberTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("phonenumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="designationLabel2" runat="server" AssociatedControlID="designationTextBox"
                                            Text="designation"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="designationTextBox" runat="server" DataType="Int32"
                                            DbValue='<%# Bind("designation") %>' NumberFormat-DecimalDigits="0" Skin="<%#Container.OwnerListView.Skin %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="activeLabel2" runat="server" AssociatedControlID="activeCheckBox"
                                            Text="active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="activeCheckBox" runat="server" Checked='<%# Bind("active") %>' />
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
                            <asp:Label ID="staffidLabel" runat="server" Text='<%# Eval("staffid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="firstnameLabel" runat="server" Text='<%# Eval("firstname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastnameLabel" runat="server" Text='<%# Eval("lastname") %>' />
                        </td>
                        <td>
                            <asp:Label ID="emailidLabel" runat="server" Text='<%# Eval("emailid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="phonenumberLabel" runat="server" Text='<%# Eval("phonenumber") %>' />
                        </td>
                        <td>
                            <asp:Label ID="designationLabel" runat="server" Text='<%# getDesignation(Eval("designation")) %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="activeCheckBox" runat="server" Checked='<%# Eval("active") %>'
                                Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:CMT_CS %>" DeleteCommand="DELETE FROM [Staff] WHERE [StaffId] = @original_StaffId AND [FirstName] = @original_FirstName AND [LastName] = @original_LastName AND [Designation] = @original_Designation AND [Active] = @original_Active"
                InsertCommand="INSERT INTO [Staff] ([StaffId], [FirstName], [LastName], [Designation], [Active]) VALUES (@StaffId, @FirstName, @LastName, @Designation, @Active)"
                OldValuesParameterFormatString="original_{0}" SelectCommand="GetAllAccountsUnderProgramAdmin"
                SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Designation] = @Designation, [EmailId] = @EmailId, [PhoneNumber] = @PhoneNumber, [Active] = @Active WHERE [StaffId] = @original_StaffId"
                ProviderName="<%$ ConnectionStrings:CMT_CS.ProviderName %>">
                <DeleteParameters>
                    <asp:Parameter Name="original_StaffId" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                    <asp:Parameter Name="original_Designation" Type="Int32" />
                    <asp:Parameter Name="original_Active" Type="Boolean" />
                </DeleteParameters>
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
                    <asp:Parameter Name="EmailId" Type="String" />
                    <asp:Parameter Name="original_StaffId" Type="String" />
                    <asp:Parameter Name="original_EmailId" Type="String" />
                    <asp:Parameter Name="original_FirstName" Type="String" />
                    <asp:Parameter Name="original_LastName" Type="String" />
                    <asp:Parameter Name="original_Designation" Type="Int32" />
                    <asp:Parameter Name="original_Active" Type="Boolean" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenfieldprogadminid" DefaultValue="" Name="progadminId"
                        PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField runat="server" ID="hiddenfieldprogadminid" />
        </div>
    </div>
</asp:Content>
