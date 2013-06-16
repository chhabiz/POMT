<%@ Page Title="" Language="C#" MasterPageFile="~/ProgramAdmin/ProgramAdminMaster.master" AutoEventWireup="true"
    CodeBehind="GenerateReport.aspx.cs" Inherits="CurriculumMapping.ProgramAdmin.GenerateReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="progadminhead" runat="server">
    <title>Generate Interim Report - Program Admin</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="reportparams">
                <asp:Label ID="Label1" runat="server" SkinID="SkinLabel">Program Name:</asp:Label>
                <telerik:RadComboBox ID="lst_program" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="lst_program_SelectedIndexChanged">
                </telerik:RadComboBox>
                <br />
                <asp:Label ID="Label5" runat="server" SkinID="SkinLabel">Report (Archive):</asp:Label>
                <telerik:RadComboBox ID="lst_archives" runat="server" AutoPostBack="False">
                </telerik:RadComboBox>
                <br />
                <br />
                <asp:HiddenField ID="calYear" runat="server" />
                <asp:HiddenField ID="hf_pac1" runat="server" />
                <asp:HiddenField ID="hf_pac2" runat="server" />
                <asp:HiddenField ID="hf_pac3" runat="server" />
                <telerik:RadButton ID="RadButtonPrint" runat="server" OnClientClicked="printPartOfPage"
                    Text="View Report" Skin="Windows7">
                </telerik:RadButton>
                <br />
                <br />
            </div>            
            <div id="reportcontent">
                <h2>Learning Outcomes</h2>
                <br />
                <telerik:RadChart ID="RadChart1" runat="server" DataSourceID="ObjectDataSource1"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="True">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Percentage" DataLabelsColumn="Category" DataYColumn="Percentage"
                            Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Level of Thinking">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLOTStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart2" runat="server" DataSourceID="ObjectDataSource2"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="True">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Level of Thinking (Weighted)">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="getReportLOTStatisticsProp"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLOTPropStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart3" runat="server" DataSourceID="ObjectDataSource3"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="True">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Gratuate Attributes">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportGAStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart4" runat="server" DataSourceID="ObjectDataSource4"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="True">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Position-AlignedPosition="TopRight"
                            Dimensions-Paddings="2px, 8px, 6px, 3px">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis Visible="False">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance Dimensions-Margins="18%, 24%, 49px, 58px">
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Graduate Attributes (Weighted)">
                            <Appearance TextProperties-Font="Calibri, 12pt" TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="getReportLOTStatisticsProp"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportGAPropStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                                <telerik:RadChart ID="RadChart22" runat="server" DataSourceID="ObjectDataSource22"
                    Height="600px" Skin="Telerik" Width="900px" DataGroupColumn="Category">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Analyse" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Apply">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Create">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="136, 221, 246" />
                                            <telerik:GradientElement Color="97, 203, 234" Position="0.5" />
                                            <telerik:GradientElement Color="59, 161, 197" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="67, 181, 229" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Evaluate">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="163, 222, 78" />
                                            <telerik:GradientElement Color="132, 207, 27" Position="0.5" />
                                            <telerik:GradientElement Color="102, 181, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="94, 160, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Explain">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="79, 152, 198" />
                                            <telerik:GradientElement Color="34, 123, 182" Position="0.5" />
                                            <telerik:GradientElement Color="4, 85, 156" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="39, 103, 210" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Recall">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="86, 153, 78" />
                                            <telerik:GradientElement Color="43, 126, 33" Position="0.5" />
                                            <telerik:GradientElement Color="18, 96, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="46, 93, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="1" MinValue="1"
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis of Level of Thinking by Year and Semester ">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource22" runat="server" SelectMethod="getReportBarChartStatistics"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLOTBarChartStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart23" runat="server" DataGroupColumn="Category" DataSourceID="ObjectDataSource23"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Apply discipline knowledge, principles and concepts		"
                            DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries Name="Think critically, creatively and reflectively" DataLabelsColumn="Category"
                            DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Access, evaluate and synthesise information">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="136, 221, 246" />
                                            <telerik:GradientElement Color="97, 203, 234" Position="0.5" />
                                            <telerik:GradientElement Color="59, 161, 197" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="67, 181, 229" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Communicate effectively">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="163, 222, 78" />
                                            <telerik:GradientElement Color="132, 207, 27" Position="0.5" />
                                            <telerik:GradientElement Color="102, 181, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="94, 160, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Use technologies appropriately">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="79, 152, 198" />
                                            <telerik:GradientElement Color="34, 123, 182" Position="0.5" />
                                            <telerik:GradientElement Color="4, 85, 156" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="39, 103, 210" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Utilise lifelong learning skills">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="86, 153, 78" />
                                            <telerik:GradientElement Color="43, 126, 33" Position="0.5" />
                                            <telerik:GradientElement Color="18, 96, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="46, 93, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Recognise and apply international perspectives">
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Demonstrate cultural awareness and understanding">
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Apply professional skills">
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Position-AlignedPosition="TopRight" Dimensions-Paddings="2px, 8px, 6px, 3px">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="1" MinValue="1"
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis of Graduate Attributes by Year and Semester ">
                            <Appearance TextProperties-Color="Black" 
                                TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource23" runat="server" SelectMethod="getReportBarChartStatistics"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportGABarChartStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                 <telerik:RadChart ID="RadChart40" runat="server" 
                    DataSourceID="ObjectDataSource40" DefaultType="Pie" Height="600px" Skin="Telerik" 
                    Width="900px">
                     <Appearance Corners="Round, Round, Round, Round, 7">
                         <FillStyle FillType="ComplexGradient">
                             <FillSettings GradientMode="Horizontal">
                                 <ComplexGradient>
                                     <telerik:GradientElement Color="236, 236, 236" />
                                     <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                     <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                 </ComplexGradient>
                             </FillSettings>
                         </FillStyle>
                         <Border Color="130, 130, 130" />
                     </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" Type="Pie" DataLabelsColumn="Category" DataYColumn="Count">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Australian Qualifications Framework">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource40" runat="server" 
                    SelectMethod="getReportLOTStatistics" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear" 
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportAQFStatistics" Name="sprocedureName" 
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart41" runat="server" 
                    DataSourceID="ObjectDataSource41" DefaultType="Pie" Height="600px" Skin="Telerik" 
                    Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Percentage" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Australian Qualifications Framework (Weighted)">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource41" runat="server" 
                    SelectMethod="getReportLOTStatisticsProp" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportAQFPropStatistics" Name="sprocedureName" 
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />

                <telerik:RadChart ID="RadChart42" runat="server" DataGroupColumn="Count" 
                    DataSourceID="ObjectDataSource42" Height="600px" Skin="Telerik" 
                    Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Percentage" 
                            Name="0">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="1">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="2">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="136, 221, 246" />
                                            <telerik:GradientElement Color="97, 203, 234" Position="0.5" />
                                            <telerik:GradientElement Color="59, 161, 197" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="67, 181, 229" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="3">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="163, 222, 78" />
                                            <telerik:GradientElement Color="132, 207, 27" Position="0.5" />
                                            <telerik:GradientElement Color="102, 181, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="94, 160, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="4">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="79, 152, 198" />
                                            <telerik:GradientElement Color="34, 123, 182" Position="0.5" />
                                            <telerik:GradientElement Color="4, 85, 156" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="39, 103, 210" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="5">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="86, 153, 78" />
                                            <telerik:GradientElement Color="43, 126, 33" Position="0.5" />
                                            <telerik:GradientElement Color="18, 96, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="46, 93, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="6">
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="7">
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="8">
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataYColumn="Percentage" Name="9">
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="1" 
                            MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis on AQF by Year and Semester">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource42" runat="server" 
                    SelectMethod="getReportBarChartStatistics" TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportAQFBarChartStatistics" Name="sprocedureName" 
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>

                <br/>

                <telerik:RadChart ID="RadChart45" runat="server" 
                    DataSourceID="ObjectDataSource43" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC One">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource43" runat="server" 
                    SelectMethod="getReportPACStatisticsPercentage" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac1" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br/>

                <telerik:RadChart ID="RadChart46" runat="server" 
                    DataSourceID="ObjectDataSource44" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" Type="Pie" DataLabelsColumn="Category" DataYColumn="Count">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC Two">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource44" runat="server" 
                    SelectMethod="getReportPACStatisticsPercentage" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac2" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart47" runat="server" 
                    DataSourceID="ObjectDataSource45" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Series 1" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
<telerik:ChartSeries Name="Series 2" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="218, 254, 122" />
                    <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                    <telerik:GradientElement Color="153, 205, 46" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
        <Border Color="111, 174, 12" />
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC Three">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource45" runat="server" 
                    SelectMethod="getReportPACStatisticsPercentage" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac3" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart48" runat="server" 
                    DataSourceID="ObjectDataSource46" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC (Weighted) One">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource46" runat="server" 
                    SelectMethod="getReportPACStatisticsProp" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACPropStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac1" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart49" runat="server" 
                    DataSourceID="ObjectDataSource47" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC (Weighted) Two">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource47" runat="server" 
                    SelectMethod="getReportPACStatisticsProp" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACPropStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac2" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart50" runat="server" 
                    DataSourceID="ObjectDataSource48" DefaultType="Pie" Height="600px" 
                    Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
<telerik:ChartSeries Name="Series 1" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="213, 247, 255" />
                    <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                    <telerik:GradientElement Color="157, 217, 238" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
    </Appearance>
                        </telerik:ChartSeries>
<telerik:ChartSeries Name="Series 2" Type="Pie">
    <Appearance>
        <FillStyle FillType="ComplexGradient">
            <FillSettings>
                <ComplexGradient>
                    <telerik:GradientElement Color="218, 254, 122" />
                    <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                    <telerik:GradientElement Color="153, 205, 46" Position="1" />
                </ComplexGradient>
            </FillSettings>
        </FillStyle>
        <TextAppearance TextProperties-Color="51, 51, 51">
        </TextAppearance>
        <Border Color="111, 174, 12" />
    </Appearance>
                        </telerik:ChartSeries>
</Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="PAC (Weighted) Three">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource48" runat="server" 
                    SelectMethod="getReportPACStatisticsProp" TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACPropStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac3" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart51" runat="server" DataGroupColumn="YearSemData" 
                    DataSourceID="ObjectDataSource49" Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataXColumn="Percentage" 
                            DataYColumn="Percentage" Name="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="1" MinValue="1" 
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis on PAC One by Year and Semester">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource49" runat="server" 
                    SelectMethod="getReportPACBarChartStatistics" TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACBarChartStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac1" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br/>
                <telerik:RadChart ID="RadChart52" runat="server" 
                    DataSourceID="ObjectDataSource50" Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries Name="Series 2">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis on PAC Two by Year and Semester">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource50" runat="server" 
                    SelectMethod="getReportPACBarChartStatistics" TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACBarChartStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac2" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br/>
                <telerik:RadChart ID="RadChart53" runat="server" 
                    DataSourceID="ObjectDataSource51" Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" 
                            Name="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="7" 
                            MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis on PAC Three by Year and Semester">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource51" runat="server" 
                    SelectMethod="getReportPACBarChartStatistics" TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" 
                            Name="programCode" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" 
                            Name="calendarYear" PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportPACBarChartStatistics" Name="sprocedureName" 
                            Type="String" />
                        <asp:ControlParameter ControlID="hf_pac3" DefaultValue="0" Name="pac" 
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <h2>Assessment</h2>
                <br />
                <telerik:RadChart ID="RadChart5" runat="server" DataSourceID="ObjectDataSource5"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks by Type">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATTypeStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart6" runat="server" DataSourceID="ObjectDataSource6"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks by Medium">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATMediumStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart7" runat="server" DataSourceID="ObjectDataSource7"
                    Height="600px" Width="900px" Skin="Telerik" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Count" DataYColumn="Count">
                            <Appearance LegendDisplayMode="SeriesName">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Number of written  assessment tasks by Format">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" SelectMethod="getReportLOTStatistics"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATFormatStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart39" runat="server" DataSourceID="ObjectDataSource39"
                    DefaultType="Pie" Height="600px" Width="900px" Skin="Telerik">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Multichoice" DataLabelsColumn="Category" DataYColumn="Count"
                            Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="true">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Format summary">
                            <Appearance TextProperties-Color="Black" 
                                TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource39" runat="server" SelectMethod="getReportLOTStatistics"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATFormatMultiChoiceStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <br />
                <telerik:RadChart ID="RadChart8" runat="server" DataSourceID="ObjectDataSource8"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of  assessment tasks by Role (individual /pair/group)">
                            <Appearance TextProperties-Font="Calibri, 12pt" TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATRoleStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart9" runat="server" DataSourceID="ObjectDataSource9"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of  assessment tasks  by level of Authenticity">
                            <Appearance TextProperties-Font="Calibri, 12pt" TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATAuthenticityStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart10" runat="server" DataSourceID="ObjectDataSource10"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks  by level of Supervision">
                            <Appearance TextProperties-Font="Calibri, 12pt" TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATSupervisionStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart11" runat="server" DataSourceID="ObjectDataSource11"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance MajorTick-Color="216, 216, 216" Color="182, 182, 182">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks by Mode (online/face-to-face/blended)">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATModeStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart12" runat="server" DataSourceID="ObjectDataSource12"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks  by Principal Assessor(s)">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource12" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATAssessorsStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart13" runat="server" DataSourceID="ObjectDataSource13"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks by Purpose">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource13" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATPurposeStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                
                <br />
                <telerik:RadChart ID="RadChart24" runat="server" DataSourceID="ObjectDataSource24"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataYColumn="Count">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries DataYColumn="Percentage" Name="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of assessment tasks by Week Due for all years">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource24" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATDueWeekBarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart25" runat="server" DataSourceID="ObjectDataSource25"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 1 Semester 1">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource25" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY1S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart26" runat="server" DataSourceID="ObjectDataSource26"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 1 Semester 2">
                            <Appearance TextProperties-Color="Black" 
                                TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource26" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY1S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart27" runat="server" DataSourceID="ObjectDataSource27"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 2 Semester 1">
                            <Appearance TextProperties-Color="Black" 
                                TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource27" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY2S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart28" runat="server" DataSourceID="ObjectDataSource28"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 2 Semester 2">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource28" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY2S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart29" runat="server" DataSourceID="ObjectDataSource29"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 3 Semester 1">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource29" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY3S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart30" runat="server" DataSourceID="ObjectDataSource30"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries Name="Series 2">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 3 Semester 2">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource30" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY3S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart31" runat="server" DataSourceID="ObjectDataSource31"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment  tasks by Week Due in Year 4 Semester 1">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource31" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY4S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart32" runat="server" DataSourceID="ObjectDataSource32"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 4 Semester 2">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource32" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY4S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart33" runat="server" DataSourceID="ObjectDataSource33"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 5 Semester 1">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource33" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY5S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart34" runat="server" DataSourceID="ObjectDataSource34"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 5 Semester 2">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource34" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY5S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart35" runat="server" DataSourceID="ObjectDataSource35"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 6 Semester 1">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource35" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY6S1BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart36" runat="server" DataSourceID="ObjectDataSource36"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Count" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <%--<telerik:ChartSeries Name="Percentage" DataYColumn="Percentage">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>--%>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="Category" MaxValue="7" MinValue="1" Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Assessment tasks by Week Due in Year 6 Semester 2">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource36" runat="server" SelectMethod="getReportBarChartStatisticsProp"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportATY6S2BarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <h2>Learning Experiences</h2>
                <br />
                <telerik:RadChart ID="RadChart14" runat="server" DataSourceID="ObjectDataSource14"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataXColumn="Category" DataYColumn="Percentage"
                            Name="Series 1" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of learning experiences  by Type">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource14" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLETuitionPatternStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart15" runat="server" DataSourceID="ObjectDataSource15"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of  learning experiences  by Duration">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource15" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLEDurationStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart16" runat="server" DataSourceID="ObjectDataSource16"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataXColumn="Category" DataYColumn="Percentage"
                            Name="Series 1" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of learning experiences by Frequency">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource16" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLEFreqStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart17" runat="server" DataSourceID="ObjectDataSource17"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Proportion of learning experiences by  Predominant Student Activity">
                            <Appearance TextProperties-Font="Calibri, 12pt" TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource17" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLEStudentActStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <h2>Learning Resources</h2>
                <br />
                <telerik:RadChart ID="RadChart18" runat="server" DataSourceID="ObjectDataSource18"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Learning resources by Type">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource18" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLRResourceStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart19" runat="server" DataSourceID="ObjectDataSource19"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Learning resources by Frequency of Use">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource19" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLRFreqUseStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart20" runat="server" DataSourceID="ObjectDataSource20"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Learning resources by Cost to Students">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource20" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportLRCostStudentStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <h2>Curriculum Themes</h2>
                <br />
                <telerik:RadChart ID="RadChart21" runat="server" DataSourceID="ObjectDataSource21"
                    DefaultType="Pie" Height="600px" Skin="Telerik" Width="900px" AutoTextWrap="true">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" DataLabelsColumn="Category" DataXColumn="Category"
                            DataYColumn="Percentage" Type="Pie">
                            <Appearance LegendDisplayMode="ItemLabels">
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" Dimensions-Paddings="2px, 8px, 6px, 3px"
                            Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <DataTable Visible="True">
                        </DataTable>
                        <XAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle MainColor="White" FillType="Solid">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Emphasis of level of engagement with Curriculum Themes  ">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Calibri, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource21" runat="server" SelectMethod="getReportLOTStatisticsPercentage"
                    TypeName="ReportData">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportTILevelStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <telerik:RadChart ID="RadChart37" runat="server" DataGroupColumn="Category" DataSourceID="ObjectDataSource37"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Information about matters relating to this theme" DataLabelsColumn="YearSemData"
                            DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries Name="Upskilling in this theme " DataLabelsColumn="YearSemData"
                            DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="YearSemData" DataYColumn="Count" Name="Hands on engagement with this theme">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="136, 221, 246" />
                                            <telerik:GradientElement Color="97, 203, 234" Position="0.5" />
                                            <telerik:GradientElement Color="59, 161, 197" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="67, 181, 229" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="1" MinValue="1"
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Level of engagement with  Curriculum Themes across the course">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource37" runat="server" SelectMethod="getReportTripleIBarChartStatistics"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportTIBarChartStatistics" Name="sprocedureName" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
                <h2>Australian Blueprint for Career Development</h2>
                <br />
                <telerik:RadChart ID="RadChart38" runat="server" DataGroupColumn="Category" DataSourceID="ObjectDataSource38"
                    Height="600px" Skin="Telerik" Width="900px">
                    <Appearance Corners="Round, Round, Round, Round, 7">
                        <FillStyle FillType="ComplexGradient">
                            <FillSettings GradientMode="Horizontal">
                                <ComplexGradient>
                                    <telerik:GradientElement Color="236, 236, 236" />
                                    <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                    <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                </ComplexGradient>
                            </FillSettings>
                        </FillStyle>
                        <Border Color="130, 130, 130" />
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Acquire" DataLabelsColumn="Category" DataYColumn="Count">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="213, 247, 255" />
                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Apply">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="218, 254, 122" />
                                            <telerik:GradientElement Color="198, 244, 80" Position="0.5" />
                                            <telerik:GradientElement Color="153, 205, 46" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="111, 174, 12" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Personalize">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="136, 221, 246" />
                                            <telerik:GradientElement Color="97, 203, 234" Position="0.5" />
                                            <telerik:GradientElement Color="59, 161, 197" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="67, 181, 229" />
                            </Appearance>
                        </telerik:ChartSeries>
                        <telerik:ChartSeries DataLabelsColumn="Category" DataYColumn="Count" Name="Act">
                            <Appearance>
                                <FillStyle FillType="ComplexGradient">
                                    <FillSettings>
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="163, 222, 78" />
                                            <telerik:GradientElement Color="132, 207, 27" Position="0.5" />
                                            <telerik:GradientElement Color="102, 181, 3" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                                <Border Color="94, 160, 0" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance Dimensions-Margins="17.6%, 3%, 1px, 1px" 
                            Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                            <ItemMarkerAppearance Figure="Square">
                                <Border Width="0" />
                            </ItemMarkerAppearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                            <Border Width="0" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="YearSemData" MaxValue="1" MinValue="1"
                            Step="1">
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216">
                                <MajorGridLines Color="216, 216, 216" PenStyle="Solid" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                    <TextBlock Text="abc">
                                    </TextBlock>
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                            <Appearance Color="182, 182, 182" MajorTick-Color="216, 216, 216" 
                                MinorTick-Color="223, 223, 223">
                                <MajorGridLines Color="216, 216, 216" />
                                <MinorGridLines Color="223, 223, 223" />
                                <TextAppearance TextProperties-Color="51, 51, 51">
                                </TextAppearance>
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Color="51, 51, 51">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <Appearance>
                            <FillStyle FillType="Solid" MainColor="White">
                            </FillStyle>
                            <Border Color="182, 182, 182" />
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance>
                            <FillStyle MainColor="">
                            </FillStyle>
                        </Appearance>
                        <TextBlock Text="Level of engagement with each competency">
                            <Appearance TextProperties-Font="Calibri, 12pt" 
                                TextProperties-Color="Black">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>
                <asp:ObjectDataSource ID="ObjectDataSource38" runat="server" SelectMethod="getReportABCDBarChartStatistics"
                    TypeName="BarChartReport">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lst_program" DefaultValue="0" Name="programCode"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="calYear" DefaultValue="1900" Name="calendarYear"
                            PropertyName="Value" Type="String" />
                        <asp:Parameter DefaultValue="IReportABCDBarChartStatistics" Name="sprocedureName"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
