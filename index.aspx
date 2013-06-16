<%@ Page Title="" Language="C#" MasterPageFile="~/MappingTool.Master" AutoEventWireup="true"
    CodeBehind="index.aspx.cs" Inherits="WebApplication1.index" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Program Outcome Mapping Tool - RMIT</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="submb">
                    <div class="article">
                        <p id="heading">
                            Program Outcome Mapping Tool</p>
                        <p>
                            Curriculum mapping, particularly in relation to graduate capabilities, has become
                            increasingly popular in Australian universities in recent years. Many universities
                            have developed, or are in the process of developing, excellent tools. Curtin’s Curriculum
                            Mapping Tool (abbreviated hereafter as CCMap) is available as part of an Australian
                            Learning and Teaching Council (ALTC) Fellowship, Benchmarking Partnerships for Graduate
                            Employability, led by Professor Beverley Oliver (see <a href="http://tiny.cc/boliver">
                                http://tiny.cc/boliver</a>). Similar resources are already in use across the
                            sector: sharing Curtin’s CCMap is aimed at encouraging others to share alike, use
                            peer review for enhancements and scholarship and enhance the potential of the formal
                            curriculum to affect improved graduate employability.
                        </p>
                        <p>
                            Program Outcome Mapping Tool provides an easy to use interface to input and prepare
                            reports about the capabilities in programs and their development and assessment
                            in courses.</p>
                    </div>
                    <div class="article">
                        <p id="gradimage">
                        </p>
                    </div>
                </div>
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Content>
