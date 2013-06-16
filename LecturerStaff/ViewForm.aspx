<%@ Page Title="" Language="C#" MasterPageFile="~/LecturerStaff/LecturerMaster.master"
    AutoEventWireup="true" CodeBehind="ViewForm.aspx.cs" Inherits="CurriculumMapping.LecturerStaff.ViewForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="lecthead" runat="server">
    <title>View Form - Staff</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="formdata">
                <asp:HiddenField ID="hf_pac1" runat="server" />
                <asp:HiddenField ID="hf_pac2" runat="server" />
                <asp:HiddenField ID="hf_pac3" runat="server" />
                <asp:HiddenField ID="hf_aqf" runat="server" />
                <div id="backbutton">
                    <a href="MyPendingForms.aspx">
                        <img alt="Back icon" src="../images/undo_256.png" width="20px" height="20px" />Back</a>
                </div>
                <div id="coursetitle">
                    <asp:Label ID="labelCourseName" runat="server"></asp:Label>
                </div>
                <hr />
                <br />
                <asp:Panel ID="pnlHeader1" runat="server">
                    <a href="">Unit Learning Outcomes</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo1" runat="server">
                    <asp:GridView ID="GridView1" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader1" ExpandControlID="pnlHeader1" TargetControlID="pnlInfo1"
                    SuppressPostBack="True" Collapsed="false">
                </asp:CollapsiblePanelExtender>
                <br />
                <asp:Panel ID="pnlHeader2" runat="server">
                    <a href="">Assessment Tasks</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo2" runat="server">
                    <asp:GridView ID="GridView2" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader2" ExpandControlID="pnlHeader2" TargetControlID="pnlInfo2"
                    SuppressPostBack="True" Collapsed="True">
                </asp:CollapsiblePanelExtender>
                <br />
                <asp:Panel ID="pnlHeader3" runat="server">
                    <a href="">Learning Experiences</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo3" runat="server">
                    <asp:GridView ID="GridView3" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader3" ExpandControlID="pnlHeader3" TargetControlID="pnlInfo3"
                    SuppressPostBack="True" Collapsed="True">
                </asp:CollapsiblePanelExtender>
                <br />
                <asp:Panel ID="pnlHeader4" runat="server">
                    <a href="">Triple-I Curriculum Themes</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo4" runat="server">
                    <asp:GridView ID="GridView4" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader4" ExpandControlID="pnlHeader4" TargetControlID="pnlInfo4"
                    SuppressPostBack="True" Collapsed="True">
                </asp:CollapsiblePanelExtender>
                <br />
                <asp:Panel ID="pnlHeader5" runat="server">
                    <a href="">Australian Blueprint for Career Development</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo5" runat="server">
                    <asp:GridView ID="GridView5" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender5" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader5" ExpandControlID="pnlHeader5" TargetControlID="pnlInfo5"
                    SuppressPostBack="True" Collapsed="True">
                </asp:CollapsiblePanelExtender>
                <br />
                <asp:Panel ID="pnlHeader6" runat="server">
                    <a href="">Learning Resources</a>
                </asp:Panel>
                <asp:Panel ID="pnlInfo6" runat="server">
                    <asp:GridView ID="GridView6" runat="server">
                    </asp:GridView>
                </asp:Panel>
                <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender6" runat="server" Enabled="true"
                    CollapseControlID="pnlHeader6" ExpandControlID="pnlHeader6" TargetControlID="pnlInfo6"
                    SuppressPostBack="True" Collapsed="True">
                </asp:CollapsiblePanelExtender>
                <br />
            </div>
        </div>
        <br />
        <div class="commentstab">
            <asp:Panel ID="pnl_ProgramAdmin" runat="server">
                <asp:Label ID="lbl_comment" runat="server" Text="Comments:" Width="100px"></asp:Label>
                <asp:TextBox ID="txt_comment" runat="server" TextMode="MultiLine"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btn_Approve" runat="server" Text="Approve" OnClick="btn_Approve_Click" />
                <asp:Button ID="btn_Reject" runat="server" Text="Reject" OnClick="btn_Reject_Click" />
            </asp:Panel>
        </div>
        <br />
    </div>
</asp:Content>
