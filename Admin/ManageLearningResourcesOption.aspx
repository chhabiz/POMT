<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ManageLearningResourcesOption.aspx.cs" Inherits="CurriculumMapping.Admin.ManageLearningResourcesOption" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage Learning Resources - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label runat="server" ID="label1"></asp:Label>
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" FilterContainerID="RadListView1" ApplyButtonText="Filter Search" ExpressionPreviewPosition="Top">
                </telerik:RadFilter>
            </div>
            <br />
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="ObjectDataSource2"
                ItemPlaceholderID="test1" DataKeyNames="Id" AllowPaging="True" 
                Skin="Windows7">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Windows7">
                        <table cellspacing="0" style="width:100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        &nbsp;</th>
                                    <th>
                                        Id</th>
                                    <th>
                                        SpecificationAttributeOption</th>
                                    <th>
                                        Value</th>
                                    <th>
                                        Active</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="6">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server" Skin="Windows7" PageSize="12">
                                            <Fields>
                                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
                                                <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                                <telerik:RadDataPagerButtonField FieldType="NextLast" />
                                            </Fields>
                                        </telerik:RadDataPager>
                                    </td>
                                    <telerik:RadButton ID="AddButton1" runat="server" Visible="True" CommandName="InitInsert"
                                        Text="Add Learning Resource" />
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr ID="test1" runat="server">
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
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SpecificationAttributeOptionLabel" runat="server" 
                                Text='<%# Eval("SpecificationAttributeOption.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("Value") %>' />
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
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SpecificationAttributeOptionLabel" runat="server" 
                                Text='<%# Eval("SpecificationAttributeOption.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("Value") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="6">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="IdLabel2" runat="server" AssociatedControlID="IdTextBox" 
                                            Text="Id"></asp:Label>
                                    </td>
                                    <td>
                                        <%--<telerik:RadNumericTextBox ID="IdTextBox" runat="server" DataType="Int32" 
                                            DbValue='<%# Bind("Id") %>' NumberFormat-DecimalDigits="0" 
                                            Skin="<%#Container.OwnerListView.Skin %>" />--%>
                                        <asp:Label ID="IdTextBox" runat="server" width="155px" Text='<%#Eval("Id") %>'>
                                         </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SpecificationAttributeOptionLabel2" runat="server" 
                                            AssociatedControlID="SpecificationAttributeOptionTextBox" 
                                            Text="SpecificationAttributeOption"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SpecificationAttributeOptionTextBox" runat="server" 
                                            CssClass="rlvInput" Text='<%# Eval("SpecificationAttributeOption.Name") %>' Width="155px" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ValueLabel2" runat="server" AssociatedControlID="ValueTextBox" 
                                            Text="Value"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ValueTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Value") %>' Width="155px" Enabled="false" />
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
                        <td colspan="6">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="SpecificationAttributeOptionLabel2" runat="server" 
                                            AssociatedControlID="SpecificationAttributeOptionTextBox" 
                                            Text="Attribute Value"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="SpecificationAttributeOptionTextBox" runat="server" DataSourceID="ObjectDataSource1"
                                            DataTextField="Name" DataValueField="Id" Text='<%# Bind("name") %>' AutoPostBack="false"
                                            Width="155px">
                                        </telerik:RadComboBox>
                                        <%--<asp:TextBox ID="SpecificationAttributeOptionTextBox" runat="server" 
                                            CssClass="rlvInput" Text='<%# Bind("SpecificationAttributeOption") %>' />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ValueLabel2" runat="server" AssociatedControlID="ValueTextBox" 
                                            Text="Value"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ValueTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Value") %>' Width="155px" />
                                        <asp:RequiredFieldValidator ID="val_ValueTextBox_required" runat="server" ErrorMessage="Attribute value is required." ControlToValidate="ValueTextBox" ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <asp:Button ID="DeselectButton" runat="server" CausesValidation="False" 
                                CommandName="Deselect" CssClass="rlvBSel" Text=" " ToolTip="Deselect" />
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SpecificationAttributeOptionLabel" runat="server" 
                                Text='<%# Eval("SpecificationAttributeOption.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("Value") %>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                Checked='<%# Eval("Active") %>' Enabled="false" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllSpecificationAttributeOptions"
                TypeName="SpecificationAttributeOption">
                <SelectParameters>
                    <asp:Parameter DefaultValue="6" Name="SpecificationAttribId" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetManageKVPairs"
                TypeName="SpecificationAttributeOptionKeyValue" UpdateMethod="updateKey" InsertMethod="insertKey">
                <InsertParameters>
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="value" Type="String" />
                    <asp:Parameter Name="active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="6" Name="SAId" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                    <asp:Parameter Name="value" Type="String" />
                    <asp:Parameter Name="active" Type="Boolean" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
        ShowSummary="false" />
</asp:Content>