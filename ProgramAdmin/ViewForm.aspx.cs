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
    public partial class ViewForm : System.Web.UI.Page
    {
        int OfferingId;

        List<CourseAttributeOptionMapping> list;
        List<CourseAttributeOptionMapping> listSeq;

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
            labelCourseName.Text = Request.QueryString["title"].ToString().Trim();

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
                    else if (userDesignation.Description.Equals("Program Manager") || userDesignation.Description.Equals("Administrator"))
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
            CourseOffering coff = new CourseOffering(OfferingId);
            String prog = coff.Program.Code;
            //Populate PAC information
            this.hf_pac1.Value = Driver.getPAC(prog, "GetPAC1");
            this.hf_pac2.Value = Driver.getPAC(prog, "GetPAC2");
            this.hf_pac3.Value = Driver.getPAC(prog, "GetPAC3");
            this.hf_aqf.Value = Driver.getAQFLevel(prog, "GetAQFLevel");

            //List that holds all the Form MApping Entries
            list = CourseAttributeOptionMapping.getAllFormMappings(new CourseOffering(OfferingId));
            listSeq = CourseAttributeOptionMapping.getAllFormMappingsWithSequenceNumber(new CourseOffering(OfferingId));

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

            this.CourseOfferingLink.NavigateUrl = "GenerateNewForm.aspx?id=" + OfferingId + "&C=1&CF=" + OfferingId;

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
            ULOdt.Columns.Add(new DataColumn(hf_pac1.Value, typeof(string)));
            ULOdt.Columns.Add(new DataColumn(hf_pac2.Value, typeof(string)));
            ULOdt.Columns.Add(new DataColumn(hf_pac3.Value + "-", typeof(string)));
            ULOdt.Columns.Add(new DataColumn(hf_aqf.Value, typeof(string)));

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
            TripleIdt.Columns.Add(new DataColumn("Theme Name", typeof(string)));
            TripleIdt.Columns.Add(new DataColumn("Triple-I Themes", typeof(string)));
            TripleIdt.Columns.Add(new DataColumn("Level", typeof(string)));
        }



        //Filling the ULO Table
        public void fillingULOTable()
        {
            //Setting Option Objects
            SpecificationAttributeOption LOT = new SpecificationAttributeOption("Level of Thinking");
            SpecificationAttributeOption PGA = new SpecificationAttributeOption(" primarily to GA");
            SpecificationAttributeOption AlsoGA1 = new SpecificationAttributeOption("also GA1 (optional)");
            SpecificationAttributeOption AlsoGA2 = new SpecificationAttributeOption("also GA2 (optional)");
            SpecificationAttributeOption PAC1 = new SpecificationAttributeOption(hf_pac1.Value);
            SpecificationAttributeOption PAC2 = new SpecificationAttributeOption(hf_pac2.Value);
            SpecificationAttributeOption PAC3 = new SpecificationAttributeOption(hf_pac3.Value);
            SpecificationAttributeOption AQF = new SpecificationAttributeOption(hf_aqf.Value);

            //Filtering the UnitLearning Outcome Mapping Values
            var ULOList = from CourseAttributeOptionMapping mapping in list
                          where mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Unit learning outcomes (ULOs) table").Id) || mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Non Table PAC").Id) || mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Australian Qualification Framework Table").Id) || mapping.SpecificationAttribute.Id.Equals(new SpecificationAttribute("Non Table Program Specific").Id)
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


                //Iterating through all the Rows related to those Questions
                foreach (CourseAttributeOptionMapping mapping in tempList)
                {
                    SpecificationAttributeOption tempOpt = new SpecificationAttributeOption(mapping.SpecificationAttributeOption.Id);

                    if (LOT.Id.Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (PGA.Id.Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (AlsoGA1.Id.Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (AlsoGA2.Id.Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (PAC1.Id.Equals(tempOpt.Id))
                    {
                        dr[5] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (PAC2.Id.Equals(tempOpt.Id))
                    {
                        dr[6] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (PAC3.Id.Equals(tempOpt.Id))
                    {
                        dr[7] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
      
                    else if (AQF.Id.Equals(tempOpt.Id))
                    {
                        dr[8] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
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
            //Setting Option Objects
            SpecificationAttributeOption Weighting = new SpecificationAttributeOption("Weighting (%)");
            SpecificationAttributeOption DueWeek = new SpecificationAttributeOption("Due week");
            SpecificationAttributeOption PULO = new SpecificationAttributeOption("primarily to ULO");
            SpecificationAttributeOption AlsoULO1 = new SpecificationAttributeOption("also  ULO1 (optional)");
            SpecificationAttributeOption AlsoULO2 = new SpecificationAttributeOption("also  ULO2 (optional)");
            SpecificationAttributeOption Type = new SpecificationAttributeOption("Type");
            SpecificationAttributeOption Medium = new SpecificationAttributeOption("Medium");
            SpecificationAttributeOption FOW = new SpecificationAttributeOption("Format if Written");
            SpecificationAttributeOption Role = new SpecificationAttributeOption("Role");
            SpecificationAttributeOption Authenticity = new SpecificationAttributeOption("Authenticity");
            SpecificationAttributeOption Supervision = new SpecificationAttributeOption("Supervision");
            SpecificationAttributeOption Mode = new SpecificationAttributeOption("Mode");
            SpecificationAttributeOption PAccessor = new SpecificationAttributeOption("Principal Assessor(s)");
            SpecificationAttributeOption Purpose = new SpecificationAttributeOption("Purpose");


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

                    if (Weighting.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[1] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (DueWeek.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[2] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (PULO.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[3] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (AlsoULO1.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[4] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (AlsoULO2.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[5] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (Type.Id.Equals(tempOpt.Id))
                    {
                        dr[6] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Medium.Id.Equals(tempOpt.Id))
                    {
                        dr[7] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (FOW.Id.Equals(tempOpt.Id))
                    {
                        dr[8] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Role.Id.Equals(tempOpt.Id))
                    {
                        dr[9] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Authenticity.Id.Equals(tempOpt.Id))
                    {
                        dr[10] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Supervision.Id.Equals(tempOpt.Id))
                    {
                        dr[11] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Mode.Id.Equals(tempOpt.Id))
                    {
                        dr[12] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (PAccessor.Id.Equals(tempOpt.Id))
                    {
                        dr[13] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Purpose.Id.Equals(tempOpt.Id))
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
            //Setting Option Objects
            SpecificationAttributeOption LETutPattern = new SpecificationAttributeOption("Learning experiences (Tuition pattern)");
            SpecificationAttributeOption Duration = new SpecificationAttributeOption("Duration");
            SpecificationAttributeOption Frequency = new SpecificationAttributeOption("Frequency  ");
            SpecificationAttributeOption MSA = new SpecificationAttributeOption("Main student activity ");

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningExperianceList = from CourseAttributeOptionMapping mapping in listSeq
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

                    if (LETutPattern.Id.Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Duration.Id.Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Frequency.Id.Equals(tempOpt.Id))
                    {
                        dr[3] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (MSA.Id.Equals(tempOpt.Id))
                    {
                        dr[4] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                LearningExperiancedt.Rows.Add(dr);
            }



            GridView3.DataSource = LearningExperiancedt;
            GridView3.DataBind();
        }



        public void fillingTripleITable()
        {
            //Setting Up Option Objects
            SpecificationAttributeOption ThemeName = new SpecificationAttributeOption("Theme Name");
            SpecificationAttributeOption TripleI = new SpecificationAttributeOption("Triple-I curriculum themes");
            SpecificationAttributeOption Level = new SpecificationAttributeOption("Level");


            //Filtering the UnitLearning Outcome Mapping Values
            var TripleIList = from CourseAttributeOptionMapping mapping in listSeq
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

                    if (ThemeName.Id.Equals(tempOpt.Id))
                    {
                        dr[0] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (TripleI.Id.Equals(tempOpt.Id))
                    {
                        if (mapping.SpecificationAttributeOptionKeyValue.Value.ToString().Equals("NONE"))
                        {
                            dr[1] = mapping.NonKeyTextValue;
                        }
                    }
                    else if (Level.Id.Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                }
                TripleIdt.Rows.Add(dr);
            }



            GridView4.DataSource = TripleIdt;
            GridView4.DataBind();
        }



        //Filling the ABCD Table
        public void fillingABCDTable()
        {
            //Setting Up Option Objects
            SpecificationAttributeOption Area = new SpecificationAttributeOption("Area");
            SpecificationAttributeOption LOE = new SpecificationAttributeOption("Level of engagement");


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

                    if (Area.Id.Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (LOE.Id.Equals(tempOpt.Id))
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
            //Setting Up Option Objects
            SpecificationAttributeOption Resource = new SpecificationAttributeOption("Resource");
            SpecificationAttributeOption FOU = new SpecificationAttributeOption("Recommended frequency of use");
            SpecificationAttributeOption Cost = new SpecificationAttributeOption("Cost to student");

            //Filtering the UnitLearning Outcome Mapping Values
            var LearningResourcesList = from CourseAttributeOptionMapping mapping in listSeq
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

                    if (Resource.Id.Equals(tempOpt.Id))
                    {
                        dr[1] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (FOU.Id.Equals(tempOpt.Id))
                    {
                        dr[2] = mapping.SpecificationAttributeOptionKeyValue.Value.ToString();
                    }
                    else if (Cost.Id.Equals(tempOpt.Id))
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

            Response.Redirect("FormApproved.aspx");
        }


        protected void btn_Reject_Click(object sender, EventArgs e)
        {
            CourseOffering coffering = new CourseOffering(OfferingId);
            FormStatus createStatus = new FormStatus('R');
            MyForm form = new MyForm(coffering, createStatus, DateTime.Now, txt_comment.Text.Trim());
            form.CreateNewForm();

            Response.Redirect("FormRejected.aspx");
        }
    }
}