using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Admin
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

                    if (!userDesignation.Description.Equals("Super Administrator"))
                    {
                        //UnAuthorized Access Page.
                        Response.Redirect("../UnauthorizedPage.aspx", false);
                    }

                    this.populate_Lst_College();
                    this.populate_Lst_School();
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

        //Method to populate data into lst_School during page load

        void populate_Lst_School()
        {
            College coll = new College(Convert.ToInt32(lst_college.SelectedItem.Value));
            List<School> tempListOpt = School.GetAllSchools(coll.Id);
            this.lst_school.DataSource = tempListOpt;
            this.lst_school.DataTextField = "name";
            this.lst_school.DataValueField = "id";
            this.lst_school.DataBind();

        }

        //Method to populate data into lst_College during page load

        void populate_Lst_College()
        {            
            List<College> lstColl = College.GetAllColleges();
            this.lst_college.DataSource = lstColl;
            this.lst_college.DataTextField = "name";
            this.lst_college.DataValueField = "id";
            this.lst_college.DataBind();

        }

        //Method to populate data into lst_archives during page load

        void populate_Lst_Snapshots()
        {
            try
            {
                List<Snapshot> lstSnapshot = Snapshot.GetAllSnapshots();
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
            List<Program> filteredList = new List<Program>();
            College coll = new College(Convert.ToInt32(this.lst_college.SelectedItem.Value));
            List<Program> tempListOpt = Program.GetAllPrograms(coll.Id);
            var query = from Program progWithCode in tempListOpt
                        select new Program(progWithCode.Code, progWithCode.School, String.Format("{0}- {1}", progWithCode.Code, progWithCode.Name), progWithCode.Description, progWithCode.Active, progWithCode.ProgramManager);
            foreach (Program p in query)
            {
                filteredList.Add(p);
            }
            this.lst_program.DataSource = filteredList;
            this.lst_program.DataTextField = "name";
            this.lst_program.DataValueField = "code";
            this.lst_program.DataBind();

        }

        protected void lst_school_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.populate_Lst_Program();
        }

        protected void lst_college_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.populate_Lst_School();
            this.populate_Lst_Program();
        }

        protected void lst_archives_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.calYear.Value = Convert.ToString(lst_archives.SelectedItem.Value);
        }

        public void getPAC1Title()
        {
            RadChart43.ChartTitle.TextBlock.Text = hf_pac1.Value;
        }
        public void getPAC2Title()
        {
            RadChart44.ChartTitle.TextBlock.Text = hf_pac2.Value;
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart44.Visible = false;
            }
        }
        public void getPAC3Title()
        {
            RadChart45.ChartTitle.TextBlock.Text = hf_pac3.Value;
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart45.Visible = false;
            }
        }

        public void getPACW1Title()
        {
            RadChart46.ChartTitle.TextBlock.Text = hf_pac1.Value + "(Weighted)";
        }
        public void getPACW2Title()
        {
            RadChart47.ChartTitle.TextBlock.Text = hf_pac2.Value + "(Weighted)";
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart47.Visible = false;
            }
        }
        public void getPACW3Title()
        {
            RadChart48.ChartTitle.TextBlock.Text = hf_pac3.Value + "(Weighted)";
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart48.Visible = false;
            }
        }
        public void getPACE1Title()
        {
            RadChart49.ChartTitle.TextBlock.Text = "Emphasis on " + hf_pac1.Value + " by Year and Semester";
        }
        public void getPACE2Title()
        {
            RadChart50.ChartTitle.TextBlock.Text = "Emphasis on " + hf_pac2.Value + " by Year and Semester";
            if (hf_pac2.Value.Equals("NONE"))
            {
                RadChart50.Visible = false;
            }
        }
        public void getPACE3Title()
        {
            RadChart51.ChartTitle.TextBlock.Text = "Emphasis on " + hf_pac3.Value + " by Year and Semester";
            if (hf_pac3.Value.Equals("NONE"))
            {
                RadChart51.Visible = false;
            }
        }
    }
}