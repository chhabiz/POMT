<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/SuperAdmin.master" AutoEventWireup="true"
    CodeBehind="AssignAdmin.aspx.cs" Inherits="CurriculumMapping.SuperAdmin.AssignAdmin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="superadminhead" runat="server">
    <title>Assign Admin - Super Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                
                CellPadding="0" DataSourceID="ods_GetAllColleges" GridLines="Vertical" 
                onrowcommand="GridView1_RowCommand" AllowPaging="True" ForeColor="Black">
                <AlternatingRowStyle BackColor="White" HorizontalAlign="Left" />
                <Columns>
                    <asp:TemplateField HeaderText="College Administrator">
                        <ItemTemplate>
                            <table width="575px">
                                <thead>
                                    <tr>   
                                        <th style="color:Black;">
                                        College
                                        </th>
                                        <th style="color:Black;">
                                        Name
                                        </th>
                                        <th style="color:Black;">
                                        Current Admin
                                        </th>
                                        <th style="color:Black;">
                                        Assign
                                        </th>
                                        <th style="color:Black;">
                                        Action
                                        </th>
                                    </tr>
                                </thead>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_CollegeName" runat="server" Text='<%# Eval("Name") %>' Width="150px"></asp:Label>
                                    
                                        <asp:Label ID="lbl_CollegeId" runat="server" Text='<%# Eval("Id") %>' 
                                            Visible="False" Width="0px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_FirstName" runat="server" 
                                            Text='<%# String.Format("{0} {1}",Eval("Admin.FirstName"), Eval("Admin.LastName")) %>' Width="75px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_Admin" runat="server" Text='<%# Eval("Admin.Id") %>' Width="75px"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddl_Admin" runat="server" 
                                            DataSourceID="ods_GetAllAdminIds" Width="100px">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="width:75px;">
                                        <telerik:RadButton ID="btn_Assign" runat="server" 
                                            Text="Assign"
                                            CommandName="Assign" 
                                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                         />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ods_GetAllColleges" runat="server" 
                SelectMethod="GetAllColleges" TypeName="College"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ods_GetAllAdminIds" runat="server" 
                SelectMethod="getAllAdminIds" TypeName="Administrator">
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
