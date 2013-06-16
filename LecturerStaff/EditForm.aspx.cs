using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CurriculumMapping.LecturerStaff
{
    public partial class EditForm : System.Web.UI.Page
    {

        int OfferingId;

        //Unit Learning Outcome DataTable
        DataTable ULOdt = new DataTable();

        //Assessment DataTable
        DataTable Assessmentdt = new DataTable();

        //Learning Experiance DataTable
        DataTable LearningExperiancedt = new DataTable();


        //Triple I Table
        DataTable TripleIdt = new DataTable();

        //ABCD DataTable
        DataTable ABCDdt = new DataTable();

        //Learning Resources DataTable
        DataTable LearningResourcesdt = new DataTable();




        protected void Page_Load(object sender, EventArgs e)
        {
            OfferingId = Int32.Parse(Request.QueryString["id"].ToString().Trim());

            if (!Page.IsPostBack)
            {
                try
                {
                    //Identifies the User Role
                    Staff user = Driver.IdentifyRole(Session);

                    //Creates a User Designation Object
                    Designation userDesignation = new Designation();
                    userDesignation = user.Designation;

                    if (userDesignation.Description.Equals("Lecturer"))
                    {
                        pnl_ProgramAdmin.Visible = false;
                    }
                    else if (userDesignation.Description.Equals("Program Manager"))
                    {
                        MyForm myform = new MyForm(new CourseOffering(OfferingId));
                        if (myform.Status.StatusName.Equals("Submitted"))
                        {
                            pnl_ProgramAdmin.Visible = true;
                        }
                        else
                        {
                            pnl_ProgramAdmin.Visible = false;
                        }
                    }
                    else
                    {
                        pnl_ProgramAdmin.Visible = false;
                        //UnAuthorized Access Page.
                        Response.Redirect("../UnauthorizedPage.aspx", false);
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }

            }








            //Setting the Offering Id from the QueryString

            OfferingId = Int32.Parse(Request.QueryString["id"].ToString());

            //Setting Up a Skeletons
            setULOSkeleton();

            setAssessmentSkeleton();

            setLearningExperianceSkeleton();

            setLearningResourcesSkeleton();

            setABCDSkeleton();

            setTripleISkeleton();


            //Filling the Tables
            fillingULOTable();

            fillingAssessmentTable();

            fillingLearningExperianceTable();

            fillingLearningResourcesTable();

            fillingABCDTable();

            fillingTripleITable();


        }



        //Creating a ULO Table Skeleton
        public void setULOSkeleton()
        {
            //Setting Up the Columns for the Unit Learning OutCome 
            ULOdt.Columns.Add(new DataColumn("UnitLearningOutcomes", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("LevelOfThinking", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PrimarilyToGA", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("AlsoGA1", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("AlsoGA2", typeof(string)));
            ULOdt.Columns.Add(new DataColumn("PAC", typeof(string)));

        }


        public void setAssessmentSkeleton()
        {
            Assessmentdt.Columns.Add(new DataColumn("AssessmentTask", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Weighting", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("DueWeek", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("PrimaryToULO", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("AlsoULO1", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("AlsoULO2", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Type", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Medium", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Format", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Role", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Authencity", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Supervision", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Mode", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Accessors", typeof(string)));
            Assessmentdt.Columns.Add(new DataColumn("Purpose", typeof(string)));
        }


        //Creating a Learning Experiance
        public void setLearningExperianceSkeleton()
        {
            //Setting Up the Columns for Learning Experiance
            LearningExperiancedt.Columns.Add(new DataColumn("Row", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("Experiance", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("Duration", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("Frequency", typeof(string)));
            LearningExperiancedt.Columns.Add(new DataColumn("MSA", typeof(string)));
        }


        public void setLearningResourcesSkeleton()
        {
            //Setting Up the Columns for Learning Experiance
            LearningResourcesdt.Columns.Add(new DataColumn("Row", typeof(string)));
            LearningResourcesdt.Columns.Add(new DataColumn("Resources", typeof(string)));
            LearningResourcesdt.Columns.Add(new DataColumn("FOU", typeof(string)));
            LearningResourcesdt.Columns.Add(new DataColumn("COS", typeof(string)));
        }

        public void setABCDSkeleton()
        {
            //Setting Up the Columns for the ABCD
            ABCDdt.Columns.Add(new DataColumn("BluePrint", typeof(string)));
            ABCDdt.Columns.Add(new DataColumn("Area", typeof(string)));
            ABCDdt.Columns.Add(new DataColumn("Level of Engagement", typeof(string)));
        }



        public void setTripleISkeleton()
        {
            //TripleIdt.Columns.Add(new DataColumn("Themes", typeof(string)));
            TripleIdt.Columns.Add(new DataColumn("Triple-I Themes", typeof(string)));
            TripleIdt.Columns.Add(new DataColumn("Level", typeof(string)));
        }





        public void fillingTripleITable()
        {
            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(OfferingId));

            //Filtering the UnitLearning Outcome Mapping Values
            var TripleIList = from CourseAttributeOptionMapping mapping in list
                              where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Triple-I curriculum themes table").Id)
                              select mapping;

            List<string> RowList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in TripleIList)
            {
                if (!RowList.Contains(mapping.Question))
                {
                    RowList.Add(mapping.Question);
                }
            }


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string row in RowList)
            {
                var RowMappings = from CourseAttributeOptionMapping mapping in TripleIList
                                  where mapping.Question.Trim().Equals(row)
                                  select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = RowMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = TripleIdt.NewRow();

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Triple-I curriculum themes").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[0] = mapping.NonKeyTextValue;
                        }

                        //dr[0] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Level").Id).Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                TripleIdt.Rows.Add(dr);
            }



            GridView4.DataSource = TripleIdt;
            GridView4.DataBind();
        }






        //Filling the ULO Table
        public void fillingULOTable()
        {
            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(OfferingId));

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


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in ULOList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = ULOdt.NewRow();
                dr[0] = question;

                

                //TextBox tbox = new TextBox();
                //tbox.Text = question;

                //TableCell uloCell = new TableCell();
                //uloCell.Controls.Add(tbox);
                
                //ULOdt.Rows.Add();

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Level of Thinking").Id).Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption(" primarily to GA").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also GA1 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("also GA2 (optional)").Id).Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Professional Accreditation Competencies").Id).Equals(tempOpt.Id))
                    {
                        dr[5] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                ULOdt.Rows.Add(dr);
            }



            GridView1.DataSource = ULOdt;
            GridView1.DataBind();
        }



        //Filling the Assessment Table
        public void fillingAssessmentTable()
        {
            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(OfferingId));

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


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in AssessmentList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = Assessmentdt.NewRow();
                dr[0] = question;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Weighting (%)").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[1] = mapping.NonKeyTextValue;
                        }
                    }
                    else if ((new SpecificationAttributeOption("Due week").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[2] = mapping.NonKeyTextValue;
                        }
                    }
                    else if ((new SpecificationAttributeOption("primarily to ULO").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[3] = mapping.NonKeyTextValue;
                        }
                    }
                    else if ((new SpecificationAttributeOption("also  ULO1 (optional)").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[4] = mapping.NonKeyTextValue;
                        }
                    }
                    else if ((new SpecificationAttributeOption("also  ULO2 (optional)").Id).Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[5] = mapping.NonKeyTextValue;
                        }
                    }
                    else if ((new SpecificationAttributeOption("Type").Id).Equals(tempOpt.Id))
                    {
                        dr[6] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Medium").Id).Equals(tempOpt.Id))
                    {
                        dr[7] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Format if Written").Id).Equals(tempOpt.Id))
                    {
                        dr[8] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Role").Id).Equals(tempOpt.Id))
                    {
                        dr[9] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Authenticity").Id).Equals(tempOpt.Id))
                    {
                        dr[10] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Supervision").Id).Equals(tempOpt.Id))
                    {
                        dr[11] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Mode").Id).Equals(tempOpt.Id))
                    {
                        dr[12] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Principal Assessor(s)").Id).Equals(tempOpt.Id))
                    {
                        dr[13] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Purpose").Id).Equals(tempOpt.Id))
                    {
                        dr[14] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                Assessmentdt.Rows.Add(dr);
            }



            GridView2.DataSource = Assessmentdt;
            GridView2.DataBind();
        }




        //Filling the learning Experiance Table
        public void fillingLearningExperianceTable()
        {
            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(OfferingId));

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningExperianceList = from CourseAttributeOptionMapping mapping in list
                                         where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Learning experiences table").Id)
                                         select mapping;

            List<string> RowList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in LearningExperianceList)
            {
                if (!RowList.Contains(mapping.Question))
                {
                    RowList.Add(mapping.Question);
                }
            }


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string row in RowList)
            {
                var RowMappings = from CourseAttributeOptionMapping mapping in LearningExperianceList
                                  where mapping.Question.Trim().Equals(row)
                                  select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = RowMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = LearningExperiancedt.NewRow();
                dr[0] = row;

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



            GridView3.DataSource = LearningExperiancedt;
            GridView3.DataBind();
        }



        //Filling the ABCD Table
        public void fillingABCDTable()
        {
            //List that holds all the Form MApping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(OfferingId));

            //Filtering the UnitLearning Outcome Mapping Values
            var ABCDList = from CourseAttributeOptionMapping mapping in list
                           where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Australian Blueprint for Career Development table").Id)
                           select mapping;

            List<string> QuestionList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in ABCDList)
            {
                if (!QuestionList.Contains(mapping.Question))
                {
                    QuestionList.Add(mapping.Question);
                }
            }


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string question in QuestionList)
            {
                var QuestionMappings = from CourseAttributeOptionMapping mapping in ABCDList
                                       where mapping.Question.Trim().Equals(question)
                                       select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = QuestionMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = ABCDdt.NewRow();
                dr[0] = question;

                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if ((new SpecificationAttributeOption("Area").Id).Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if ((new SpecificationAttributeOption("Level of engagement").Id).Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                ABCDdt.Rows.Add(dr);
            }



            GridView5.DataSource = ABCDdt;
            GridView5.DataBind();
        }





        //Filling the learning Experiance Table
        public void fillingLearningResourcesTable()
        {
            //List that holds all the Form Mapping Entries
            List<CourseAttributeOptionMapping> list = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(OfferingId));

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningResourcesList = from CourseAttributeOptionMapping mapping in list
                                        where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Learning resources table").Id)
                                        select mapping;

            List<string> RowList = new List<string>();

            //Getting the Distinct Questions from the Unit Learning Outcome List
            foreach (CourseAttributeOptionMapping mapping in LearningResourcesList)
            {
                if (!RowList.Contains(mapping.Question))
                {
                    RowList.Add(mapping.Question);
                }
            }


            //Iterating throught all the Questions and Getting its corrosponding Mappings
            foreach (string row in RowList)
            {
                var RowMappings = from CourseAttributeOptionMapping mapping in LearningResourcesList
                                  where mapping.Question.Trim().Equals(row)
                                  select mapping;

                //Tycasting var into List<CourseAttributeOptionMapping>
                List<CourseAttributeOptionMapping> tempList = RowMappings.ToList<CourseAttributeOptionMapping>();

                //Adding a New Row to the ULOdt
                DataRow dr = LearningResourcesdt.NewRow();
                dr[0] = row;

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
                LearningResourcesdt.Rows.Add(dr);
            }

            GridView6.DataSource = LearningResourcesdt;
            GridView6.DataBind();
        }

        protected void btn_Approve_Click(object sender, EventArgs e)
        {
            CourseOffering coffering = new CourseOffering(OfferingId);
            FormStatus createStatus = new FormStatus('A');
            MyForm form = new MyForm(coffering, createStatus, DateTime.Now, txt_comment.Text.Trim());
            form.CreateNewForm();
        }

        protected void btn_Reject_Click(object sender, EventArgs e)
        {
            CourseOffering coffering = new CourseOffering(OfferingId);
            FormStatus createStatus = new FormStatus('R');
            MyForm form = new MyForm(coffering, createStatus, DateTime.Now, txt_comment.Text.Trim());
            form.CreateNewForm();
        }
    

    }
}