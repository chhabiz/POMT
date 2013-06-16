<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="ManageULOOption.aspx.cs" Inherits="CurriculumMapping.Admin.Keys" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Manage Unit Learning Outcomes - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:Label runat="server" ID="label1"></asp:Label>
            <div id="filterdiv">
                <telerik:RadFilter ID="RadFilter1" runat="server" ApplyButtonText="Filter Search" ExpressionPreviewPosition="Top"
                  FilterContainerID="RadListView1">
                </telerik:RadFilter>
            </div>
            <br />
            <%-- Keeping the add new key button outside the listview --%>
            <telerik:RadListView ID="RadListView1" runat="server" DataSourceID="ObjectDataSource2"
                ItemPlaceholderID="test1" DataKeyNames="Id" AllowPaging="True" OnItemCommand="RadListView1_ItemCommand"
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
                                        ID
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Value
                                    </th>
                                    <th>
                                        Active
                                    </th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="7">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                                            PageSize="12">
                                            <Fields>
                                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
                                                <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                                <telerik:RadDataPagerButtonField FieldType="NextLast" />
                                            </Fields>
                                        </telerik:RadDataPager>
                                    </td>
                                    <telerik:RadButton ID="AddButton1" runat="server" Visible="True" CommandName="InitInsert"
                                        Text="Add New CLO" />
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr runat="server" id="test1">
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
                            <asp:Label ID="IdLabel" runat="server" Text='<%#Eval("id")%>' />
                        </td>
                        <td>
                            <asp:Label ID="SpecAttribNameLabel" runat="server" Text='<%#Eval("specificationAttributeOption.Name")%>'  />
                        </td>
                        <td>
                            <asp:Label ID="ValueLabel" runat="server" Text='<%#Eval("value")%>' />
                        </td>
                        <td>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("active") %>' Enabled="false" />
                        </td>
                        <%--<td>
                            <telerik:RadButton ID="LinkButton1" runat="server" CommandName="Edit" Text="Edit" CausesValidation="false" />
                        </td>--%><%--
                        <td>
                            <telerik:RadButton ID="LinkButton2" runat="server" CommandName="Delete" OnClientClick="deleteWarning()"
                                Text="Delete" />
                        </td>--%>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="rlvA">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="rlvBEdit" Text=" " ToolTip="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SpecAttribNameLabel" runat="server" Text='<%# Eval("specificationAttributeOption.Name") %>' />
                        </td>
                        <td>
                            <asp:Label ID="ValueLabel" runat="server" Text='<%# Eval("value") %>' />
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
                                        <asp:Label ID="IDLabel1" runat="server" Text="ID"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="IDLabel2" runat="server" Text='<%#Eval("id")%>' Width="155px" Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SpecAttribtOptionNameLabel" runat="server" AssociatedControlID="TextBoxKey"
                                            Text="Value"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="TextBoxKey" runat="server" Text='<%# Eval("specificationAttributeOption.Name") %>'
                                            Width="155px" Enabled="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EditTBValueLabel" runat="server" AssociatedControlID="EditTBValue"
                                            Text="FirstName"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="EditTBValue" runat="server" Text='<%# Bind("value") %>' Width="155px"
                                            Enabled="false">
                                        </telerik:RadTextBox>
                                    </td>
                                    <asp:RequiredFieldValidator ID="EditValueValidator" runat="server" ControlToValidate="EditTBValue"
                                        ErrorMessage="Value could not be null" Text="Warning" Display="Dynamic"></asp:RequiredFieldValidator>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EditActiveLabel" runat="server" AssociatedControlID="EditCheckBox1"
                                            Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="EditCheckBox1" runat="server" Checked='<%# Bind("active") %>' Enabled="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="rlvBUpdate"
                                            Text=" " ToolTip="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="rlvBCancel"
                                            Text=" " ToolTip="Cancel" />
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
                                        <asp:Label ID="AttributeNameLabel" runat="server" AssociatedControlID="RadComboBox1" 
                                            Text="Attribute Name"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="RadComboBox1" runat="server" DataSourceID="ObjectDataSource1"
                                            DataTextField="Name" DataValueField="Id" Text='<%# Bind("name") %>' AutoPostBack="false"
                                            OnSelectedIndexChanged="RadComboBox1_SelectedIndexChanged" Width="155px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ValueLabel" runat="server" AssociatedControlID="InsertTBValue" 
                                            Text="Attribute Value"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="InsertTBValue" runat="server" Width="155px" Text='<%# Bind("value") %>'>
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="val_InsertTBValue_required" runat="server" ErrorMessage="Attribute value is required." ControlToValidate="InsertTBValue" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <%--<asp:RequiredFieldValidator ID="InsertValueValidator" runat="server" ControlToValidate="InsertTBValue" ErrorMessage="Value Could not be null" Text="Warning" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ActiveLabel" runat="server" AssociatedControlID="InsertCheckBox1" 
                                            Text="Active"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="InsertCheckBox1" runat="server" Checked='<%# Bind("active") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="InsertButton" runat="server" CommandName="PerformInsert"
                                            CssClass="rlvBAdd" Text=" " ToolTip="Insert" />
                                        <asp:Button ID="InsertCancelButton" runat="server" CommandName="Cancel"
                                            CausesValidation="false" CssClass="rlvBCancel" Text=" " ToolTip="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </InsertItemTemplate>
            </telerik:RadListView>
            <telerik:RadGrid ID="RadGrid1" runat="server">
            </telerik:RadGrid>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllSpecificationAttributeOptions"
                TypeName="SpecificationAttributeOption">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="SpecificationAttribId" Type="Int32" />
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
                    <asp:Parameter DefaultValue="2" Name="SAId" Type="Int32" />
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
