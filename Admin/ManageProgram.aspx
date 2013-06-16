<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="ManageProgram.aspx.cs" Inherits="CurriculumMapping.Admin.ManageProgram" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage Program - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1" ApplyButtonText="Filter Search" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" AllowPaging="True" 
                DataSourceID="ObjectDataSource1" Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width: 100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;</th>
                                    <th>
                                        Code</th>
                                    <th>
                                        School</th>
                                    <th>
                                        ProgramManager</th>
                                    <th>
                                        Name</th>
                                    <th>
                                        Description</th>
                                    <th>
                                        Active</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="7">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server" Skin="Windows7">
                                            <Fields>
                                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
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
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" 
                                Text='<%# Eval("School.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramManagerLabel" runat="server" 
                                Text='<%# String.Format("{0} {1}",Eval("ProgramManager.FirstName"), Eval("ProgramManager.LastName")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" 
                                Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" 
                                Text='<%# Eval("Description") %>' />
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
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" 
                                Text='<%# Eval("School.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramManagerLabel" runat="server" 
                                Text='<%# String.Format("{0} {1}",Eval("ProgramManager.FirstName"), Eval("ProgramManager.LastName")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" 
                                Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" 
                                Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="7">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Code") %>' Width="155" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SchoolLabel2" runat="server" AssociatedControlID="SchoolTextBox" Text="School"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SchoolTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("School.Name") %>' Width="155" Enabled="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramManagerLabel2" runat="server" AssociatedControlID="ProgramManagerTextBox"
                                            Text="ProgramManager"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ProgramManagerTextBox" runat="server" CssClass="rlvInput" Text='<%# String.Format("{0} {1}",Eval("ProgramManager.FirstName"), Eval("ProgramManager.LastName")) %>' Width="155" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("Name") %>' Width="155" Enabled="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DescriptionLabel2" runat="server" AssociatedControlID="DescriptionTextBox"
                                            Text="Description"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="rlvInput" Text='<%# Eval("Description") %>' Width="200" ReadOnly="true"/>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DescriptionTextBox" Text="*" ErrorMessage="Description can not be null"></asp:RequiredFieldValidator>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false"/>
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
                        <td colspan="7">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("Code") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SchoolLabel2" runat="server" AssociatedControlID="SchoolTextBox" Text="School"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SchoolTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("School") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProgramManagerLabel2" runat="server" AssociatedControlID="ProgramManagerTextBox"
                                            Text="ProgramManager"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ProgramManagerTextBox" runat="server" CssClass="rlvInput" Text='<%# Bind("ProgramManager") %>' />
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
                            <asp:Button ID="DeselectButton" runat="server" CausesValidation="False" 
                                CommandName="Deselect" CssClass="rlvBSel" Text=" " ToolTip="Deselect" />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SchoolLabel" runat="server" 
                                Text='<%# Eval("School") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ProgramManagerLabel" runat="server" 
                                Text='<%# String.Format("{0} {1}",Eval("ProgramManager.FirstName"), Eval("ProgramManager.LastName")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" 
                                Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DescriptionLabel" runat="server" 
                                Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <p/>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllPrograms"
                    TypeName="Program" UpdateMethod="updateProgram">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField2" DefaultValue="1" Name="collegeId"
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Code" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:HiddenField ID="HiddenField2" runat="server" Value="" />
        </div>
    </div>
</asp:Content>
