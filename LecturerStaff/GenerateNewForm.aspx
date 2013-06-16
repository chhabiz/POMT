<%@ Page Title="" Language="C#" MasterPageFile="~/LecturerStaff/LecturerMaster.master"
    AutoEventWireup="true" CodeBehind="GenerateNewForm.aspx.cs" Inherits="CurriculumMapping.LecturerStaff.GenerateNewForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="lecthead" runat="server">
    <title>Generate New Form - Staff</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMainArea" runat="server">
    <div class="maincontent">
        <div id="textcontent">
            <div id="formdata">
                <asp:HiddenField ID="CourseOfferingIdField" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="hf_pac1" runat="server" />
                <asp:HiddenField ID="hf_pac2" runat="server" />
                <asp:HiddenField ID="hf_pac3" runat="server" />
                <asp:HiddenField ID="hf_aqf" runat="server" />
                <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View7" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Copy Data from Previous Record"></asp:Label>
                        <asp:CheckBox ID="copydata_chkBox" runat="server" />
                        <br />
                        <asp:Button ID="CopyButton" runat="server" Text="Next" OnClick="CopyButton_Click"
                            CommandName="NextView" />
                    </asp:View>
                    <asp:View ID="View1" runat="server">
                        <asp:GridView ID="Gridview1" runat="server" ShowFooter="true" 
                            AutoGenerateColumns="false" onrowdatabound="Gridview1_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="RowNumber" HeaderText="No" />
                                <asp:TemplateField HeaderText="Unit Learning Outcomes(ULO's)">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_Question" runat="server" SkinID="Skin50pxText"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Level of Thinking">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_LOT" runat="server" DataSourceID="sql_LOT" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Primary to GA">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_PTGA" runat="server" DataSourceID="sql_GAOptionsPrimary"
                                            DataTextField="Value" DataValueField="Id" Width="50px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="also GA (Optional)">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_AlsoGA1" runat="server" DataSourceID="sql_GAOptions" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="also GA (Optional)">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_AlsoGA2" runat="server" DataSourceID="sql_GAOptions" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Professional Accreditation Competencies 1">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_PAC1" runat="server" DataSourceID="sql_PAC1" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Professional Accreditation Competencies 2">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_PAC2" runat="server" DataSourceID="sql_PAC2" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Professional Accreditation Competencies 3">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_PAC3" runat="server" DataSourceID="sql_PAC3" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Australian Qualification Framework">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_AQF" runat="server" DataSourceID="sql_AQF" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="ButtonAdd" runat="server" Text="Add New Unit Learning Outcome" OnClick="ButtonAdd_Click" />
                        <asp:Button ID="ButtonAddMultiple" runat="server" Text="Add New Unit Learning Outcome"
                            OnClick="ButtonAddMultiple_Click" Visible="false" />
                        <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click"
                            CommandName="NextView" />
                        <asp:Button ID="ButtonULOSkip" runat="server" Text="Skip" OnClick="ButtonULOSkip_Click"
                            CommandName="NextView" Visible="false" />
                        <asp:SqlDataSource ID="sql_LOT" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
                                SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Level of Thinking')">
                        </asp:SqlDataSource>
                        <asp:ObjectDataSource ID="sql_GAOptionsPrimary" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllPrimarilyGAs" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="sql_GAOptions" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllOtherGAs" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="sql_PAC1" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllPAC1" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="sql_PAC2" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllPAC2" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="sql_PAC3" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllPAC3" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="sql_AQF" runat="server" SelectMethod="GetFormDataList"
                            TypeName="FormData">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="GetAllAQFOptions" Name="sprocname" Type="String" />
                                <asp:ControlParameter ControlID="HiddenField1" DefaultValue="NoValue" Name="programCode"
                                    PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <br />
                        <br />
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <asp:GridView ID="Gridview2" runat="server" ShowFooter="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="RowNumber" HeaderText="No" />
                                <asp:TemplateField HeaderText="Assesment Tasks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_AssessmentQuestion" runat="server" SkinID="Skin50pxText"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Weighting(%)">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_Weighting" runat="server" SkinID="Skin50pxText"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Week">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_DueWeek" runat="server" SkinID="Skin50pxText"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Primary to ULO">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_PULO" runat="server" DataSourceID="ods_GetAllOfferingIds">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="also ULO (Optional)">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_AlsoULO1" runat="server" DataSourceID="ods_GetAllOfferingIds">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="also ULO (Optional)">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_AlsoULO2" runat="server" DataSourceID="ods_GetAllOfferingIds">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Type" runat="server" DataSourceID="sql_Type" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Medium">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Medium" runat="server" DataSourceID="sql_Medium" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Format if Written">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Format" runat="server" DataSourceID="sql_Format" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Role" runat="server" DataSourceID="sql_Role" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Authenticity">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Authenticity" runat="server" DataSourceID="sql_Authenticity"
                                            DataTextField="Value" DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Supervision">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Supervision" runat="server" DataSourceID="sql_Supervision"
                                            DataTextField="Value" DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mode">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Mode" runat="server" DataSourceID="sql_Mode" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Principal Assessors">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Assessors" runat="server" DataSourceID="sql_Assessors"
                                            DataTextField="Value" DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Purpose">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Purpose" runat="server" DataSourceID="sql_Purpose" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="ButtonAddAssessment" runat="server" Text="Add New Assessment" OnClick="ButtonAddAssessmentTask_Click" />
                        <asp:Button ID="ButtonAddAssessmentMultiple" runat="server" Text="Add New Assessment"
                            OnClick="ButtonAddAssessmentTaskMultiple_Click" />
                        <asp:Button ID="ButtonSaveAssessment" runat="server" Text="Save" OnClick="ButtonSaveAssessmentTask_Click"
                            CommandName="NextView" />
                        <asp:Button ID="ButtonAssessmentSkip" runat="server" Text="Skip" OnClick="ButtonAssessmentSkip_Click"
                            CommandName="NextView" Visible="false" />
                        <asp:ObjectDataSource ID="ods_GetAllOfferingIds" runat="server" SelectMethod="getAllULO"
                            TypeName="CourseOffering">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="CourseOfferingIdField" Name="OfferingId" PropertyName="Value"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:SqlDataSource ID="sql_Type" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Type')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Medium" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Medium')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Format" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Format if Written')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Role" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Role')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Authenticity" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Authenticity')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Supervision" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Supervision')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Mode" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Mode')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Assessors" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Principal Assessor(s)')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Purpose" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Purpose')">
                        </asp:SqlDataSource>
                        <br />
                        <br />
                    </asp:View>
                    <asp:View ID="View3" runat="server">
                        <asp:GridView ID="Gridview3" runat="server" ShowFooter="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="RowNumber" HeaderText="No" />
                                <asp:TemplateField HeaderText="Learning Experience(Tution Pattern)">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_LearningExperiance" runat="server" DataSourceID="sql_LearningExperiance"
                                            DataTextField="Value" DataValueField="Id" Width="200px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Duration">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Duration" runat="server" DataSourceID="sql_Duration" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Frequency  ">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Frequency" runat="server" DataSourceID="sql_Frequency"
                                            DataTextField="Value" DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Main student activity ">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_MSA" runat="server" DataSourceID="sql_MSA" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="Button1" runat="server" Text="Add New Learning Experiance" OnClick="ButtonAddLearningExperiance_Click" />
                        <asp:Button ID="Button8" runat="server" Text="Add New Learning Experiance" OnClick="ButtonAddLearningExperianceMultiple_Click" />
                        <asp:Button ID="Button2" runat="server" Text="Save" OnClick="ButtonSaveLearningExperiance_Click"
                            CommandName="NextView" />
                        <asp:Button ID="ButtonLearningExperienceSkip" runat="server" Text="Skip" OnClick="ButtonLearningExperienceSkip_Click"
                            CommandName="NextView" Visible="false" />
                        <asp:SqlDataSource ID="sql_LearningExperiance" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
                                SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Learning experiences (Tuition pattern)')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Duration" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
                                SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Duration')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Frequency" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Frequency  ')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_MSA" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Main student activity ')">
                        </asp:SqlDataSource>
                        <br />
                        <br />
                    </asp:View>
                    <asp:View ID="View4" runat="server">
                        <asp:GridView ID="Gridview4" runat="server" ShowFooter="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Themes">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Theme" runat="server"></asp:Label>
                                        <asp:Label ID="lbl_ThemeId" runat="server" Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Triple-I Curriculum Themes">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_TripleICurriculumThemes" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Levels">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Levels" runat="server" DataSourceID="sql_Levels" DataTextField="Value"
                                            DataValueField="Id" Width="300px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="Button4" runat="server" Text="Save" OnClick="ButtonSaveTheme_Click"
                            CommandName="NextView" />
                        <asp:Button ID="ButtonThemeSkip" runat="server" Text="Skip" OnClick="ButtonThemeSkip_Click"
                            CommandName="NextView" Visible="false" />
                        <br />
                        <br />
                        Note*- Triple- I Curriculum is not Loaded, If you have used the Copy Functionality,
                        the themes keep
                        <br />
                        changing and may not be present for the previous form.
                        <asp:SqlDataSource ID="sql_Levels" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Level')">
                        </asp:SqlDataSource>
                        <br />
                        <br />
                    </asp:View>
                    <asp:View ID="View5" runat="server">
                        <asp:GridView ID="Gridview5" runat="server" ShowFooter="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="RowNumber" HeaderText="No" />
                                <asp:TemplateField HeaderText="Australian Blueprint for Career Development">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_ABCD" runat="server" Width="200px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Area">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Area" runat="server" DataSourceID="sql_Area" DataTextField="Value"
                                            DataValueField="Id" Width="200px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Level of engagement">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_LOE" runat="server" DataSourceID="sql_LOE" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="btn_AddABCD" runat="server" Text="Add New Australian Blueprint" OnClick="ButtonAddABCD_Click" />
                        <asp:Button ID="btn_AddABCDMultiple" runat="server" Text="Add New Australian Blueprint"
                            OnClick="ButtonAddABCDMultiple_Click" />
                        <asp:Button ID="Button6" runat="server" Text="Save" OnClick="ButtonSaveABCD_Click"
                            CommandName="NextView" />
                        <asp:Button ID="ButtonABCDSkip" runat="server" Text="Skip" OnClick="ButtonABCDSkip_Click"
                            CommandName="NextView" Visible="false" />
                        <asp:SqlDataSource ID="sql_Area" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
                                SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Area')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_LOE" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
                                SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Level of engagement')">
                        </asp:SqlDataSource>
                        <br />
                        <br />
                    </asp:View>
                    <asp:View ID="View6" runat="server">
                        <asp:GridView ID="Gridview6" runat="server" ShowFooter="true" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="RowNumber" HeaderText="No" />
                                <asp:TemplateField HeaderText="Resources">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Resources" runat="server" DataSourceID="sql_Resources"
                                            DataTextField="Value" DataValueField="Id" Width="200px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recommended Frequency of Use">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_FrequencyOfUse" runat="server" DataSourceID="sql_FrequencyOfUse"
                                            DataTextField="Value" DataValueField="Id" Width="200px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cost of Student">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Cost" runat="server" DataSourceID="sql_Cost" DataTextField="Value"
                                            DataValueField="Id">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="btn_LearningResource" runat="server" Text="Add Learning Resource"
                            OnClick="ButtonAddLearningResource_Click" />
                        <asp:Button ID="btn_LearningResourceMultiple" runat="server" Text="Add Learning Resource"
                            OnClick="ButtonAddLearningResourceMultiple_Click" />
                        <asp:Button ID="Button3" runat="server" Text="Save" OnClick="ButtonSaveLearningResource_Click" />
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" />
                        <asp:SqlDataSource ID="sql_Resources" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Resource')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_FrequencyOfUse" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Recommended frequency of use')">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sql_Cost" runat="server" ConnectionString="<%$ ConnectionStrings:CMT_CS %>"
                            SelectCommand="	SELECT Id,[Key],Value FROM SpecificationAttributeOptionKeyValue WHERE 
	                            SpecificationAttributeOptionId= (SELECT Id FROM SpecificationAttributeOption WHERE Name='Cost to student')">
                        </asp:SqlDataSource>
                        <br />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        
                        <br />
                    </asp:View>
                </asp:MultiView>
                <br />
                <asp:Label ID="msgLabel" runat="server"></asp:Label>
            </div>
            <hr />
            <br />
            <div id="scrollright">
                <span>Use your mouse wheel to scroll the above grid for more options<img alt="scrollright"
                    src="../images/right_arrow.png" width="25px" height="25px" /></span>
                <br />
                <span>Click
                    <asp:Button ID="toggleButton" runat="server" OnClientClick="toggleScrollbar(); return false;"
                        Text="Toggle Scrollbar" />
                    to toggle a scrollbar into view if you cannot scroll. </span>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#formdata").mousewheel(function (event, delta) {
                this.scrollLeft -= (delta * 30);
                event.preventDefault();
            });
        });

        function toggleScrollbar() {
            if (document.getElementById("formdata").style.overflowX == "scroll")
                document.getElementById("formdata").style.overflowX = "hidden";
            else
                document.getElementById("formdata").style.overflowX = "scroll";
        }
    </script>
</asp:Content>
