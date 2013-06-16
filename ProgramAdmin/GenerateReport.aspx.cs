using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.ProgramAdmin
{
    public partial class GenerateReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                    this.populate_Lst_Program();
                    this.populate_Lst_Snapshots();
                    this.hf_pac1.Value = Driver.getPAC(lst_program.SelectedItem.Value, "GetPAC1");
                    this.hf_pac2.Value = Driver.getPAC(lst_program.SelectedItem.Value, "GetPAC2");
                    this.hf_pac3.Value = Driver.getPAC(lst_program.SelectedItem.Value, "GetPAC3");
                    this.getPAC1Title();
                    this.getPAC2Title();
                    this.getPAC3Title();
                    this.getPACW1Title();
                    this.getPACW2Title();
                    this.getPACW3Title();
                    this.getPACE1Title();
                    this.getPACE2Title();
                    this.getPACE3Title();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
            
            this.calYear.Value = Convert.ToString(lst_archives.SelectedItem.Value);
            
        }


        //Method to populate data into lst_archives during page load

        void populate_Lst_Snapshots()
        {
            try
            {
                Snapshot currentRep = new Snapshot("Current Report", DateTime.Now);
                List<Snapshot> lstSnapshot = new List<Snapshot>();
                lstSnapshot.Add(currentRep);
                this.lst_archives.DataSource = lstSnapshot;
                this.lst_archives.DataTextField = "snapshotname";
                this.lst_archives.DataValueField = "timestamp";
                this.lst_archives.DataBind();
            }
            catch (Exception)
            {
            }
        }

        //Method to populate data into lst_Program during page load

        void populate_Lst_Program()
        {
            //Identifies the User Role
            ProgramManager me = new ProgramManager(Driver.IdentifyRole(Session).ID);
            List<Program> myPrograms = Driver.MyProgramList(me);
            List<Program> progList = new List<Program>();
            var query = from Program progWithCode in myPrograms
                        select new Program(progWithCode.Code, progWithCode.School, String.Format("{0}- {1}", progWithCode.Code, progWithCode.Name), progWithCode.Description, progWithCode.Active, progWithCode.ProgramManager);

            foreach (Program prog in query)
            {
                progList.Add(prog);
            }
            this.lst_program.DataSource = progList;
            this.lst_program.DataTextField = "name";
            this.lst_program.DataValueField = "code";
            this.lst_program.DataBind();

        }

        protected void lst_program_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.lst_program.SelectedItem.Value = this.lst_program.SelectedItem.Value;
        }

        public void getPAC1Title()
        {
            RadChart45.ChartTitle.TextBlock.Text = hf_pac1.Value;
        }
        public void getPAC2Title()
        {
            RadChart46.ChartTitle.TextBlock.Text = hf_pac2.Value;
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart46.Visible = false;
            }
        }
        public void getPAC3Title()
        {
            RadChart47.ChartTitle.TextBlock.Text = hf_pac3.Value;
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart47.Visible = false;
            }
        }

        public void getPACW1Title()
        {
            RadChart48.ChartTitle.TextBlock.Text = hf_pac1.Value+"(Weighted)";
        }
        public void getPACW2Title()
        {
            RadChart49.ChartTitle.TextBlock.Text = hf_pac2.Value + "(Weighted)";
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart49.Visible = false;
            }
        }
        public void getPACW3Title()
        {
            RadChart50.ChartTitle.TextBlock.Text = hf_pac3.Value + "(Weighted)";
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart50.Visible = false;
            }
        }
        public void getPACE1Title()
        {
            RadChart51.ChartTitle.TextBlock.Text = "Emphasis on "+hf_pac1.Value + " by Year and Semester";
        }
        public void getPACE2Title()
        {
            RadChart52.ChartTitle.TextBlock.Text = "Emphasis on " + hf_pac2.Value + " by Year and Semester";
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart52.Visible = false;
            }
        }
        public void getPACE3Title()
        {
            RadChart53.ChartTitle.TextBlock.Text = "Emphasis on " + hf_pac3.Value + " by Year and Semester";
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart53.Visible = false;
            }
        }


    }
}