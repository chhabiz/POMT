<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="AssignProgramCourse.aspx.cs" Inherits="CurriculumMapping.Admin.AssignProgramCourse" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Assign Course to Program - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">

            <asp:Label ID="Label2" runat="server" SkinID="SkinLabel">School Name:</asp:Label>
            <telerik:RadComboBox ID="lst_school" runat="server" AutoPostBack="True" 
                onselectedindexchanged="lst_school_SelectedIndexChanged">
            </telerik:RadComboBox>
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">Program Name:</asp:Label>
            <telerik:RadComboBox ID="lst_program" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />
           
            <asp:Label ID="Label3" runat="server" SkinID="SkinLabel">Course Name:</asp:Label>
            <telerik:RadComboBox ID="lst_course" runat="server">
            </telerik:RadComboBox>
            <br />
            <br />

            <telerik:RadButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Assign">
            </telerik:RadButton>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server"></asp:Label>

            &nbsp;<telerik:RadListView ID="RadListView1" runat="server" 
                DataSourceID="SqlDataSource1" AllowPaging="True">
                <LayoutTemplate>
                    <div class="RadListView RadListView_Default">
                        <table cellspacing="0" style="width:100%;">
                            <thead>
                                <tr class="rlvHeader">
                                    <th>
                                        Program</th>
                                    <th>
                                        Course</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <td colspan="4">
                                        <telerik:RadDataPager ID="RadDataPager1" runat="server">
                                            <Fields>
                                                <telerik:RadDataPagerButtonField FieldType="FirstPrev" />
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
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code"), Eval("Name")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="Code1Label" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code1"), Eval("Title")) %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="rlvA">
                        <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code"), Eval("Name")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="Code1Label" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code1"), Eval("Title")) %>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="4">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" 
                                            Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" 
                                            Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Name") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Code1Label2" runat="server" AssociatedControlID="Code1TextBox" 
                                            Text="Code1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Code1TextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code1") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TitleLabel2" runat="server" AssociatedControlID="TitleTextBox" 
                                            Text="Title"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TitleTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Title") %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <tr class="rlvIEdit">
                        <td colspan="4">
                            <table cellspacing="0" class="rlvEditTable">
                                <tr>
                                    <td>
                                        <asp:Label ID="CodeLabel2" runat="server" AssociatedControlID="CodeTextBox" 
                                            Text="Code"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CodeTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="NameLabel2" runat="server" AssociatedControlID="NameTextBox" 
                                            Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Name") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Code1Label2" runat="server" AssociatedControlID="Code1TextBox" 
                                            Text="Code1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Code1TextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Code1") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TitleLabel2" runat="server" AssociatedControlID="TitleTextBox" 
                                            Text="Title"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TitleTextBox" runat="server" CssClass="rlvInput" 
                                            Text='<%# Bind("Title") %>' />
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
                    <div class="RadListView RadListView_Default">
                        <div class="rlvEmpty">
                            There are no items to be displayed.</div>
                    </div>
                </EmptyDataTemplate>
                <SelectedItemTemplate>
                    <tr class="rlvISel">
                       <td>
                            <asp:Label ID="CodeLabel" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code"), Eval("Name")) %>' />
                        </td>
                        <td>
                            <asp:Label ID="Code1Label" runat="server" Text='<%# String.Format("{0}-{1}",Eval("Code1"), Eval("Title")) %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </telerik:RadListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:CMT_CS %>" 
                SelectCommand="GetCourseProgram" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lst_school" DefaultValue="0" Name="SchoolId" 
                        PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
