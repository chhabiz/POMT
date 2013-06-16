<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeBehind="AssignProgramAdmin.aspx.cs" Inherits="CurriculumMapping.Admin.AssignProgramAdmin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="adminhead" runat="server">
    <title>Assign Program Manager - Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                
                CellPadding="0" DataSourceID="ods_GetAllColleges" GridLines="Vertical" 
                onrowcommand="GridView1_RowCommand" AllowPaging="True" ForeColor="Black">
                <AlternatingRowStyle BackColor="White" HorizontalAlign="Left" />
                <Columns>
                    <asp:TemplateField HeaderText="Program Managers">
                        <ItemTemplate>
                            <table width="575px">
                                <thead>
                                    <tr>   
                                        <th style="color:Black;">
                                        Program
                                        </th>
                                        <th style="color:Black;">
                                        Name
                                        </th>
                                        <th style="color:Black;">
                                        Current Manager
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
                                        <asp:Label ID="lbl_ProgramName" runat="server" Text='<%# Eval("Name") %>' Width="150px"></asp:Label>
                                    
                                        <asp:Label ID="lbl_ProgramId" runat="server" Text='<%# Eval("Code") %>' 
                                            Visible="False" Width="0px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_FirstName" runat="server" 
                                            Text='<%# String.Format("{0} {1}",Eval("ProgramManager.FirstName"), Eval("ProgramManager.LastName")) %>' Width="75px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_ProgAdmin" runat="server" Text='<%# Eval("ProgramManager.Id") %>' Width="75px"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="ddl_ProgAdmin" runat="server" 
                                            DataSourceID="ods_GetAllProgAdminIds" Width="100px">
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
                SelectMethod="GetAllPrograms" TypeName="Program">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField2" DefaultValue="0" 
                        Name="collegeId" PropertyName="Value" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ods_GetAllProgAdminIds" runat="server" 
                SelectMethod="getAllProgAdminIds" TypeName="ProgramManager">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" DefaultValue="0" Name="adminId" 
                        PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
        </div>
    </div>
</asp:Content>
