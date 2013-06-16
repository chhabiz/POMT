<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true" CodeBehind="ListAdmins.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.ListAdmins" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>List Admins - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="filterdiv">
                <span>
                <telerik:RadFilter ID="RadFilter1" runat="server" 
                    FilterContainerID="RadListView1" ApplyButtonText="Filter Search" 
                    CssClass="RadFilter RadFilter_Outlook RadFilter RadFilter_Default " 
                    Skin="Windows7" ExpressionPreviewPosition="Top">
                </telerik:RadFilter></span>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" 
                DataSourceID="ods_getAllAdmins" Skin="Windows7" Width="550px">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width:100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;</th>
                                    <th>
                                        ID</th>
                                    <th>
                                        FirstName</th>
                                    <th>
                                        LastName</th>
                                    <th>
                                        EMailId</th>
                                    <th>
                                        PhoneNumber</th>
                                    <th>
                                        Active</th>
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
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
                        </table>
                    </div>
</LayoutTemplate>
                <ItemTemplate>
                    <tr class="rlvI">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="EMailIdLabel" runat="server" Text='<%# Eval("EMailId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PhoneNumberLabel" runat="server" 
                                Text='<%# Eval("PhoneNumber") %>' />
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
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="EMailIdLabel" runat="server" Text='<%# Eval("EMailId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PhoneNumberLabel" runat="server" 
                                Text='<%# Eval("PhoneNumber") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="8">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IDLabel2" runat="server" AssociatedControlID="IDTextBox" 
                                            Text="ID"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="IDTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("ID") %>' Enabled="false" Width="155px"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FirstNameLabel2" runat="server" 
                                            AssociatedControlID="FirstNameTextBox" Text="FirstName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("FirstName") %>' Width="155px" Enabled="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LastNameLabel2" runat="server" 
                                            AssociatedControlID="LastNameTextBox" Text="LastName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("LastName") %>' Width="155px" Enabled="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EMailIdLabel2" runat="server" 
                                            AssociatedControlID="EMailIdTextBox" Text="EMailId"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="EMailIdTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("EMailId") %>' Width="155px" Enabled="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneNumberLabel2" runat="server" 
                                            AssociatedControlID="PhoneNumberTextBox" Text="PhoneNumber"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("PhoneNumber") %>' Width="155px" Enabled="true"/>
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
                        <td colspan="8">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IDLabel2" runat="server" AssociatedControlID="IDTextBox" 
                                            Text="ID"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="IDTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("ID") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FirstNameLabel2" runat="server" 
                                            AssociatedControlID="FirstNameTextBox" Text="FirstName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("FirstName") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LastNameLabel2" runat="server" 
                                            AssociatedControlID="LastNameTextBox" Text="LastName"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("LastName") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EMailIdLabel2" runat="server" 
                                            AssociatedControlID="EMailIdTextBox" Text="EMailId"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="EMailIdTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("EMailId") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneNumberLabel2" runat="server" 
                                            AssociatedControlID="PhoneNumberTextBox" Text="PhoneNumber"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("PhoneNumber") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DesignationLabel2" runat="server" 
                                            AssociatedControlID="DesignationTextBox" Text="Designation"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DesignationTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Designation") %>' />
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
                    <div class="RadListView RadListView_Vista">
                        <div class="rlvEmpty">
                            There are no items to be displayed.</div>
                    </div>
                </EmptyDataTemplate>
                <SelectedItemTemplate>
                    <tr class="rlvISel">
                        <td>
                            <asp:Button ID="DeselectButton" runat="server" CausesValidation="False" 
                                CommandName="Deselect" CssClass="rlvBSel" Text=" " ToolTip="Deselect" />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="EMailIdLabel" runat="server" Text='<%# Eval("EMailId") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PhoneNumberLabel" runat="server" 
                                Text='<%# Eval("PhoneNumber") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ods_getAllAdmins" runat="server" 
                SelectMethod="getAllAdministrators" TypeName="Administrator" UpdateMethod="updateAdmin">
                <UpdateParameters>
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="EmailId" Type="String" />
                    <asp:Parameter Name="PhoneNumber" Type="String" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
