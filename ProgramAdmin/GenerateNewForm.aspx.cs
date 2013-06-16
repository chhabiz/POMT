using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace CurriculumMapping.ProgramAdmin
{
    public partial class GenerateNewForm : System.Web.UI.Page
    {
        //Course Offering Id that is to be taken from the Combo Box
        public static int offeringId = 0;

        List<string> optList = new List<string>();
        List<int> optListId = new List<int>();

        // If Data is to be copied from some other Form
        public static int copy;

        //Course Offering Id from which the data is to be copied
        public static int copyFrom;

        //Page Load Event
        protected void Page_Load(object sender, EventArgs e)
        {

            //Holds Value for Course Offering 
            CourseOfferingIdField.Value = offeringId.ToString();

            if (!Page.IsPostBack)
            {
                try
                {
                    //Identifies the User Role
                    Staff user = Driver.IdentifyRole(Session);

                    //Creates a User Designation Object
                    Designation userDesignation = new Designation();
                    userDesignation = user.Designation;

                    if (!(userDesignation.Description.Equals("Program Manager")) && !(userDesignation.Description.Equals("Administrator")))
                    {
                        //UnAuthorized Access Page.
                        Response.Redirect("../UnauthorizedPage.aspx", false);
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }

                try
                {
                    //Set the Course Offering Id
                    if (Request.QueryString["id"] != null)
                    {
                        offeringId = Convert.ToInt32(Request.QueryString["id"]);
                        String prog=getMyProgram(offeringId);
                        HiddenField1.Value = prog;

                        //Populate PAC information
                        this.hf_pac1.Value = Driver.getPAC(prog, "GetPAC1");
                        this.hf_pac2.Value = Driver.getPAC(prog, "GetPAC2");
                        this.hf_pac3.Value = Driver.getPAC(prog, "GetPAC3");
                        this.hf_aqf.Value = Driver.getAQFLevel(prog, "GetAQFLevel");
                    }
                }
                catch (Exception)
                {
                    //Redirect to the Pending Form if No Offering Id Available
                    Response.Redirect("MyPendingForms.aspx");
                }
                //Copy From Offering Id
                try
                {
                    //Getting the Request Parameters if Any
                    int copyFromParam = Int32.Parse(Request.QueryString["CF"].ToString());
                    if (offeringId == copyFromParam)
                    {
                        //This is Edit Form Condition
                        copy = 1;
                        copydata_chkBox.Checked.Equals(true);
                        Label1.Text = "You are about to Edit an existing Record. Please Click on 'Next' Button to proceed";
                        copydata_chkBox.Visible=false;

                        ButtonULOSkip.Visible = true;
                        ButtonABCDSkip.Visible = true;
                        ButtonThemeSkip.Visible = true;
                        ButtonLearningExperienceSkip.Visible = true;
                        ButtonAssessmentSkip.Visible = true;
                    }
                    else if (copyFromParam == 0)
                    {
                        //No previous Records to copy from
                        copy = 0;
                        Label1.Text = "No Previous Data for this Course is available. Please Enter new Data. Please Click on 'Next' Button to proceed";
                        copydata_chkBox.Visible=false;

                        ButtonULOSkip.Visible = false;
                        ButtonABCDSkip.Visible = false;
                        ButtonThemeSkip.Visible = false;
                        ButtonLearningExperienceSkip.Visible = false;
                        ButtonAssessmentSkip.Visible = false;
                    }
                    else
                    {
                        //If previous data exists, give the user choice to copy previous data
                        copy = 0;
                        Label1.Text = "Please Tick if you want to copy Data from Previous Record. Then, Please Click on 'Next' Button to proceed";
                        copydata_chkBox.Visible= true;

                        ButtonULOSkip.Visible = false;
                        ButtonABCDSkip.Visible = false;
                        ButtonThemeSkip.Visible = false;
                        ButtonLearningExperienceSkip.Visible = false;
                        ButtonAssessmentSkip.Visible = false;
                    }

                    
                }
                catch (Exception)
                {
                    //do nothing
                   
                }
                //Setting the Initial View to the First View of the MultiView (i.e the ULO View)
                SetDefaultView();

            }
        }


        //Setting the Default View
        public void SetDefaultView()
        {
            //Setting the Initial View to the ULO Grid View
            MultiView1.ActiveViewIndex = 0;
            btn_submit.Visible = false;
        }






        //Table UNIT LEARNING OUTCOMES//
        //-----------------------------------------------------------------------------------------------------------------------//

        //Setting Up the Initial Row in the GridView for ULO
        private void SetInitialRowULO()
        {
            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            //DataRow Temporary object
            DataRow dr = null;


            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("Question", typeof(string)));
            dt.Columns.Add(new DataColumn("LevelOfThinking", typeof(string)));
            dt.Columns.Add(new DataColumn("PrimaryToGA", typeof(string)));
            dt.Columns.Add(new DataColumn("AlsoGA1", typeof(string)));
            dt.Columns.Add(new DataColumn("AlsoGA2", typeof(string)));
            dt.Columns.Add(new DataColumn("PAC1", typeof(string)));
            dt.Columns.Add(new DataColumn("PAC2", typeof(string)));
            dt.Columns.Add(new DataColumn("PAC3", typeof(string)));
            dt.Columns.Add(new DataColumn("AQF", typeof(string)));


            //Check if Copy from Another Offering or not
            if (copy == 1)
            {

                //Temporary DataTable to Convert Text to Ddl Indexes
                DataTable dtViewState = new DataTable();
                DataRow drViewState;

                //Setting the Columns to the Initial Table
                dtViewState.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Question", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("LevelOfThinking", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("PrimaryToGA", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AlsoGA1", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AlsoGA2", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("PAC1", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("PAC2", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("PAC3", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AQF", typeof(string)));

                //Getting the Values of the ULO table from the Copy Form Source 
                if ((dt = fillingULOTableWithCopyData()) != null)
                {
                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Question"] = string.Empty;
                    dr["PrimaryToGA"] = string.Empty;
                    dr["AlsoGA1"] = string.Empty;
                    dr["AlsoGA2"] = string.Empty;
                    dr["PAC1"] = string.Empty;
                    dr["PAC2"] = string.Empty;
                    dr["PAC3"] = string.Empty;
                    dr["LevelOfThinking"] = string.Empty;
                    dr["AQF"] = string.Empty;
                    dt.Rows.Add(dr);

                    //Adding an Empty Row at the End, after the Copied Values
                    Gridview1.DataSource = dt;
                    Gridview1.DataBind();



                    //Setting Up an Empty Row (Its a Hack.. This Row is going to be Removed Later using (RemoveAt Method))
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Question"] = string.Empty;
                    dr["PrimaryToGA"] = string.Empty;
                    dr["AlsoGA1"] = string.Empty;
                    dr["AlsoGA2"] = string.Empty;
                    dr["PAC1"] = string.Empty;
                    dr["PAC2"] = string.Empty;
                    dr["PAC3"] = string.Empty;
                    dr["LevelOfThinking"] = string.Empty;
                    dr["AQF"] = string.Empty;
                    dt.Rows.Add(dr);


                    //Iterating through all the Rows..to set the Data of the Copy Form Source to the GridView
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < (dt.Rows.Count - 1); i++)
                        {
                            drViewState = dtViewState.NewRow();
                            drViewState["RowNumber"] = i + 1;

                            TextBox box1 = (TextBox)Gridview1.Rows[i].Cells[1].FindControl("txt_Question");
                            DropDownList box2 = (DropDownList)Gridview1.Rows[i].Cells[2].FindControl("ddl_PTGA");
                            DropDownList box3 = (DropDownList)Gridview1.Rows[i].Cells[3].FindControl("ddl_AlsoGA1");
                            DropDownList box4 = (DropDownList)Gridview1.Rows[i].Cells[4].FindControl("ddl_AlsoGA2");
                            DropDownList box5 = (DropDownList)Gridview1.Rows[i].Cells[5].FindControl("ddl_PAC1");
                            DropDownList box6 = (DropDownList)Gridview1.Rows[i].Cells[6].FindControl("ddl_LOT");
                            DropDownList box7 = (DropDownList)Gridview1.Rows[i].Cells[7].FindControl("ddl_PAC2");
                            DropDownList box8 = (DropDownList)Gridview1.Rows[i].Cells[8].FindControl("ddl_PAC3");
                            DropDownList box9 = (DropDownList)Gridview1.Rows[i].Cells[9].FindControl("ddl_AQF");

                            //Setting the SqlSources to the DDLs
                            box2.DataSourceID = "sql_GAOptionsPrimary";
                            box3.DataSourceID = "sql_GAOptions";
                            box4.DataSourceID = "sql_GAOptions";
                            box5.DataSourceID = "sql_PAC1";
                            box6.DataSourceID = "sql_LOT";
                            box7.DataSourceID = "sql_PAC2";
                            box8.DataSourceID = "sql_PAC3";
                            box9.DataSourceID = "sql_AQF";


                            //Setting the Values to the Controls
                            box1.Text = dt.Rows[i]["Question"].ToString();

                            box2.SelectedIndex = box2.Items.IndexOf(box2.Items.FindByText(dt.Rows[i]["PrimaryToGA"].ToString().Replace("\t", "")));
                            box3.SelectedIndex = box3.Items.IndexOf(box3.Items.FindByText(dt.Rows[i]["AlsoGA1"].ToString().Replace("\t", "")));
                            box4.SelectedIndex = box4.Items.IndexOf(box4.Items.FindByText(dt.Rows[i]["AlsoGA2"].ToString().Replace("\t", "")));
                            box5.SelectedIndex = box5.Items.IndexOf(box5.Items.FindByText(dt.Rows[i]["PAC1"].ToString().Replace("\t", "")));
                            box6.SelectedIndex = box6.Items.IndexOf(box6.Items.FindByText(dt.Rows[i]["LevelOfThinking"].ToString().Replace("\t", "")));
                            box7.SelectedIndex = box7.Items.IndexOf(box7.Items.FindByText(dt.Rows[i]["PAC2"].ToString().Replace("\t", "")));
                            box8.SelectedIndex = box8.Items.IndexOf(box8.Items.FindByText(dt.Rows[i]["PAC3"].ToString().Replace("\t", "")));
                            box9.SelectedIndex = box9.Items.IndexOf(box9.Items.FindByText(dt.Rows[i]["AQF"].ToString().Replace("\t", "")));


                            //Setting the Value to the Data Row 
                            drViewState["Question"] = box1.Text.Trim();
                            drViewState["PrimaryToGA"] = box2.SelectedIndex;
                            drViewState["AlsoGA1"] = box3.SelectedIndex;
                            drViewState["AlsoGA2"] = box4.SelectedIndex;
                            drViewState["PAC1"] = box5.SelectedIndex;
                            drViewState["LevelOfThinking"] = box6.SelectedIndex;
                            drViewState["PAC2"] = box7.SelectedIndex;
                            drViewState["PAC3"] = box8.SelectedIndex;
                            drViewState["AQF"] = box9.SelectedIndex;


                            //Adding the DataRow to the DataTable
                            dtViewState.Rows.Add(drViewState);

                        }
                    }
                }

                //Setting the DataTable to the ViewState
                ViewState["CurrentTable"] = dtViewState;

            }
            else
            {
                //Setting Up an Empty Row for Fresh Table.. No Copy Scenario
                dr = dt.NewRow();
                dr["RowNumber"] = Gridview1.Rows.Count + 1;
                dr["Question"] = string.Empty;
                dr["PrimaryToGA"] = string.Empty;
                dr["AlsoGA1"] = string.Empty;
                dr["AlsoGA2"] = string.Empty;
                dr["PAC1"] = string.Empty;
                dr["LevelOfThinking"] = string.Empty;
                dr["PAC2"] = string.Empty;
                dr["PAC3"] = string.Empty;
                dr["AQF"] = string.Empty;
                dt.Rows.Add(dr);


                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                //Setting up the DataSource of the GridView to the DataTable and Bind It
                Gridview1.DataSource = dt;
                Gridview1.DataBind();
            }
        }



        //Add New Row to the Grid with No Copy Scenario
        private void AddNewRowToULOGrid()
        {
            int rowIndex = 0;

            //If View State Not Null
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        TextBox box1 = (TextBox)Gridview1.Rows[rowIndex].Cells[1].FindControl("txt_Question");
                        DropDownList box2 = (DropDownList)Gridview1.Rows[rowIndex].Cells[2].FindControl("ddl_PTGA");
                        DropDownList box3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("ddl_AlsoGA1");
                        DropDownList box4 = (DropDownList)Gridview1.Rows[rowIndex].Cells[4].FindControl("ddl_AlsoGA2");
                        DropDownList box5 = (DropDownList)Gridview1.Rows[rowIndex].Cells[5].FindControl("ddl_PAC1");
                        DropDownList box6 = (DropDownList)Gridview1.Rows[rowIndex].Cells[6].FindControl("ddl_LOT");
                        DropDownList box7 = (DropDownList)Gridview1.Rows[rowIndex].Cells[7].FindControl("ddl_PAC2");
                        DropDownList box8 = (DropDownList)Gridview1.Rows[rowIndex].Cells[8].FindControl("ddl_PAC3");
                        DropDownList box9 = (DropDownList)Gridview1.Rows[rowIndex].Cells[9].FindControl("ddl_AQF");

                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i + 1;
                        drCurrentRow["Question"] = box1.Text;
                        drCurrentRow["PrimaryToGA"] = box2.SelectedIndex;
                        drCurrentRow["AlsoGA1"] = box3.SelectedIndex;
                        drCurrentRow["AlsoGA2"] = box4.SelectedIndex;
                        drCurrentRow["PAC1"] = box5.SelectedIndex;
                        drCurrentRow["LevelOfThinking"] = box6.SelectedIndex;
                        drCurrentRow["PAC2"] = box7.SelectedIndex;
                        drCurrentRow["PAC3"] = box8.SelectedIndex;
                        drCurrentRow["AQF"] = box9.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    //Rebind the Grid with the current data
                    Gridview1.DataSource = dtCurrentTable;
                    Gridview1.DataBind();
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousULOData();
        }


        //Setting Previous ViewState Info to the Dynamic GridView for No Copy Scenario
        private void SetPreviousULOData()
        {
            int rowIndex = 0;

            //Checking if ViewState is Null
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];

                if (dt.Rows.Count > 0)
                {
                    for (int i = 1; i < (dt.Rows.Count); i++)
                    {
                        TextBox box1 = (TextBox)Gridview1.Rows[rowIndex].Cells[1].FindControl("txt_Question");
                        DropDownList box2 = (DropDownList)Gridview1.Rows[rowIndex].Cells[2].FindControl("ddl_PTGA");
                        DropDownList box3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("ddl_AlsoGA1");
                        DropDownList box4 = (DropDownList)Gridview1.Rows[rowIndex].Cells[4].FindControl("ddl_AlsoGA2");
                        DropDownList box5 = (DropDownList)Gridview1.Rows[rowIndex].Cells[5].FindControl("ddl_PAC1");
                        DropDownList box6 = (DropDownList)Gridview1.Rows[rowIndex].Cells[6].FindControl("ddl_LOT");
                        DropDownList box7 = (DropDownList)Gridview1.Rows[rowIndex].Cells[7].FindControl("ddl_PAC2");
                        DropDownList box8 = (DropDownList)Gridview1.Rows[rowIndex].Cells[8].FindControl("ddl_PAC3");
                        DropDownList box9 = (DropDownList)Gridview1.Rows[rowIndex].Cells[9].FindControl("ddl_AQF");


                        //Setting the Values to the Controls
                        box1.Text = dt.Rows[i]["Question"].ToString();
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PrimaryToGA"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoGA1"].ToString());
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoGA2"].ToString());
                        box5.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC1"].ToString());
                        box6.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LevelOfThinking"].ToString());
                        box7.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC2"].ToString());
                        box8.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC3"].ToString());
                        box9.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AQF"].ToString());

                        rowIndex++;
                    }
                }
            }
        }



        //Add New Row to the Grid
        private void AddNewRowToULOGridMultiple()
        {

            DataTable dtCurrentTable = null;
            int rowIndex = 0;

            //Checking for View State State
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                dtCurrentTable = (DataTable)ViewState["CurrentTable"];

                //Using the Hack to Remove the Extra Blank row added to avoid the out of Index Exception 
                dtCurrentTable.Rows.RemoveAt(dtCurrentTable.Rows.Count - 1);

                DataRow drCurrentRow = null;
                int i = 1;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (i = 1; i <= dtCurrentTable.Rows.Count + 1; i++)
                    {
                        //if (i != 8)
                        {
                            TextBox box1 = (TextBox)Gridview1.Rows[rowIndex].Cells[1].FindControl("txt_Question");
                            DropDownList box2 = (DropDownList)Gridview1.Rows[rowIndex].Cells[2].FindControl("ddl_PTGA");
                            DropDownList box3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("ddl_AlsoGA1");
                            DropDownList box4 = (DropDownList)Gridview1.Rows[rowIndex].Cells[4].FindControl("ddl_AlsoGA2");
                            DropDownList box5 = (DropDownList)Gridview1.Rows[rowIndex].Cells[5].FindControl("ddl_PAC1");
                            DropDownList box6 = (DropDownList)Gridview1.Rows[rowIndex].Cells[6].FindControl("ddl_LOT");
                            DropDownList box7 = (DropDownList)Gridview1.Rows[rowIndex].Cells[7].FindControl("ddl_PAC2");
                            DropDownList box8= (DropDownList)Gridview1.Rows[rowIndex].Cells[8].FindControl("ddl_PAC3");
                            DropDownList box9 = (DropDownList)Gridview1.Rows[rowIndex].Cells[9].FindControl("ddl_AQF");

                            drCurrentRow = dtCurrentTable.NewRow();

                            //Just for the Row Count
                            //drCurrentRow["RowNumber"] = i + 1;
                            drCurrentRow["RowNumber"] = i;
                            drCurrentRow["Question"] = box1.Text;
                            drCurrentRow["PrimaryToGA"] = box2.SelectedIndex;
                            drCurrentRow["AlsoGA1"] = box3.SelectedIndex;
                            drCurrentRow["AlsoGA2"] = box4.SelectedIndex;
                            drCurrentRow["PAC1"] = box5.SelectedIndex;
                            drCurrentRow["LevelOfThinking"] = box6.SelectedIndex;
                            drCurrentRow["PAC2"] = box7.SelectedIndex;
                            drCurrentRow["PAC3"] = box8.SelectedIndex;
                            drCurrentRow["AQF"] = box9.SelectedIndex;
                        }
                        rowIndex++;
                    }

                    //Add new row to DataTable
                    //if(i!=9)
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Setting Up an Empty Row
                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = Gridview1.Rows.Count + 1;
                    drCurrentRow["Question"] = string.Empty;
                    drCurrentRow["PrimaryToGA"] = "0";
                    drCurrentRow["AlsoGA1"] = "0";
                    drCurrentRow["AlsoGA2"] = "0";
                    drCurrentRow["PAC1"] = "0";
                    drCurrentRow["LevelOfThinking"] = "0";
                    drCurrentRow["PAC2"] = "0";
                    drCurrentRow["PAC3"] = "0";
                    drCurrentRow["AQF"] = "0";

                    dtCurrentTable.Rows.Add(drCurrentRow);



                    //Rebind the Grid with the current data
                    Gridview1.DataSource = dtCurrentTable;
                    Gridview1.DataBind();


                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                }
            }

            //Set Previous Data on Postbacks
            SetPreviousULODataMultiple();
        }


        //Setting the Data from the ViewState in the Table
        private void SetPreviousULODataMultiple()
        {
            int rowIndex = 0;

            //Cheking If ViewState is Null
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];

                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < (dt.Rows.Count); i++)
                    {
                        TextBox box1 = (TextBox)Gridview1.Rows[rowIndex].Cells[1].FindControl("txt_Question");
                        DropDownList box2 = (DropDownList)Gridview1.Rows[rowIndex].Cells[2].FindControl("ddl_PTGA");
                        DropDownList box3 = (DropDownList)Gridview1.Rows[rowIndex].Cells[3].FindControl("ddl_AlsoGA1");
                        DropDownList box4 = (DropDownList)Gridview1.Rows[rowIndex].Cells[4].FindControl("ddl_AlsoGA2");
                        DropDownList box5 = (DropDownList)Gridview1.Rows[rowIndex].Cells[5].FindControl("ddl_PAC1");
                        DropDownList box6 = (DropDownList)Gridview1.Rows[rowIndex].Cells[6].FindControl("ddl_LOT");
                        DropDownList box7 = (DropDownList)Gridview1.Rows[rowIndex].Cells[7].FindControl("ddl_PAC2");
                        DropDownList box8 = (DropDownList)Gridview1.Rows[rowIndex].Cells[8].FindControl("ddl_PAC3");
                        DropDownList box9 = (DropDownList)Gridview1.Rows[rowIndex].Cells[9].FindControl("ddl_AQF");

                        //Setting the Values to the TextBoxes
                        box1.Text = dt.Rows[i]["Question"].ToString();
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PrimaryToGA"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoGA1"].ToString());
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoGA2"].ToString());
                        box5.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC1"].ToString());
                        box6.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LevelOfThinking"].ToString());
                        box7.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC2"].ToString());
                        box8.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PAC3"].ToString());
                        box9.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AQF"].ToString());

                        rowIndex++;

                    }
                }
            }
        }



        //Filling the ULO Textboxes and DropDowns with Copy Form Data... Only of Copy=1 and CopyForm has a Valid Form Id
        public DataTable fillingULOTableWithCopyData()
        {
            DataTable ULOdt = new DataTable();

            //Setting Up the Columns for the GridView
            ULOdt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("Question", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("LevelOfThinking", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PrimaryToGA", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("AlsoGA1", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("AlsoGA2", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PAC1", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PAC2", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PAC3", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("AQF", typeof(string)));


            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(copyFrom));

            //Filtering the UnitLearning Outcome Mapping Values
            var ULOList = from CourseAttributeOptionMapping mapping in list
                          where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Unit learning outcomes (ULOs) table").Id)
                          select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in ULOList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }

            int index = 1;
            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in ULOList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Typecasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = ULOdt.NewRow();
                dr[0] = index++;
                dr[1] = question;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Level of Thinking").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(" primarily to GA").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also GA1 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also GA2 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[5] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(hf_pac1.Value).Id).Equals(tempOpt.Id))
                    {
                        dr[6] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(hf_pac2.Value).Id).Equals(tempOpt.Id))
                    {
                        dr[7] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(hf_pac3.Value).Id).Equals(tempOpt.Id))
                    {
                        dr[8] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(hf_aqf.Value).Id).Equals(tempOpt.Id))
                    {
                        dr[9] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                ULOdt.Rows.Add(dr);
            }

            return ULOdt;
        }



        //ButtonAddEvent to all Dynamic Rows to the Grid
        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToULOGrid();
        }



        //ButtonAddMultiple Event to all Dynamic Rows to the Grid
        protected void ButtonAddMultiple_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToULOGridMultiple();
        }



        //Save Values to the Database
        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            CourseAttributeOptionMapping mapping = null;

            //Iterating through all the Rows in the GridView
            foreach (GridViewRow row in Gridview1.Rows)
            {
                //Fetching the Values out of the Controls
                TextBox Question = (TextBox)row.FindControl("txt_Question");
                DropDownList primaryToGA = (DropDownList)row.FindControl("ddl_PTGA");
                DropDownList AlsoGA1 = (DropDownList)row.FindControl("ddl_AlsoGA1");
                DropDownList AlsoGA2 = (DropDownList)row.FindControl("ddl_AlsoGA2");
                DropDownList PAC1 = (DropDownList)row.FindControl("ddl_PAC1");
                DropDownList LOT = (DropDownList)row.FindControl("ddl_LOT");
                DropDownList PAC2 = (DropDownList)row.FindControl("ddl_PAC2");
                DropDownList PAC3 = (DropDownList)row.FindControl("ddl_PAC3");
                DropDownList AQF = (DropDownList)row.FindControl("ddl_AQF");

                //If the Question is Blank Skip that Question
                if (!Question.Text.Trim().Equals(""))
                {
                    //Getting the Question
                    string question = Question.Text.Trim();

                    //Getting the Sequence Number
                    string sequencenumber = row.Cells[0].Text;

                    //Gettign the Specification Attribute
                    int specificationAttributeId = new SpecificationAttribute("Unit learning outcomes (ULOs) table").Id;

                    //HashMap Created for the SpecificationAttributeOption and the KeyValuePairId selected.
                    Dictionary<int, int> specificationOptionAndValuePair = new Dictionary<int, int>();
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Level of Thinking").Id, Convert.ToInt32(LOT.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption(" primarily to GA").Id, Convert.ToInt32(primaryToGA.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("also GA1 (optional)").Id, Convert.ToInt32(AlsoGA1.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("also GA2 (optional)").Id, Convert.ToInt32(AlsoGA2.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption(hf_pac1.Value).Id, Convert.ToInt32(PAC1.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption(hf_pac2.Value).Id, Convert.ToInt32(PAC2.SelectedItem.Value.Trim()));
                    if (!(hf_pac3.Value.Equals("NONE")))
                    {
                        specificationOptionAndValuePair.Add(new SpecificationAttributeOption(hf_pac3.Value).Id, Convert.ToInt32(PAC3.SelectedItem.Value.Trim()));
                    }
                    
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption(hf_aqf.Value).Id, Convert.ToInt32(AQF.SelectedItem.Value.Trim()));

                    //Iterating through all the KeyPairs and Adding a Record in the Mapping Table
                    foreach (KeyValuePair<int, int> pair in specificationOptionAndValuePair)
                    {
                        int specificationAttributeOptionId = pair.Key;
                        int specificationAttributeOptionKeyValueId = pair.Value;

                        //Create a New Mapping Object
                        mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), question, new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(specificationAttributeOptionKeyValueId), "NONE");


                        //Checking If Its an Edit
                        if (copyFrom == offeringId)
                        {
                            //Updating a New Record for a Mapping
                            mapping.EditMapping(Convert.ToInt32(sequencenumber), offeringId);
                        }
                        else
                        {
                            //Inserting a New Record for a Mapping
                            mapping.CreateNewMapping(Convert.ToInt32(sequencenumber));
                        }
                    }
                }
            }


            //If Edit Operation is performed
            if (copyFrom == offeringId)
            {
                CourseAttributeOptionMapping.FireEdit(mapping.SpecificationAttribute.Id, offeringId);
            }



            //Resetting the View State
            ViewState["CurrentTable"] = null;

            ////Update the Status of the form to "Edited"
            //CourseOffering coffering = new CourseOffering(offeringId);
            //FormStatus createStatus = new FormStatus('E');
            //MyForm form = new MyForm(coffering, createStatus, DateTime.Now, "");
            //form.CreateNewForm();

            //Setting Initial Row For Assessment Tasks
            SetInitialRowAssessmentTasks();
        }


        //Table ASSESSMENT TASKS//
        //-----------------------------------------------------------------------------------------------------------------------//


        //Setting Up the Initial Row in the Assessment Tasks
        private void SetInitialRowAssessmentTasks()
        {
            ButtonAddAssessment.Visible = true;
            ButtonAddAssessmentMultiple.Visible = false;


            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            //Temporary Object for DataRow
            DataRow dr = null;

            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("AssessmentTask", typeof(string)));
            dt.Columns.Add(new DataColumn("Weighting", typeof(string)));
            dt.Columns.Add(new DataColumn("DueDate", typeof(string)));
            dt.Columns.Add(new DataColumn("PrimaryToULO", typeof(string)));
            dt.Columns.Add(new DataColumn("AlsoULO1", typeof(string)));
            dt.Columns.Add(new DataColumn("AlsoULO2", typeof(string)));
            dt.Columns.Add(new DataColumn("Type", typeof(string)));
            dt.Columns.Add(new DataColumn("Medium", typeof(string)));
            dt.Columns.Add(new DataColumn("Format", typeof(string)));
            dt.Columns.Add(new DataColumn("Role", typeof(string)));
            dt.Columns.Add(new DataColumn("Authenticity", typeof(string)));
            dt.Columns.Add(new DataColumn("Supervision", typeof(string)));
            dt.Columns.Add(new DataColumn("Mode", typeof(string)));
            dt.Columns.Add(new DataColumn("Assessors", typeof(string)));
            dt.Columns.Add(new DataColumn("Purpose", typeof(string)));


            if (copy == 1)
            {
                ButtonAddAssessment.Visible = false;
                ButtonAddAssessmentMultiple.Visible = true;

                //Temporary DataTable to Convert Text to Ddl Indexes
                DataTable dtViewState = new DataTable();
                DataRow drViewState;

                //Setting Up the Columns for the GridView
                dtViewState.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AssessmentTask", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Weighting", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("DueDate", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("PrimaryToULO", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AlsoULO1", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("AlsoULO2", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Type", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Medium", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Format", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Role", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Authenticity", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Supervision", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Mode", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Assessors", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Purpose", typeof(string)));


                //Getting the Values of the Assessment table from the Copy Form Source 
                if ((dt = fillingAssessmentTableWithCopyData()) != null)
                {
                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["AssessmentTask"] = string.Empty;
                    dr["Weighting"] = string.Empty;
                    dr["DueDate"] = string.Empty;
                    dr["PrimaryToULO"] = string.Empty;
                    dr["AlsoULO1"] = string.Empty;
                    dr["AlsoULO2"] = string.Empty;
                    dr["Type"] = string.Empty;
                    dr["Medium"] = string.Empty;
                    dr["Format"] = string.Empty;
                    dr["Role"] = string.Empty;
                    dr["Authenticity"] = string.Empty;
                    dr["Supervision"] = string.Empty;
                    dr["Mode"] = string.Empty;
                    dr["Assessors"] = string.Empty;
                    dr["Purpose"] = string.Empty;

                    dt.Rows.Add(dr);

                    //Adding an Empty Row at the End, after the Copied Values
                    Gridview2.DataSource = dt;
                    Gridview2.DataBind();


                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1; ;
                    dr["AssessmentTask"] = string.Empty;
                    dr["Weighting"] = string.Empty;
                    dr["DueDate"] = string.Empty;
                    dr["PrimaryToULO"] = string.Empty;
                    dr["AlsoULO1"] = string.Empty;
                    dr["AlsoULO2"] = string.Empty;
                    dr["Type"] = string.Empty;
                    dr["Medium"] = string.Empty;
                    dr["Format"] = string.Empty;
                    dr["Role"] = string.Empty;
                    dr["Authenticity"] = string.Empty;
                    dr["Supervision"] = string.Empty;
                    dr["Mode"] = string.Empty;
                    dr["Assessors"] = string.Empty;
                    dr["Purpose"] = string.Empty;

                    dt.Rows.Add(dr);



                    //Iterating through all the Rows..to set the Data of the Copy Form Source to the GridView
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < (dt.Rows.Count - 1); i++)
                        {
                            drViewState = dtViewState.NewRow();
                            drViewState["RowNumber"] = i + 1;

                            TextBox box1 = (TextBox)Gridview2.Rows[i].Cells[1].FindControl("txt_AssessmentQuestion");
                            TextBox box2 = (TextBox)Gridview2.Rows[i].Cells[2].FindControl("txt_Weighting");
                            TextBox box3 = (TextBox)Gridview2.Rows[i].Cells[3].FindControl("txt_DueWeek");
                            DropDownList box4 = (DropDownList)Gridview2.Rows[i].Cells[4].FindControl("ddl_PULO");
                            DropDownList box5 = (DropDownList)Gridview2.Rows[i].Cells[5].FindControl("ddl_AlsoULO1");
                            DropDownList box6 = (DropDownList)Gridview2.Rows[i].Cells[6].FindControl("ddl_AlsoULO2");
                            DropDownList box7 = (DropDownList)Gridview2.Rows[i].Cells[7].FindControl("ddl_Type");
                            DropDownList box8 = (DropDownList)Gridview2.Rows[i].Cells[8].FindControl("ddl_Medium");
                            DropDownList box9 = (DropDownList)Gridview2.Rows[i].Cells[9].FindControl("ddl_Format");
                            DropDownList box10 = (DropDownList)Gridview2.Rows[i].Cells[10].FindControl("ddl_Role");
                            DropDownList box11 = (DropDownList)Gridview2.Rows[i].Cells[11].FindControl("ddl_Authenticity");
                            DropDownList box12 = (DropDownList)Gridview2.Rows[i].Cells[12].FindControl("ddl_Supervision");
                            DropDownList box13 = (DropDownList)Gridview2.Rows[i].Cells[13].FindControl("ddl_Mode");
                            DropDownList box14 = (DropDownList)Gridview2.Rows[i].Cells[14].FindControl("ddl_Assessors");
                            DropDownList box15 = (DropDownList)Gridview2.Rows[i].Cells[15].FindControl("ddl_Purpose");


                            //Setting the SqlSources to the DDLs
                            box4.DataSourceID = "ods_GetAllOfferingIds";
                            box5.DataSourceID = "ods_GetAllOfferingIds";
                            box6.DataSourceID = "ods_GetAllOfferingIds";
                            box7.DataSourceID = "sql_Type";
                            box8.DataSourceID = "sql_Medium";
                            box9.DataSourceID = "sql_Format";
                            box10.DataSourceID = "sql_Role";
                            box11.DataSourceID = "sql_Authenticity";
                            box12.DataSourceID = "sql_Supervision";
                            box13.DataSourceID = "sql_Mode";
                            box14.DataSourceID = "sql_Assessors";
                            box15.DataSourceID = "sql_Purpose";

                            //Setting the Values to the Controls
                            box1.Text = dt.Rows[i]["AssessmentTask"].ToString();
                            box2.Text = dt.Rows[i]["Weighting"].ToString();
                            box3.Text = dt.Rows[i]["DueDate"].ToString();

                            box4.SelectedIndex = box4.Items.IndexOf(box4.Items.FindByText(dt.Rows[i]["PrimaryToULO"].ToString().Replace("\t", "")));
                            box5.SelectedIndex = box5.Items.IndexOf(box5.Items.FindByText(dt.Rows[i]["AlsoULO1"].ToString().Replace("\t", "")));
                            box6.SelectedIndex = box6.Items.IndexOf(box6.Items.FindByText(dt.Rows[i]["AlsoULO2"].ToString().Replace("\t", "")));
                            box7.SelectedIndex = box7.Items.IndexOf(box7.Items.FindByText(dt.Rows[i]["Type"].ToString().Replace("\t", "")));
                            box8.SelectedIndex = box8.Items.IndexOf(box8.Items.FindByText(dt.Rows[i]["Medium"].ToString().Replace("\t", "")));
                            box9.SelectedIndex = box9.Items.IndexOf(box9.Items.FindByText(dt.Rows[i]["Format"].ToString().Replace("\t", "")));
                            box10.SelectedIndex = box10.Items.IndexOf(box10.Items.FindByText(dt.Rows[i]["Role"].ToString().Replace("\t", "")));
                            box11.SelectedIndex = box11.Items.IndexOf(box11.Items.FindByText(dt.Rows[i]["Authenticity"].ToString().Replace("\t", "")));
                            box12.SelectedIndex = box12.Items.IndexOf(box12.Items.FindByText(dt.Rows[i]["Supervision"].ToString().Replace("\t", "")));
                            box13.SelectedIndex = box13.Items.IndexOf(box13.Items.FindByText(dt.Rows[i]["Mode"].ToString().Replace("\t", "")));
                            box14.SelectedIndex = box14.Items.IndexOf(box14.Items.FindByText(dt.Rows[i]["Assessors"].ToString().Replace("\t", "")));
                            box15.SelectedIndex = box15.Items.IndexOf(box15.Items.FindByText(dt.Rows[i]["Purpose"].ToString().Replace("\t", "")));




                            drViewState["AssessmentTask"] = box1.Text.Trim();
                            drViewState["Weighting"] = box2.Text.Trim();
                            drViewState["DueDate"] = box3.Text.Trim();
                            drViewState["PrimaryToULO"] = box4.SelectedIndex;
                            drViewState["AlsoULO1"] = box5.SelectedIndex;
                            drViewState["AlsoULO2"] = box6.SelectedIndex;
                            drViewState["Type"] = box7.SelectedIndex;
                            drViewState["Medium"] = box8.SelectedIndex;
                            drViewState["Format"] = box9.SelectedIndex;
                            drViewState["Role"] = box10.SelectedIndex;
                            drViewState["Authenticity"] = box11.SelectedIndex;
                            drViewState["Supervision"] = box12.SelectedIndex;
                            drViewState["Mode"] = box13.SelectedIndex;
                            drViewState["Assessors"] = box14.SelectedIndex;
                            drViewState["Purpose"] = box15.SelectedIndex;



                            dtViewState.Rows.Add(drViewState);

                        }
                    }

                }

                //Setting the DataTable to the ViewState
                ViewState["CurrentTable"] = dtViewState;

            }
            else
            {
                //Setting Up an Empty Row
                dr = dt.NewRow();
                dr["RowNumber"] = Gridview2.Rows.Count + 1;
                dr["AssessmentTask"] = string.Empty;
                dr["Weighting"] = string.Empty;
                dr["DueDate"] = string.Empty;
                dr["PrimaryToULO"] = string.Empty;
                dr["AlsoULO1"] = string.Empty;
                dr["AlsoULO2"] = string.Empty;
                dr["Type"] = string.Empty;
                dr["Medium"] = string.Empty;
                dr["Format"] = string.Empty;
                dr["Role"] = string.Empty;
                dr["Authenticity"] = string.Empty;
                dr["Supervision"] = string.Empty;
                dr["Mode"] = string.Empty;
                dr["Assessors"] = string.Empty;
                dr["Purpose"] = string.Empty;

                dt.Rows.Add(dr);

                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                //Setting up the DataSource of the GridView to the DataTable and Bind It
                Gridview2.DataSource = dt;
                Gridview2.DataBind();
            }
        }


        //Add New Row to the Grid Assessment Tasks
        private void AddNewRowToAssessmentTasksGrid()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        TextBox box1 = (TextBox)Gridview2.Rows[rowIndex].Cells[1].FindControl("txt_AssessmentQuestion");
                        TextBox box2 = (TextBox)Gridview2.Rows[rowIndex].Cells[2].FindControl("txt_Weighting");
                        TextBox box3 = (TextBox)Gridview2.Rows[rowIndex].Cells[3].FindControl("txt_DueWeek");
                        DropDownList box4 = (DropDownList)Gridview2.Rows[rowIndex].Cells[4].FindControl("ddl_PULO");
                        DropDownList box5 = (DropDownList)Gridview2.Rows[rowIndex].Cells[5].FindControl("ddl_AlsoULO1");
                        DropDownList box6 = (DropDownList)Gridview2.Rows[rowIndex].Cells[6].FindControl("ddl_AlsoULO2");
                        DropDownList box7 = (DropDownList)Gridview2.Rows[rowIndex].Cells[7].FindControl("ddl_Type");
                        DropDownList box8 = (DropDownList)Gridview2.Rows[rowIndex].Cells[8].FindControl("ddl_Medium");
                        DropDownList box9 = (DropDownList)Gridview2.Rows[rowIndex].Cells[9].FindControl("ddl_Format");
                        DropDownList box10 = (DropDownList)Gridview2.Rows[rowIndex].Cells[10].FindControl("ddl_Role");
                        DropDownList box11 = (DropDownList)Gridview2.Rows[rowIndex].Cells[11].FindControl("ddl_Authenticity");
                        DropDownList box12 = (DropDownList)Gridview2.Rows[rowIndex].Cells[12].FindControl("ddl_Supervision");
                        DropDownList box13 = (DropDownList)Gridview2.Rows[rowIndex].Cells[13].FindControl("ddl_Mode");
                        DropDownList box14 = (DropDownList)Gridview2.Rows[rowIndex].Cells[14].FindControl("ddl_Assessors");
                        DropDownList box15 = (DropDownList)Gridview2.Rows[rowIndex].Cells[15].FindControl("ddl_Purpose");

                        drCurrentRow = dtCurrentTable.NewRow();

                        drCurrentRow["RowNumber"] = i + 1;
                        drCurrentRow["AssessmentTask"] = box1.Text.Trim();
                        drCurrentRow["Weighting"] = box2.Text.Trim();
                        drCurrentRow["DueDate"] = box3.Text.Trim();
                        drCurrentRow["PrimaryToULO"] = box4.SelectedIndex;
                        drCurrentRow["AlsoULO1"] = box5.SelectedIndex;
                        drCurrentRow["AlsoULO2"] = box6.SelectedIndex;
                        drCurrentRow["Type"] = box7.SelectedIndex;
                        drCurrentRow["Medium"] = box8.SelectedIndex;
                        drCurrentRow["Format"] = box9.SelectedIndex;
                        drCurrentRow["Role"] = box10.SelectedIndex;
                        drCurrentRow["Authenticity"] = box11.SelectedIndex;
                        drCurrentRow["Supervision"] = box12.SelectedIndex;
                        drCurrentRow["Mode"] = box13.SelectedIndex;
                        drCurrentRow["Assessors"] = box14.SelectedIndex;
                        drCurrentRow["Purpose"] = box15.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    //Rebind the Grid with the current data
                    Gridview2.DataSource = dtCurrentTable;
                    Gridview2.DataBind();
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousAssessmentTasksData();
        }



        //Setting the Data from the ViewState in the Table
        private void SetPreviousAssessmentTasksData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 1; i < dt.Rows.Count; i++)
                    {
                        TextBox box1 = (TextBox)Gridview2.Rows[rowIndex].Cells[1].FindControl("txt_AssessmentQuestion");
                        TextBox box2 = (TextBox)Gridview2.Rows[rowIndex].Cells[2].FindControl("txt_Weighting");
                        TextBox box3 = (TextBox)Gridview2.Rows[rowIndex].Cells[3].FindControl("txt_DueWeek");
                        DropDownList box4 = (DropDownList)Gridview2.Rows[rowIndex].Cells[4].FindControl("ddl_PULO");
                        DropDownList box5 = (DropDownList)Gridview2.Rows[rowIndex].Cells[5].FindControl("ddl_AlsoULO1");
                        DropDownList box6 = (DropDownList)Gridview2.Rows[rowIndex].Cells[6].FindControl("ddl_AlsoULO2");
                        DropDownList box7 = (DropDownList)Gridview2.Rows[rowIndex].Cells[7].FindControl("ddl_Type");
                        DropDownList box8 = (DropDownList)Gridview2.Rows[rowIndex].Cells[8].FindControl("ddl_Medium");
                        DropDownList box9 = (DropDownList)Gridview2.Rows[rowIndex].Cells[9].FindControl("ddl_Format");
                        DropDownList box10 = (DropDownList)Gridview2.Rows[rowIndex].Cells[10].FindControl("ddl_Role");
                        DropDownList box11 = (DropDownList)Gridview2.Rows[rowIndex].Cells[11].FindControl("ddl_Authenticity");
                        DropDownList box12 = (DropDownList)Gridview2.Rows[rowIndex].Cells[12].FindControl("ddl_Supervision");
                        DropDownList box13 = (DropDownList)Gridview2.Rows[rowIndex].Cells[13].FindControl("ddl_Mode");
                        DropDownList box14 = (DropDownList)Gridview2.Rows[rowIndex].Cells[14].FindControl("ddl_Assessors");
                        DropDownList box15 = (DropDownList)Gridview2.Rows[rowIndex].Cells[15].FindControl("ddl_Purpose");

                        box1.Text = dt.Rows[i]["AssessmentTask"].ToString();
                        box2.Text = dt.Rows[i]["Weighting"].ToString();
                        box3.Text = dt.Rows[i]["DueDate"].ToString();
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PrimaryToULO"].ToString());
                        box5.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoULO1"].ToString());
                        box6.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoULO2"].ToString());
                        box7.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Type"].ToString());
                        box8.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Medium"].ToString());
                        box9.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Format"].ToString());
                        box10.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Role"].ToString());
                        box11.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Authenticity"].ToString());
                        box12.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Supervision"].ToString());
                        box13.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Mode"].ToString());
                        box14.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Assessors"].ToString());
                        box15.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Purpose"].ToString());

                        rowIndex++;
                    }
                }
            }
        }



        //Add New Row to the Grid Assessment Tasks
        private void AddNewRowToAssessmentTasksGridMultiple()
        {
            DataTable dtCurrentTable = null;
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                dtCurrentTable = (DataTable)ViewState["CurrentTable"];

                //Using the Hack to Remove the Extra Blank row added to avoid the out of Index Exception 
                dtCurrentTable.Rows.RemoveAt(dtCurrentTable.Rows.Count - 1);


                DataRow drCurrentRow = null;

                int i = 1;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (i = 1; i <= dtCurrentTable.Rows.Count + 1; i++)
                    {
                        TextBox box1 = (TextBox)Gridview2.Rows[rowIndex].Cells[1].FindControl("txt_AssessmentQuestion");
                        TextBox box2 = (TextBox)Gridview2.Rows[rowIndex].Cells[2].FindControl("txt_Weighting");
                        TextBox box3 = (TextBox)Gridview2.Rows[rowIndex].Cells[3].FindControl("txt_DueWeek");
                        DropDownList box4 = (DropDownList)Gridview2.Rows[rowIndex].Cells[4].FindControl("ddl_PULO");
                        DropDownList box5 = (DropDownList)Gridview2.Rows[rowIndex].Cells[5].FindControl("ddl_AlsoULO1");
                        DropDownList box6 = (DropDownList)Gridview2.Rows[rowIndex].Cells[6].FindControl("ddl_AlsoULO2");
                        DropDownList box7 = (DropDownList)Gridview2.Rows[rowIndex].Cells[7].FindControl("ddl_Type");
                        DropDownList box8 = (DropDownList)Gridview2.Rows[rowIndex].Cells[8].FindControl("ddl_Medium");
                        DropDownList box9 = (DropDownList)Gridview2.Rows[rowIndex].Cells[9].FindControl("ddl_Format");
                        DropDownList box10 = (DropDownList)Gridview2.Rows[rowIndex].Cells[10].FindControl("ddl_Role");
                        DropDownList box11 = (DropDownList)Gridview2.Rows[rowIndex].Cells[11].FindControl("ddl_Authenticity");
                        DropDownList box12 = (DropDownList)Gridview2.Rows[rowIndex].Cells[12].FindControl("ddl_Supervision");
                        DropDownList box13 = (DropDownList)Gridview2.Rows[rowIndex].Cells[13].FindControl("ddl_Mode");
                        DropDownList box14 = (DropDownList)Gridview2.Rows[rowIndex].Cells[14].FindControl("ddl_Assessors");
                        DropDownList box15 = (DropDownList)Gridview2.Rows[rowIndex].Cells[15].FindControl("ddl_Purpose");

                        drCurrentRow = dtCurrentTable.NewRow();

                        drCurrentRow["RowNumber"] = i;
                        drCurrentRow["AssessmentTask"] = box1.Text.Trim();
                        drCurrentRow["Weighting"] = box2.Text.Trim();
                        drCurrentRow["DueDate"] = box3.Text.Trim();
                        drCurrentRow["PrimaryToULO"] = box4.SelectedIndex;
                        drCurrentRow["AlsoULO1"] = box5.SelectedIndex;
                        drCurrentRow["AlsoULO2"] = box6.SelectedIndex;
                        drCurrentRow["Type"] = box7.SelectedIndex;
                        drCurrentRow["Medium"] = box8.SelectedIndex;
                        drCurrentRow["Format"] = box9.SelectedIndex;
                        drCurrentRow["Role"] = box10.SelectedIndex;
                        drCurrentRow["Authenticity"] = box11.SelectedIndex;
                        drCurrentRow["Supervision"] = box12.SelectedIndex;
                        drCurrentRow["Mode"] = box13.SelectedIndex;
                        drCurrentRow["Assessors"] = box14.SelectedIndex;
                        drCurrentRow["Purpose"] = box15.SelectedIndex;

                        rowIndex++;
                    }

                    dtCurrentTable.Rows.Add(drCurrentRow);



                    drCurrentRow = dtCurrentTable.NewRow();

                    drCurrentRow["RowNumber"] = Gridview2.Rows.Count + 1;
                    drCurrentRow["AssessmentTask"] = string.Empty;
                    drCurrentRow["Weighting"] = string.Empty;
                    drCurrentRow["DueDate"] = string.Empty;
                    drCurrentRow["PrimaryToULO"] = "0";
                    drCurrentRow["AlsoULO1"] = "0";
                    drCurrentRow["AlsoULO2"] = "0";
                    drCurrentRow["Type"] = "0";
                    drCurrentRow["Medium"] = "0";
                    drCurrentRow["Format"] = "0";
                    drCurrentRow["Role"] = "0";
                    drCurrentRow["Authenticity"] = "0";
                    drCurrentRow["Supervision"] = "0";
                    drCurrentRow["Mode"] = "0";
                    drCurrentRow["Assessors"] = "0";
                    drCurrentRow["Purpose"] = "0";




                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);



                    //Rebind the Grid with the current data
                    Gridview2.DataSource = dtCurrentTable;
                    Gridview2.DataBind();

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousAssessmentTasksDataMultiple();
        }


        //Setting the Data from the ViewState in the Table
        private void SetPreviousAssessmentTasksDataMultiple()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TextBox box1 = (TextBox)Gridview2.Rows[rowIndex].Cells[1].FindControl("txt_AssessmentQuestion");
                        TextBox box2 = (TextBox)Gridview2.Rows[rowIndex].Cells[2].FindControl("txt_Weighting");
                        TextBox box3 = (TextBox)Gridview2.Rows[rowIndex].Cells[3].FindControl("txt_DueWeek");
                        DropDownList box4 = (DropDownList)Gridview2.Rows[rowIndex].Cells[4].FindControl("ddl_PULO");
                        DropDownList box5 = (DropDownList)Gridview2.Rows[rowIndex].Cells[5].FindControl("ddl_AlsoULO1");
                        DropDownList box6 = (DropDownList)Gridview2.Rows[rowIndex].Cells[6].FindControl("ddl_AlsoULO2");
                        DropDownList box7 = (DropDownList)Gridview2.Rows[rowIndex].Cells[7].FindControl("ddl_Type");
                        DropDownList box8 = (DropDownList)Gridview2.Rows[rowIndex].Cells[8].FindControl("ddl_Medium");
                        DropDownList box9 = (DropDownList)Gridview2.Rows[rowIndex].Cells[9].FindControl("ddl_Format");
                        DropDownList box10 = (DropDownList)Gridview2.Rows[rowIndex].Cells[10].FindControl("ddl_Role");
                        DropDownList box11 = (DropDownList)Gridview2.Rows[rowIndex].Cells[11].FindControl("ddl_Authenticity");
                        DropDownList box12 = (DropDownList)Gridview2.Rows[rowIndex].Cells[12].FindControl("ddl_Supervision");
                        DropDownList box13 = (DropDownList)Gridview2.Rows[rowIndex].Cells[13].FindControl("ddl_Mode");
                        DropDownList box14 = (DropDownList)Gridview2.Rows[rowIndex].Cells[14].FindControl("ddl_Assessors");
                        DropDownList box15 = (DropDownList)Gridview2.Rows[rowIndex].Cells[15].FindControl("ddl_Purpose");

                        box1.Text = dt.Rows[i]["AssessmentTask"].ToString();
                        box2.Text = dt.Rows[i]["Weighting"].ToString();
                        box3.Text = dt.Rows[i]["DueDate"].ToString();
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["PrimaryToULO"].ToString());
                        box5.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoULO1"].ToString());
                        box6.SelectedIndex = Convert.ToInt32(dt.Rows[i]["AlsoULO2"].ToString());
                        box7.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Type"].ToString());
                        box8.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Medium"].ToString());
                        box9.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Format"].ToString());
                        box10.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Role"].ToString());
                        box11.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Authenticity"].ToString());
                        box12.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Supervision"].ToString());
                        box13.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Mode"].ToString());
                        box14.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Assessors"].ToString());
                        box15.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Purpose"].ToString());

                        rowIndex++;
                    }
                }
            }
        }


        //Getting the Copy Data for Assessment Tasks
        public DataTable fillingAssessmentTableWithCopyData()
        {
            DataTable Assessmentdt = new DataTable();

            //Setting Up the Columns for the GridView
            Assessmentdt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("AssessmentTask", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Weighting", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("DueDate", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("PrimaryToULO", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("AlsoULO1", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("AlsoULO2", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Type", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Medium", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Format", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Role", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Authenticity", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Supervision", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Mode", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Assessors", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Purpose", typeof(string)));


            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(copyFrom));


            //Filtering the UnitLearning Outcome Mapping Values
            var AssessmentList = from CourseAttributeOptionMapping mapping in list
                                 where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Assessment tasks table").Id)
                                 select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in AssessmentList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }

            int index = 1;
            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in AssessmentList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Typecasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = Assessmentdt.NewRow();
                dr[0] = index++;
                dr[1] = question;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Weighting (%)").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.NonKeyTextValue.Trim();
                    }
                    else if ((new SpecificationAttributeOption("Due week").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.NonKeyTextValue.Trim();
                    }
                    else if ((new SpecificationAttributeOption("primarily to ULO").Id).Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also  ULO1 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[5] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also  ULO2 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[6] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Type").Id).Equals(tempOpt.Id))
                    {
                        dr[7] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Medium").Id).Equals(tempOpt.Id))
                    {
                        dr[8] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Format if Written").Id).Equals(tempOpt.Id))
                    {
                        dr[9] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Role").Id).Equals(tempOpt.Id))
                    {
                        dr[10] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Authenticity").Id).Equals(tempOpt.Id))
                    {
                        dr[11] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Supervision").Id).Equals(tempOpt.Id))
                    {
                        dr[12] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Mode").Id).Equals(tempOpt.Id))
                    {
                        dr[13] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Principal Assessor(s)").Id).Equals(tempOpt.Id))
                    {
                        dr[14] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Principal Assessor(s)").Id).Equals(tempOpt.Id))
                    {
                        dr[15] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }

                }
                Assessmentdt.Rows.Add(dr);
            }

            return Assessmentdt;
        }


        //Button Add Event
        protected void ButtonAddAssessmentTask_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToAssessmentTasksGrid();
        }


        //Button Add Event
        protected void ButtonAddAssessmentTaskMultiple_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToAssessmentTasksGridMultiple();
        }


        //Save Values to the Database
        protected void ButtonSaveAssessmentTask_Click(object sender, EventArgs e)
        {
            CourseAttributeOptionMapping mapping = null;

            //Iterating through all the Rows in the GridView
            foreach (GridViewRow row in Gridview2.Rows)
            {
                //Fetching the Values out of the Controls
                TextBox AssessmentTask = (TextBox)row.FindControl("txt_AssessmentQuestion");
                TextBox Weighting = (TextBox)row.FindControl("txt_Weighting");
                TextBox DueDate = (TextBox)row.FindControl("txt_DueWeek");
                DropDownList primaryULO = (DropDownList)row.FindControl("ddl_PULO");
                DropDownList AlsoULO1 = (DropDownList)row.FindControl("ddl_AlsoULO1");
                DropDownList AlsoULO2 = (DropDownList)row.FindControl("ddl_AlsoULO2");
                DropDownList Type = (DropDownList)row.FindControl("ddl_Type");
                DropDownList Medium = (DropDownList)row.FindControl("ddl_Medium");
                DropDownList Format = (DropDownList)row.FindControl("ddl_Format");
                DropDownList Role = (DropDownList)row.FindControl("ddl_Role");
                DropDownList Authenticity = (DropDownList)row.FindControl("ddl_Authenticity");
                DropDownList Supervision = (DropDownList)row.FindControl("ddl_Supervision");
                DropDownList Mode = (DropDownList)row.FindControl("ddl_Mode");
                DropDownList Assessors = (DropDownList)row.FindControl("ddl_Assessors");
                DropDownList Purpose = (DropDownList)row.FindControl("ddl_Purpose");



                //If the Question is Blank Skip that Question
                if (!AssessmentTask.Text.Trim().Equals(""))
                {
                    //Getting the Question
                    string question = AssessmentTask.Text.Trim();

                    //Getting the Sequence Number
                    string sequencenumber = row.Cells[0].Text;

                    //Gettign the Specification Attribute
                    int specificationAttributeId = new SpecificationAttribute("Assessment tasks table").Id;

                    //HashMap Created for the SpecificationAttributeOption and the KeyValuePairId selected.
                    Dictionary<int, string> specificationOptionAndValuePair = new Dictionary<int, string>();

                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Weighting (%)").Id, Weighting.Text.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Due week").Id, DueDate.Text.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("primarily to ULO").Id, primaryULO.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("also  ULO1 (optional)").Id, AlsoULO1.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("also  ULO2 (optional)").Id, AlsoULO2.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Type").Id, Type.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Medium").Id, Medium.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Format if Written").Id, Format.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Role").Id, Role.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Authenticity").Id, Authenticity.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Supervision").Id, Supervision.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Mode").Id, Mode.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Principal Assessor(s)").Id, Assessors.SelectedItem.Value.Trim());
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Purpose").Id, Purpose.SelectedItem.Value.Trim());




                    //Iterating through all the KeyPairs and Adding a Record in the Mapping Table
                    foreach (KeyValuePair<int, string> pair in specificationOptionAndValuePair)
                    {
                        int specificationAttributeOptionId = pair.Key;
                        string specificationAttributeOptionKeyValue = pair.Value;

                        //Create a New Mapping Object
                        if (pair.Key.CompareTo(new SpecificationAttributeOption("Weighting (%)").Id) == 0 || pair.Key.CompareTo(new SpecificationAttributeOption("Due week").Id) == 0)
                        {
                            //For NonKeyText Options
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), question, new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(SpecificationAttributeOptionKeyValue.GetSpecificationAttributeOptionKeyValueIdByValue("NONE")), pair.Value.ToString().Trim());
                        }
                        else if (pair.Key.CompareTo(new SpecificationAttributeOption("primarily to ULO").Id) == 0 || pair.Key.CompareTo(new SpecificationAttributeOption("also  ULO1 (optional)").Id) == 0 || pair.Key.CompareTo(new SpecificationAttributeOption("also  ULO2 (optional)").Id) == 0)
                        {
                            //For KeyValue associated Options
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), question, new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(SpecificationAttributeOptionKeyValue.GetSpecificationAttributeOptionKeyValueIdByValue("NONE")), specificationAttributeOptionKeyValue);
                        }
                        else
                        {
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), question, new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(Convert.ToInt32(specificationAttributeOptionKeyValue.Trim())), "NONE");
                        }



                        //Checking If Its an Edit
                        if (copyFrom == offeringId)
                        {
                            //Updating a New Record for a Mapping
                            mapping.EditMapping(Convert.ToInt32(sequencenumber), offeringId);
                        }
                        else
                        {
                            //Inserting a New Record for a Mapping
                            mapping.CreateNewMapping(Convert.ToInt32(sequencenumber));
                        }

                    }
                }
            }



            //If Edit Operation is performed
            if (copyFrom == offeringId)
            {
                CourseAttributeOptionMapping.FireEdit(mapping.SpecificationAttribute.Id, offeringId);
            }


            ViewState["CurrentTable"] = null;
            SetInitialRowLearningExperiance();
        }









        //Table LEARNING EXPERIANCE//
        //-----------------------------------------------------------------------------------------------------------------------//


        //Learning Experiance//Setting Up the Initial Row in the GridView
        private void SetInitialRowLearningExperiance()
        {
            Button1.Visible = true;
            Button8.Visible = false;

            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            DataRow dr = null;

            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("LearningExperiance", typeof(string)));
            dt.Columns.Add(new DataColumn("Duration", typeof(string)));
            dt.Columns.Add(new DataColumn("Frequency", typeof(string)));
            dt.Columns.Add(new DataColumn("MainStudentActivity", typeof(string)));


            //Check if Copy from Another Offering or not
            if (copy == 1)
            {
                Button1.Visible = false;
                Button8.Visible = true;

                //Temporary DataTable to Convert Text to Ddl Indexes
                DataTable dtViewState = new DataTable();
                DataRow drViewState;

                //Setting Up the Columns for the GridView
                dtViewState.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("LearningExperiance", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Duration", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Frequency", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("MainStudentActivity", typeof(string)));


                //Getting the Values of the ULO table from the Copy Form Source 
                if ((dt = fillingLearningExperianceTableWithCopyData()) != null)
                {
                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["LearningExperiance"] = string.Empty;
                    dr["Duration"] = string.Empty;
                    dr["Frequency"] = string.Empty;
                    dr["MainStudentActivity"] = string.Empty;

                    dt.Rows.Add(dr);

                    //Adding an Empty Row at the End, after the Copied Values
                    Gridview3.DataSource = dt;
                    Gridview3.DataBind();


                    //Setting Up an Empty Row (Its a Hack.. This Row is going to be Removed Later using (RemoveAt Method))
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["LearningExperiance"] = string.Empty;
                    dr["Duration"] = string.Empty;
                    dr["Frequency"] = string.Empty;
                    dr["MainStudentActivity"] = string.Empty;

                    dt.Rows.Add(dr);



                    //Iterating through all the Rows..to set the Data of the Copy Form Source to the GridView
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < (dt.Rows.Count - 1); i++)
                        {
                            drViewState = dtViewState.NewRow();
                            drViewState["RowNumber"] = i + 1;

                            DropDownList box1 = (DropDownList)Gridview3.Rows[i].Cells[1].FindControl("ddl_LearningExperiance");
                            DropDownList box2 = (DropDownList)Gridview3.Rows[i].Cells[2].FindControl("ddl_Duration");
                            DropDownList box3 = (DropDownList)Gridview3.Rows[i].Cells[3].FindControl("ddl_Frequency");
                            DropDownList box4 = (DropDownList)Gridview3.Rows[i].Cells[4].FindControl("ddl_MSA");


                            //Setting the SqlSources to the DDLs
                            box1.DataSourceID = "sql_LearningExperiance";
                            box2.DataSourceID = "sql_Duration";
                            box3.DataSourceID = "sql_Frequency";
                            box4.DataSourceID = "sql_MSA";



                            //Setting the Values to the Controls
                            box1.SelectedIndex = box1.Items.IndexOf(box1.Items.FindByText(dt.Rows[i]["LearningExperiance"].ToString().Replace("\t", "")));
                            box2.SelectedIndex = box2.Items.IndexOf(box2.Items.FindByText(dt.Rows[i]["Duration"].ToString().Replace("\t", "")));
                            box3.SelectedIndex = box3.Items.IndexOf(box3.Items.FindByText(dt.Rows[i]["Frequency"].ToString().Replace("\t", "")));
                            box4.SelectedIndex = box4.Items.IndexOf(box4.Items.FindByText(dt.Rows[i]["MainStudentActivity"].ToString().Replace("\t", "")));


                            drViewState["LearningExperiance"] = box1.SelectedIndex;
                            drViewState["Duration"] = box2.SelectedIndex;
                            drViewState["Frequency"] = box3.SelectedIndex;
                            drViewState["MainStudentActivity"] = box4.SelectedIndex;

                            //Adding the DataRow to the DataTable
                            dtViewState.Rows.Add(drViewState);

                        }
                    }
                }
                ViewState["CurrentTable"] = dtViewState;
            }
            else
            {
                //Setting Up an Empty Row
                dr = dt.NewRow();
                dr["RowNumber"] = 1;
                dr["LearningExperiance"] = string.Empty;
                dr["Duration"] = string.Empty;
                dr["Frequency"] = string.Empty;
                dr["MainStudentActivity"] = string.Empty;

                dt.Rows.Add(dr);

                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                //Setting up the DataSource of the GridView to the DataTable and Bind It
                Gridview3.DataSource = dt;
                Gridview3.DataBind();
            }
        }


        //Add New Row to the Grid
        private void AddNewRowToLearningExperianceGrid()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview3.Rows[rowIndex].Cells[1].FindControl("ddl_LearningExperiance");
                        DropDownList box2 = (DropDownList)Gridview3.Rows[rowIndex].Cells[2].FindControl("ddl_Duration");
                        DropDownList box3 = (DropDownList)Gridview3.Rows[rowIndex].Cells[3].FindControl("ddl_Frequency");
                        DropDownList box4 = (DropDownList)Gridview3.Rows[rowIndex].Cells[4].FindControl("ddl_MSA");


                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i + 1;
                        drCurrentRow["LearningExperiance"] = box1.SelectedIndex;
                        drCurrentRow["Duration"] = box2.SelectedIndex;
                        drCurrentRow["Frequency"] = box3.SelectedIndex;
                        drCurrentRow["MainStudentActivity"] = box4.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    //Rebind the Grid with the current data
                    Gridview3.DataSource = dtCurrentTable;
                    Gridview3.DataBind();
                }
            }


            //Set Previous Data on Postbacks
            SetPreviousLearningExperianceData();
        }



        //Setting the Data from the ViewState in the Table
        private void SetPreviousLearningExperianceData()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 1; i < dt.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview3.Rows[rowIndex].Cells[1].FindControl("ddl_LearningExperiance");
                        DropDownList box2 = (DropDownList)Gridview3.Rows[rowIndex].Cells[2].FindControl("ddl_Duration");
                        DropDownList box3 = (DropDownList)Gridview3.Rows[rowIndex].Cells[3].FindControl("ddl_Frequency");
                        DropDownList box4 = (DropDownList)Gridview3.Rows[rowIndex].Cells[4].FindControl("ddl_MSA");

                        box1.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LearningExperiance"].ToString());
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Duration"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Frequency"].ToString());
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["MainStudentActivity"].ToString());

                        rowIndex++;

                    }
                }
            }
        }



        //Adding Multiple Rows to Learning Experiance Grid
        public void AddNewRowToLearningExperianceGridMultiple()
        {
            DataTable dtCurrentTable = null;
            int rowIndex = 0;

            //Checking for View State State
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                dtCurrentTable = (DataTable)ViewState["CurrentTable"];

                //Using the Hack to Remove the Extra Blank row added to avoid the out of Index Exception 
                dtCurrentTable.Rows.RemoveAt(dtCurrentTable.Rows.Count - 1);

                DataRow drCurrentRow = null;
                int i = 1;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (i = 1; i <= dtCurrentTable.Rows.Count + 1; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview3.Rows[rowIndex].Cells[1].FindControl("ddl_LearningExperiance");
                        DropDownList box2 = (DropDownList)Gridview3.Rows[rowIndex].Cells[2].FindControl("ddl_Duration");
                        DropDownList box3 = (DropDownList)Gridview3.Rows[rowIndex].Cells[3].FindControl("ddl_Frequency");
                        DropDownList box4 = (DropDownList)Gridview3.Rows[rowIndex].Cells[4].FindControl("ddl_MSA");

                        drCurrentRow = dtCurrentTable.NewRow();


                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i;
                        drCurrentRow["LearningExperiance"] = box1.SelectedIndex;
                        drCurrentRow["Duration"] = box2.SelectedIndex;
                        drCurrentRow["Frequency"] = box3.SelectedIndex;
                        drCurrentRow["MainStudentActivity"] = box4.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Setting Up an Empty Row
                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = Gridview3.Rows.Count + 1;
                    drCurrentRow["LearningExperiance"] = "0";
                    drCurrentRow["Duration"] = "0";
                    drCurrentRow["Frequency"] = "0";
                    drCurrentRow["MainStudentActivity"] = "0";

                    dtCurrentTable.Rows.Add(drCurrentRow);



                    //Rebind the Grid with the current data
                    Gridview3.DataSource = dtCurrentTable;
                    Gridview3.DataBind();


                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                }
            }

            //Set Previous Data on Postbacks
            SetPreviousLearningExperianceDataMultiple();
        }


        //Setting the Data fromm the ViewState for Multiple Rows
        public void SetPreviousLearningExperianceDataMultiple()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < (dt.Rows.Count); i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview3.Rows[rowIndex].Cells[1].FindControl("ddl_LearningExperiance");
                        DropDownList box2 = (DropDownList)Gridview3.Rows[rowIndex].Cells[2].FindControl("ddl_Duration");
                        DropDownList box3 = (DropDownList)Gridview3.Rows[rowIndex].Cells[3].FindControl("ddl_Frequency");
                        DropDownList box4 = (DropDownList)Gridview3.Rows[rowIndex].Cells[4].FindControl("ddl_MSA");

                        box1.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LearningExperiance"].ToString());
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Duration"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Frequency"].ToString());
                        box4.SelectedIndex = Convert.ToInt32(dt.Rows[i]["MainStudentActivity"].ToString());

                        rowIndex++;

                    }
                }
            }

        }



        //Filling the Learning Experiance DropDowns with Copy Form Data... Only of Copy=1 and CopyForm has a Valid Form Id
        public DataTable fillingLearningExperianceTableWithCopyData()
        {
            DataTable LearningExperiancedt = new DataTable();

            //Setting Up the Columns for the GridView
            LearningExperiancedt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("LearningExperiance", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("Duration", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("Frequency", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("MainStudentActivity", typeof(string)));


            //List that holds all the Form Mapping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(copyFrom));

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningExperianceList = from CourseAttributeOptionMapping mapping in list
                                         where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Learning experiences table").Id)
                                         select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in LearningExperianceList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }

            int index = 1;
            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in LearningExperianceList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Typecasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = LearningExperiancedt.NewRow();
                dr[0] = index++;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Learning experiences (Tuition pattern)").Id).Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Duration").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Frequency  ").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Main student activity ").Id).Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                LearningExperiancedt.Rows.Add(dr);
            }

            return LearningExperiancedt;
        }



        //Button Add Event
        protected void ButtonAddLearningExperiance_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToLearningExperianceGrid();
        }


        //Button Add Event
        protected void ButtonAddLearningExperianceMultiple_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToLearningExperianceGridMultiple();
        }


        //Save Values to the Database
        protected void ButtonSaveLearningExperiance_Click(object sender, EventArgs e)
        {
            CourseAttributeOptionMapping mapping = null;

            //Iterating through all the Rows in the GridView
            foreach (GridViewRow row in Gridview3.Rows)
            {
                //Fetching the Values out of the Controls
                DropDownList LearningExperiance = (DropDownList)row.FindControl("ddl_LearningExperiance");
                DropDownList Duration = (DropDownList)row.FindControl("ddl_Duration");
                DropDownList Frequency = (DropDownList)row.FindControl("ddl_Frequency");
                DropDownList MSA = (DropDownList)row.FindControl("ddl_MSA");




                //Getting the Sequence Number
                string sequencenumber = row.Cells[0].Text;

                //Gettign the Specification Attribute
                int specificationAttributeId = new SpecificationAttribute("Learning experiences table").Id;

                //HashMap Created for the SpecificationAttributeOption and the KeyValuePairId selected.
                Dictionary<int, int> specificationOptionAndValuePair = new Dictionary<int, int>();
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Learning experiences (Tuition pattern)").Id, Convert.ToInt32(LearningExperiance.SelectedItem.Value.Trim()));
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Duration").Id, Convert.ToInt32(Duration.SelectedItem.Value.Trim()));
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Frequency  ").Id, Convert.ToInt32(Frequency.SelectedItem.Value.Trim()));
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Main student activity ").Id, Convert.ToInt32(MSA.SelectedItem.Value.Trim()));


                //Iterating through all the KeyPairs and Adding a Record in the Mapping Table
                foreach (KeyValuePair<int, int> pair in specificationOptionAndValuePair)
                {
                    int specificationAttributeOptionId = pair.Key;
                    int specificationAttributeOptionKeyValueId = pair.Value;

                    //Create a New Mapping Object
                    mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), "NONE", new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(specificationAttributeOptionKeyValueId), "NONE");

                    //Checking If Its an Edit
                    if (copyFrom == offeringId)
                    {
                        //Updating a New Record for a Mapping
                        mapping.EditMapping(Convert.ToInt32(sequencenumber), offeringId);
                    }
                    else
                    {
                        //Inserting a New Record for a Mapping
                        mapping.CreateNewMapping(Convert.ToInt32(sequencenumber));
                    }
                }

            }


            //If Edit Operation is performed
            if (copyFrom == offeringId)
            {
                CourseAttributeOptionMapping.FireEdit(mapping.SpecificationAttribute.Id, offeringId);
            }


            //Resetting the View State
            ViewState["CurrentTable"] = null;


            //Setting Initial Row For Assessment Tasks
            SetThemeRows();
        }








        //Table TRIPLE-I CURRICULUM//
        //-----------------------------------------------------------------------------------------------------------------------//


        private void SetThemeRows()
        {

            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            DataRow dr = null;

            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("Themes", typeof(string)));
            dt.Columns.Add(new DataColumn("TripleIThemes", typeof(string)));
            dt.Columns.Add(new DataColumn("Levels", typeof(string)));

            int SpecificationAttributeId = new SpecificationAttribute("Triple-I curriculum themes table").Id;

            //Getting all the Theme Names
            List<SpecificationAttributeOptionKeyValue> optionList = SpecificationAttributeOptionKeyValue.GetAllKeyValuePairs(new SpecificationAttributeOption("Theme Name").Id);

            int i = 0;

            //Iterating through all the Theme Names
            foreach (SpecificationAttributeOptionKeyValue option in optionList)
            {
                dr = dt.NewRow();

                dr["Themes"] = string.Empty;
                optList.Add(option.Value);
                optListId.Add(option.Id);

                //dr["TripleIThemes"] = string.Empty;
                dr["TripleIThemes"] = "a";

                dr["levels"] = string.Empty;

                dt.Rows.Add(dr);
                i++;
            }


            Gridview4.DataSource = dt;
            Gridview4.DataBind();

            foreach (GridViewRow row in Gridview4.Rows)
            {
                ((Label)row.FindControl("lbl_Theme")).Text = optList[row.RowIndex];
                ((Label)row.FindControl("lbl_ThemeId")).Text = "" + optListId[row.RowIndex];
            }

        }


        protected void ButtonSaveTheme_Click(object sender, EventArgs e)
        {
            int SpecificationAttributeId = new SpecificationAttribute("Triple-I curriculum themes table").Id;
            SpecificationAttributeOption specAttributeOpt;
            CourseAttributeOptionMapping mapping = new CourseAttributeOptionMapping();
            Label Theme;
            Label ThemeId;
            TextBox TripleCurriculum;
            DropDownList Level;
            int i = 1;

            //Saving the Values
            foreach (GridViewRow row in Gridview4.Rows)
            {
                for (int m = 0; m < row.Cells.Count; m++)
                {
                    switch (m)
                    {
                        //The Theme
                        case 0:
                            Theme = (Label)row.FindControl("lbl_Theme");
                            ThemeId = (Label)row.FindControl("lbl_ThemeId");

                            specAttributeOpt = new SpecificationAttributeOption("Theme Name");
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId),
                                                    "NONE", new SpecificationAttribute(SpecificationAttributeId),
                                                    specAttributeOpt, new SpecificationAttributeOptionKeyValue(Int32.Parse(ThemeId.Text)), "NONE");
                            break;

                        //The Triple-I Curriculum Text
                        case 1:
                            TripleCurriculum = (TextBox)row.FindControl("txt_TripleICurriculumThemes");

                            specAttributeOpt = new SpecificationAttributeOption("Triple-I curriculum themes");
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId),
                                                    "NONE", new SpecificationAttribute(SpecificationAttributeId),
                                                    specAttributeOpt, new SpecificationAttributeOptionKeyValue(SpecificationAttributeOptionKeyValue.GetSpecificationAttributeOptionKeyValueIdByValue("NONE")), TripleCurriculum.Text.Trim());
                            break;

                        //Levels
                        case 2:
                            Level = (DropDownList)row.FindControl("ddl_Levels");

                            specAttributeOpt = new SpecificationAttributeOption("Level");
                            mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId),
                                                    "NONE", new SpecificationAttribute(SpecificationAttributeId),
                                                    specAttributeOpt, new SpecificationAttributeOptionKeyValue(Int32.Parse(Level.SelectedItem.Value)), "NONE");
                            break;
                    }


                    //Checking If Its an Edit
                    if (copyFrom == offeringId)
                    {
                        //Updating a New Record for a Mapping
                        mapping.EditMapping(i, offeringId);
                    }
                    else
                    {
                        //Inserting a New Record for a Mapping
                        mapping.CreateNewMapping(i);
                    }

                }
                i++;
            }
            //Resetting the View State
            ViewState["CurrentTable"] = null;

            SetInitialRowABCD();
        }





        //Table AUSTRALIAN BLUEPRINT FOR CAREER DEVELOPMENT TABLE//
        //-----------------------------------------------------------------------------------------------------------------------//

        //Setting Up the Initial Row in the GridView for ULO
        private void SetInitialRowABCD()
        {
            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            DataRow dr = null;

            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("Area", typeof(string)));
            dt.Columns.Add(new DataColumn("ABCD", typeof(string)));
            dt.Columns.Add(new DataColumn("LOEngagement", typeof(string)));


            if (copy == 1)
            {

                btn_AddABCD.Visible = false;
                btn_AddABCDMultiple.Visible = true;


                //Temporary DataTable to Convert Text to Ddl Indexes
                DataTable dtViewState = new DataTable();
                DataRow drViewState;

                //Setting Up the Columns for the GridView
                dtViewState.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Area", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("ABCD", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("LOEngagement", typeof(string)));


                //Getting the Values of the ULO table from the Copy Form Source 
                if ((dt = fillingABCDTableWithCopyData()) != null)
                {

                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Area"] = string.Empty;
                    dr["ABCD"] = string.Empty;
                    dr["LOEngagement"] = string.Empty;

                    dt.Rows.Add(dr);

                    //Adding an Empty Row at the End, after the Copied Values
                    Gridview5.DataSource = dt;
                    Gridview5.DataBind();



                    //Setting Up an Empty Row (Its a Hack.. This Row is going to be Removed Later using (RemoveAt Method))
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Area"] = string.Empty;
                    dr["ABCD"] = string.Empty;
                    dr["LOEngagement"] = string.Empty;

                    dt.Rows.Add(dr);

                    //Iterating through all the Rows..to set the Data of the Copy Form Source to the GridView
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < (dt.Rows.Count - 1); i++)
                        {
                            drViewState = dtViewState.NewRow();
                            drViewState["RowNumber"] = i + 1;

                            TextBox box1 = (TextBox)Gridview5.Rows[i].Cells[1].FindControl("txt_ABCD");
                            DropDownList box2 = (DropDownList)Gridview5.Rows[i].Cells[2].FindControl("ddl_Area");
                            DropDownList box3 = (DropDownList)Gridview5.Rows[i].Cells[3].FindControl("ddl_LOE");


                            //Setting the SqlSources to the DDLs
                            box2.DataSourceID = "sql_Area";
                            box3.DataSourceID = "sql_LOE";


                            //Setting the Values to the Controls
                            box1.Text = dt.Rows[i]["ABCD"].ToString();
                            box2.SelectedIndex = box2.Items.IndexOf(box2.Items.FindByText(dt.Rows[i]["Area"].ToString().Replace("\t", "")));
                            box3.SelectedIndex = box3.Items.IndexOf(box3.Items.FindByText(dt.Rows[i]["LOEngagement"].ToString().Replace("\t", "")));


                            //Setting the Value to the Data Row 
                            drViewState["ABCD"] = box1.Text.Trim();
                            drViewState["Area"] = box2.SelectedIndex;
                            drViewState["LOEngagement"] = box3.SelectedIndex;


                            //Adding the DataRow to the DataTable
                            dtViewState.Rows.Add(drViewState);

                        }
                    }
                }

                //Setting the DataTable to the ViewState
                ViewState["CurrentTable"] = dtViewState;

            }
            else
            {
                btn_AddABCD.Visible = true;
                btn_AddABCDMultiple.Visible = false;


                //Setting Up an Empty Row
                dr = dt.NewRow();
                dr["RowNumber"] = 1;
                dr["Area"] = string.Empty;
                dr["ABCD"] = string.Empty;
                dr["LOEngagement"] = string.Empty;
                dt.Rows.Add(dr);

                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                //Setting up the DataSource of the GridView to the DataTable and Bind It
                Gridview5.DataSource = dt;
                Gridview5.DataBind();
            }
        }


        //Add New Row to the Grid
        private void AddNewRowToABCDGrid()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        DropDownList box2 = (DropDownList)Gridview5.Rows[rowIndex].Cells[2].FindControl("ddl_Area");
                        TextBox box1 = (TextBox)Gridview5.Rows[rowIndex].Cells[1].FindControl("txt_ABCD");
                        DropDownList box3 = (DropDownList)Gridview5.Rows[rowIndex].Cells[3].FindControl("ddl_LOE");

                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i + 1;
                        drCurrentRow["Area"] = box2.SelectedIndex;
                        drCurrentRow["ABCD"] = box1.Text;
                        drCurrentRow["LOEngagement"] = box3.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    //Rebind the Grid with the current data
                    Gridview5.DataSource = dtCurrentTable;
                    Gridview5.DataBind();
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousABCDData();
        }



        //Setting the Data from the ViewState in the Table
        private void SetPreviousABCDData()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 1; i < dt.Rows.Count; i++)
                    {
                        DropDownList box2 = (DropDownList)Gridview5.Rows[rowIndex].Cells[2].FindControl("ddl_Area");
                        TextBox box1 = (TextBox)Gridview5.Rows[rowIndex].Cells[1].FindControl("txt_ABCD");
                        DropDownList box3 = (DropDownList)Gridview5.Rows[rowIndex].Cells[3].FindControl("ddl_LOE");

                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Area"].ToString());
                        box1.Text = dt.Rows[i]["ABCD"].ToString();
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LOEngagement"].ToString());

                        rowIndex++;

                    }
                }
            }
        }



        //Add New Row to the Grid
        private void AddNewRowToABCDGridMultiple()
        {
            DataTable dtCurrentTable = null;

            int rowIndex = 0;


            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                dtCurrentTable = (DataTable)ViewState["CurrentTable"];

                //Using the Hack to Remove the Extra Blank row added to avoid the out of Index Exception 
                dtCurrentTable.Rows.RemoveAt(dtCurrentTable.Rows.Count - 1);

                DataRow drCurrentRow = null;

                int i = 1;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (i = 1; i <= dtCurrentTable.Rows.Count + 1; i++)
                    {
                        DropDownList box2 = (DropDownList)Gridview5.Rows[rowIndex].Cells[2].FindControl("ddl_Area");
                        TextBox box1 = (TextBox)Gridview5.Rows[rowIndex].Cells[1].FindControl("txt_ABCD");
                        DropDownList box3 = (DropDownList)Gridview5.Rows[rowIndex].Cells[3].FindControl("ddl_LOE");

                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i;
                        drCurrentRow["Area"] = box2.SelectedIndex;
                        drCurrentRow["ABCD"] = box1.Text;
                        drCurrentRow["LOEngagement"] = box3.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    drCurrentRow = dtCurrentTable.NewRow();

                    //Just for the Row Count
                    drCurrentRow["RowNumber"] = Gridview5.Rows.Count + 1;
                    drCurrentRow["Area"] = "0";
                    drCurrentRow["ABCD"] = string.Empty;
                    drCurrentRow["LOEngagement"] = "0";

                    dtCurrentTable.Rows.Add(drCurrentRow);


                    //Rebind the Grid with the current data
                    Gridview5.DataSource = dtCurrentTable;
                    Gridview5.DataBind();
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousABCDDataMultiple();
        }


        //Setting the Data from the ViewState in the Table
        private void SetPreviousABCDDataMultiple()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DropDownList box2 = (DropDownList)Gridview5.Rows[rowIndex].Cells[2].FindControl("ddl_Area");
                        TextBox box1 = (TextBox)Gridview5.Rows[rowIndex].Cells[1].FindControl("txt_ABCD");
                        DropDownList box3 = (DropDownList)Gridview5.Rows[rowIndex].Cells[3].FindControl("ddl_LOE");

                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Area"].ToString());
                        box1.Text = dt.Rows[i]["ABCD"].ToString();
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["LOEngagement"].ToString());

                        rowIndex++;

                    }
                }
            }
        }



        //Filling the ABCD Textboxes and DropDowns with Copy Form Data... Only of Copy=1 and CopyForm has a Valid Form Id
        public DataTable fillingABCDTableWithCopyData()
        {
            DataTable ABCDdt = new DataTable();

            //Setting Up the Columns for the GridView
            ABCDdt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            ABCDdt.Columns.Add(new DataColumn("Area", typeof(string)));
            ABCDdt.Columns.Add(new DataColumn("ABCD", typeof(string)));
            ABCDdt.Columns.Add(new DataColumn("LOEngagement", typeof(string)));


            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(copyFrom));

            //Filtering the UnitLearning Outcome Mapping Values
            var ABCDList = from CourseAttributeOptionMapping mapping in list
                           where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Australian Blueprint for Career Development table").Id)
                           select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the ABCD Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in ABCDList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }

            int index = 1;
            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in ABCDList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Typecasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = ABCDdt.NewRow();
                dr[0] = index++;
                dr[1] = question;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Area").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Level of engagement").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                ABCDdt.Rows.Add(dr);
            }

            return ABCDdt;
        }



        //Button Add Event
        protected void ButtonAddABCD_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToABCDGrid();
        }


        //Button Add Event
        protected void ButtonAddABCDMultiple_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToABCDGridMultiple();
        }


        //Save Values to the Database
        protected void ButtonSaveABCD_Click(object sender, EventArgs e)
        {
            //Iterating through all the Rows in the GridView
            foreach (GridViewRow row in Gridview5.Rows)
            {
                //Fetching the Values out of the Controls
                DropDownList Area = (DropDownList)row.FindControl("ddl_Area");
                TextBox ABCD = (TextBox)row.FindControl("txt_ABCD");
                DropDownList LOEngagement = (DropDownList)row.FindControl("ddl_LOE");

                //If the ABCD is Blank Skip that ABCD
                if (!ABCD.Text.Trim().Equals(""))
                {
                    //Getting the ABCD
                    string abcd = ABCD.Text.Trim();

                    //Getting the Sequence Number
                    string sequencenumber = row.Cells[0].Text;

                    //Gettign the Specification Attribute
                    int specificationAttributeId = new SpecificationAttribute("Australian Blueprint for Career Development table").Id;

                    //HashMap Created for the SpecificationAttributeOption and the KeyValuePairId selected.
                    Dictionary<int, int> specificationOptionAndValuePair = new Dictionary<int, int>();
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Area").Id, Convert.ToInt32(Area.SelectedItem.Value.Trim()));
                    specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Level of engagement").Id, Convert.ToInt32(LOEngagement.SelectedItem.Value.Trim()));


                    //Iterating through all the KeyPairs and Adding a Record in the Mapping Table
                    foreach (KeyValuePair<int, int> pair in specificationOptionAndValuePair)
                    {
                        int specificationAttributeOptionId = pair.Key;
                        int specificationAttributeOptionKeyValueId = pair.Value;

                        //Create a New Mapping Object
                        CourseAttributeOptionMapping mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), abcd, new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(specificationAttributeOptionKeyValueId), "NONE");

                        //Checking If Its an Edit
                        if (copyFrom == offeringId)
                        {
                            //Updating a New Record for a Mapping
                            mapping.EditMapping(Convert.ToInt32(sequencenumber), offeringId);
                        }
                        else
                        {
                            //Inserting a New Record for a Mapping
                            mapping.CreateNewMapping(Convert.ToInt32(sequencenumber));
                        }
                    }
                }
            }

            //Resetting the View State
            ViewState["CurrentTable"] = null;

            //Setting Initial Row For ABCD
            SetInitialRowLearningResource();
        }










        //Table Learning Resources//
        //-----------------------------------------------------------------------------------------------------------------------//

        //Setting Up the Initial Row in the GridView for Learning Resources
        private void SetInitialRowLearningResource()
        {
            //DataTable to Store the Specification Attribute Option Values
            DataTable dt = new DataTable();

            DataRow dr = null;

            //Setting Up the Columns for the GridView
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("Resource", typeof(string)));
            dt.Columns.Add(new DataColumn("Frequency", typeof(string)));
            dt.Columns.Add(new DataColumn("Cost", typeof(string)));



             //Check if Copy from Another Offering or not
            if (copy == 1)
            {
                btn_LearningResource.Visible = false;
                btn_LearningResourceMultiple.Visible = true;

                //Temporary DataTable to Convert Text to Ddl Indexes
                DataTable dtViewState = new DataTable();
                DataRow drViewState;

                dtViewState.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Resource", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Frequency", typeof(string)));
                dtViewState.Columns.Add(new DataColumn("Cost", typeof(string)));

                //Getting the Values of the ULO table from the Copy Form Source 
                if ((dt = fillingLearningResourcesTableWithCopyData()) != null)
                {
                    //Setting Up an Empty Row
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Resource"] = string.Empty;
                    dr["Frequency"] = string.Empty;
                    dr["Cost"] = string.Empty;

                    dt.Rows.Add(dr);


                    //Adding an Empty Row at the End, after the Copied Values
                    Gridview6.DataSource = dt;
                    Gridview6.DataBind();

                    //Setting Up an Empty Row (Its a Hack.. This Row is going to be Removed Later using (RemoveAt Method))
                    dr = dt.NewRow();
                    dr["RowNumber"] = dt.Rows.Count + 1;
                    dr["Resource"] = string.Empty;
                    dr["Frequency"] = string.Empty;
                    dr["Cost"] = string.Empty;

                    dt.Rows.Add(dr);


                    //Iterating through all the Rows..to set the Data of the Copy Form Source to the GridView
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < (dt.Rows.Count - 1); i++)
                        {
                            drViewState = dtViewState.NewRow();
                            drViewState["RowNumber"] = i + 1;

                            DropDownList box1 = (DropDownList)Gridview6.Rows[i].Cells[1].FindControl("ddl_Resources");
                            DropDownList box2 = (DropDownList)Gridview6.Rows[i].Cells[2].FindControl("ddl_FrequencyOfUse");
                            DropDownList box3 = (DropDownList)Gridview6.Rows[i].Cells[3].FindControl("ddl_Cost");


                            //Setting the SqlSources to the DDLs
                            box1.DataSourceID = "sql_Resources";
                            box2.DataSourceID = "sql_FrequencyOfUse";
                            box3.DataSourceID = "sql_Cost";



                            //Setting the Values to the Controls
                            box1.SelectedIndex = box1.Items.IndexOf(box1.Items.FindByText(dt.Rows[i]["Resource"].ToString().Replace("\t", "")));
                            box2.SelectedIndex = box2.Items.IndexOf(box2.Items.FindByText(dt.Rows[i]["Frequency"].ToString().Replace("\t", "")));
                            box3.SelectedIndex = box3.Items.IndexOf(box3.Items.FindByText(dt.Rows[i]["Cost"].ToString().Replace("\t", "")));


                            drViewState["Resource"] = box1.SelectedIndex;
                            drViewState["Frequency"] = box2.SelectedIndex;
                            drViewState["Cost"] = box3.SelectedIndex;
                            

                            //Adding the DataRow to the DataTable
                            dtViewState.Rows.Add(drViewState);

                        }
                    }
                }
                ViewState["CurrentTable"] = dtViewState;
            }
            else
            {
                btn_LearningResource.Visible = true;
                btn_LearningResourceMultiple.Visible = false;

                //Setting Up an Empty Row
                dr = dt.NewRow();
                dr["RowNumber"] = 1;
                dr["Resource"] = string.Empty;
                dr["Frequency"] = string.Empty;
                dr["Cost"] = string.Empty;

                dt.Rows.Add(dr);

                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                //Setting up the DataSource of the GridView to the DataTable and Bind It
                Gridview6.DataSource = dt;
                Gridview6.DataBind();

            }
        }



        //Getting the CopyValues
        public DataTable fillingLearningResourcesTableWithCopyData()
        {
            DataTable LearningResourcedt = new DataTable();

            //Setting Up the Columns for the GridView
            LearningResourcedt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            LearningResourcedt.Columns.Add(new DataColumn("Resource", typeof(string)));
            LearningResourcedt.Columns.Add(new DataColumn("Frequency", typeof(string)));
            LearningResourcedt.Columns.Add(new DataColumn("Cost", typeof(string)));


            //List that holds all the Form Mapping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(copyFrom));

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningResourceList = from CourseAttributeOptionMapping mapping in list
                                         where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Learning resources table").Id)
                                         select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in LearningResourceList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }

            int index = 1;
            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in LearningResourceList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Typecasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = LearningResourcedt.NewRow();
                dr[0] = index++;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Resource").Id).Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Recommended frequency of use").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Cost to student").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                LearningResourcedt.Rows.Add(dr);
            }

            return LearningResourcedt;

        }



        //Add New Row to the Grid
        private void AddNewRowToLearningResourceGrid()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview6.Rows[rowIndex].Cells[1].FindControl("ddl_Resources");
                        DropDownList box2 = (DropDownList)Gridview6.Rows[rowIndex].Cells[2].FindControl("ddl_FrequencyOfUse");
                        DropDownList box3 = (DropDownList)Gridview6.Rows[rowIndex].Cells[3].FindControl("ddl_Cost");

                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i + 1;
                        drCurrentRow["Resource"] = box1.SelectedIndex;
                        drCurrentRow["Frequency"] = box2.SelectedIndex;
                        drCurrentRow["Cost"] = box3.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                    //Rebind the Grid with the current data
                    Gridview6.DataSource = dtCurrentTable;
                    Gridview6.DataBind();
                }
            }

            //Set Previous Data on Postbacks
            SetPreviousLearningResourceData();
        }



        //Setting the Data from the ViewState in the Table
        private void SetPreviousLearningResourceData()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 1; i < dt.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview6.Rows[rowIndex].Cells[1].FindControl("ddl_Resources");
                        DropDownList box2 = (DropDownList)Gridview6.Rows[rowIndex].Cells[2].FindControl("ddl_FrequencyOfUse");
                        DropDownList box3 = (DropDownList)Gridview6.Rows[rowIndex].Cells[3].FindControl("ddl_Cost");

                        box1.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Resource"].ToString());
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Frequency"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Cost"].ToString());

                        rowIndex++;
                    }
                }
            }
        }



        //Add New Row to the Grid
        private void AddNewRowToLearningResourceGridMultiple()
        {
            DataTable dtCurrentTable = null;

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                //Restore the DataTable from the ViewState to the Current DataTable
                dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                
                DataRow drCurrentRow = null;

                //Using the Hack to Remove the Extra Blank row added to avoid the out of Index Exception 
                dtCurrentTable.Rows.RemoveAt(dtCurrentTable.Rows.Count - 1);

                int i = 1;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    //Setting Up the Controls in GridViewRow for Each Row (From the ViewState)
                    for (i = 1; i <= dtCurrentTable.Rows.Count+1; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview6.Rows[rowIndex].Cells[1].FindControl("ddl_Resources");
                        DropDownList box2 = (DropDownList)Gridview6.Rows[rowIndex].Cells[2].FindControl("ddl_FrequencyOfUse");
                        DropDownList box3 = (DropDownList)Gridview6.Rows[rowIndex].Cells[3].FindControl("ddl_Cost");

                        drCurrentRow = dtCurrentTable.NewRow();

                        //Just for the Row Count
                        drCurrentRow["RowNumber"] = i;
                        drCurrentRow["Resource"] = box1.SelectedIndex;
                        drCurrentRow["Frequency"] = box2.SelectedIndex;
                        drCurrentRow["Cost"] = box3.SelectedIndex;

                        rowIndex++;
                    }

                    //Add new row to DataTable
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    drCurrentRow = dtCurrentTable.NewRow();

                    //Just for the Row Count
                    drCurrentRow["RowNumber"] = Gridview6.Rows.Count + 1;
                    drCurrentRow["Resource"] = "0";
                    drCurrentRow["Frequency"] = "0";
                    drCurrentRow["Cost"] = "0";

                    dtCurrentTable.Rows.Add(drCurrentRow);

                    //Rebind the Grid with the current data
                    Gridview6.DataSource = dtCurrentTable;
                    Gridview6.DataBind();

                    //Store the current data to ViewState
                    ViewState["CurrentTable"] = dtCurrentTable;

                }
            }

            //Set Previous Data on Postbacks
            SetPreviousLearningResourceDataMultiple();
        }



        //Setting the Data from the ViewState in the Table Multiple
        private void SetPreviousLearningResourceDataMultiple()
        {

            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)Gridview6.Rows[rowIndex].Cells[1].FindControl("ddl_Resources");
                        DropDownList box2 = (DropDownList)Gridview6.Rows[rowIndex].Cells[2].FindControl("ddl_FrequencyOfUse");
                        DropDownList box3 = (DropDownList)Gridview6.Rows[rowIndex].Cells[3].FindControl("ddl_Cost");

                        box1.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Resource"].ToString());
                        box2.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Frequency"].ToString());
                        box3.SelectedIndex = Convert.ToInt32(dt.Rows[i]["Cost"].ToString());

                        rowIndex++;
                    }
                }
            }
        }


        //Button Add Event
        protected void ButtonAddLearningResource_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToLearningResourceGrid();
        }


        //Button Add Event
        protected void ButtonAddLearningResourceMultiple_Click(object sender, EventArgs e)
        {
            //Adding a New Row
            AddNewRowToLearningResourceGridMultiple();
        }


        //Save Values to the Database
        protected void ButtonSaveLearningResource_Click(object sender, EventArgs e)
        {
            //Iterating through all the Rows in the GridView
            foreach (GridViewRow row in Gridview6.Rows)
            {
                //Fetching the Values out of the Controls
                DropDownList Resource = (DropDownList)row.FindControl("ddl_Resources");
                DropDownList Frequency = (DropDownList)row.FindControl("ddl_FrequencyOfUse");
                DropDownList Cost = (DropDownList)row.FindControl("ddl_Cost");


                //Getting the Sequence Number
                string sequencenumber = row.Cells[0].Text;

                //Gettign the Specification Attribute
                int specificationAttributeId = new SpecificationAttribute("Learning resources table").Id;

                //HashMap Created for the SpecificationAttributeOption and the KeyValuePairId selected.
                Dictionary<int, int> specificationOptionAndValuePair = new Dictionary<int, int>();
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Resource").Id, Convert.ToInt32(Resource.SelectedItem.Value.Trim()));
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Recommended frequency of use").Id, Convert.ToInt32(Frequency.SelectedItem.Value.Trim()));
                specificationOptionAndValuePair.Add(new SpecificationAttributeOption("Cost to student").Id, Convert.ToInt32(Cost.SelectedItem.Value.Trim()));


                //Iterating through all the KeyPairs and Adding a Record in the Mapping Table
                foreach (KeyValuePair<int, int> pair in specificationOptionAndValuePair)
                {
                    int specificationAttributeOptionId = pair.Key;
                    int specificationAttributeOptionKeyValueId = pair.Value;

                    //Create a New Mapping Object
                    CourseAttributeOptionMapping mapping = new CourseAttributeOptionMapping(new CourseOffering(offeringId), "NONE", new SpecificationAttribute(specificationAttributeId), new SpecificationAttributeOption(specificationAttributeOptionId), new SpecificationAttributeOptionKeyValue(specificationAttributeOptionKeyValueId), "NONE");

                    //Checking If Its an Edit
                    if (copyFrom == offeringId)
                    {
                        //Updating a New Record for a Mapping
                        mapping.EditMapping(Convert.ToInt32(sequencenumber), offeringId);
                    }
                    else
                    {
                        //Inserting a New Record for a Mapping
                        mapping.CreateNewMapping(Convert.ToInt32(sequencenumber));
                    }
                }
            }

            btn_LearningResource.Visible = false;
            btn_LearningResourceMultiple.Visible = false;
            btn_submit.Visible = true;
        }


        //Button to Submit the form to the Program Manager 
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            msgLabel.Text = string.Empty;
            //Update the Status of the form to "Submitted"
            try
            {
                CourseOffering coffering = new CourseOffering(offeringId);
                FormStatus createStatus = new FormStatus('S');
                MyForm form = new MyForm(coffering, createStatus, DateTime.Now, "");
                form.CreateNewForm();

                Response.Redirect("FormCompleted.aspx");
            }
            catch (Exception)
            {
                msgLabel.Text = "Error occured submitting the form, please contact tech support.";
            }
        }



        protected void Gridview2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void CopyButton_Click(object sender, EventArgs e)
        {
            //Copy From Offering Id
            try
            {
                //Getting the Request Parameters if Any
                if (copydata_chkBox.Checked.Equals(true))
                {
                    copy = 1;
                }
                copyFrom = Int32.Parse(Request.QueryString["CF"].ToString());

                //Checking Condition for Right Button Visiblity
                if (copy == 1)
                {
                    ButtonAdd.Visible = false;
                    ButtonAddMultiple.Visible = true;
                }
            }
            catch (Exception)
            {
                //Setting the Single Add No Copy Scenario Button
                copy = 0;
                ButtonAdd.Visible = true;
                ButtonAddMultiple.Visible = false;
            }
            //Set Initial Row for the ULO Table
            SetInitialRowULO();

        }

        public String getMyProgram(int offerId)
        {
            CourseOffering coff = new CourseOffering(offerId);
            return coff.Program.Code;
        }

        protected void ButtonULOSkip_Click(object sender, EventArgs e)
        {
            //Setting Initial Row For Assessment Tasks
            SetInitialRowAssessmentTasks();
        }

        protected void ButtonAssessmentSkip_Click(object sender, EventArgs e)
        {
            //Setting Initial Row For Learning Experience
            SetInitialRowLearningExperiance();
        }

        protected void ButtonLearningExperienceSkip_Click(object sender, EventArgs e)
        {
            //Setting Initial Row For Assessment Tasks
            SetThemeRows();
        }

        protected void ButtonThemeSkip_Click(object sender, EventArgs e)
        {
            //Setting Initial Row For ABCD
            SetInitialRowABCD();
        }

        protected void ButtonABCDSkip_Click(object sender, EventArgs e)
        {
            //Setting Initial Row For ABCD
            SetInitialRowLearningResource();
        }

        protected void Gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[6].Text = hf_pac1.Value.ToString();
                e.Row.Cells[7].Text = hf_pac2.Value.ToString();
                e.Row.Cells[8].Text = hf_pac3.Value.ToString();
                e.Row.Cells[9].Text = hf_aqf.Value.ToString();
            }
        }
        
    }
}













