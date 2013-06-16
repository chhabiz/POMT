using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Admin
{
    public partial class CreateProgram : System.Web.UI.Page
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

                    if (!userDesignation.Description.Equals("Administrator"))
                    {
                        //UnAuthorized Access Page.
                        Response.Redirect("../UnauthorizedPage.aspx", false);
                    }

                    this.populate_Lst_College();
                    this.populate_Lst_School();
                    this.populate_Lst_PManager();
                    this.populate_Lst_PAC1();
                    this.populate_Lst_PAC2();
                    this.populate_Lst_AQFLevel();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
            this.populate_Lst_PAC3();
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Label4.Text = string.Empty;

            //Constructing a Program Object
            School school=new School(Convert.ToInt32(lst_school.SelectedItem.Value));
            ProgramManager pm=new ProgramManager(lst_pmanager.SelectedItem.Value);
            Program program = new Program(txt_progcode.Text,school,txt_program.Text,txt_description.Text,true,pm);
            bool created = program.CreateNewProgram();

            //Map the PACs & AQF levels
            int pac1=Convert.ToInt32(lst_pac1.SelectedItem.Value);
            int pac2=Convert.ToInt32(lst_pac2.SelectedItem.Value);
            int pac3=Convert.ToInt32(lst_pac3.SelectedItem.Value);

            bool mapped = Driver.MapPACs(txt_progcode.Text,pac1,pac2,pac3);
            int aqfLevel=Convert.ToInt32(lst_aqflevel.SelectedItem.Value);
            bool mappedAQF = Driver.MapAQFLevel(txt_progcode.Text,aqfLevel);

            if (created == true && mapped==true && mappedAQF==true)
            {
                Label4.Text = "Program Successfully Created";
            }
            else
            {
                Label4.Text = "Error Creating Program, please make sure that a program with a similar program code does not exist";
            }

            clearFields();
        }

        protected void clearFields()
        {
            txt_program.Text = string.Empty;
            txt_progcode.Text = string.Empty;
            txt_description.Text = string.Empty;
        }

        //Method to populate data into lst_College during page load

        void populate_Lst_College()
        {
            //Identifies the User Role
            Staff user = Driver.IdentifyRole(Session);
            College coll = new College(user.ID);
            List<College> tempListOpt = new List<College>();
            tempListOpt.Add(coll);
            this.lst_college.DataSource = tempListOpt;
            this.lst_college.DataTextField = "name";
            this.lst_college.DataValueField = "id";
            this.lst_college.DataBind();

        }

        //Method to populate data into lst_school during page load

        void populate_Lst_School()
        {
            List<School> tempListOpt = School.GetAllSchools(Convert.ToInt32(lst_college.SelectedItem.Value));
            this.lst_school.DataSource = tempListOpt;
            this.lst_school.DataTextField = "name";
            this.lst_school.DataValueField = "id";
            this.lst_school.DataBind();

        }

        //Method to populate data into lst_pmanager during page load

        void populate_Lst_PManager()
        {
            Staff user = Driver.IdentifyRole(Session);
            //List<ProgramManager> tempListOpt = ProgramManager.GetAllProgramManagers(Convert.ToInt32(lst_college.SelectedItem.Value));
            List<ProgramManager> tempListOpt = ProgramManager.GetAllProgramManagers(user.ID.ToString());
            List<ProgramManager> filteredList = new List<ProgramManager>();
            var query = from ProgramManager activeManager in tempListOpt
                        where activeManager.Active.Equals(true)
                        select new ProgramManager(activeManager.ID, String.Format("{0} {1}", activeManager.FirstName, activeManager.LastName), activeManager.LastName, activeManager.EMailId, activeManager.PhoneNumber, activeManager.Designation, activeManager.Active);
                       
            foreach (ProgramManager pm in query)
            {
                filteredList.Add(pm);
            }
            this.lst_pmanager.DataSource = filteredList;
            this.lst_pmanager.DataTextField = "firstName";
            this.lst_pmanager.DataValueField = "id";
            this.lst_pmanager.DataBind();

        }

        void populate_Lst_PAC1()
        {
            //Get all PACs into a list
            List<SpecificationAttributeOption> pacList = SpecificationAttributeOption.GetAllSpecificationAttributeOptions(10);
            List<SpecificationAttributeOption> pacListFiltered = new List<SpecificationAttributeOption>();
            foreach (SpecificationAttributeOption pac1value in pacList)
            {
                if (pac1value.Name.Equals("NONE"))
                {
                    //Do Nothing
                }
                else
                {
                    pacListFiltered.Add(pac1value);
                } 
            }
            this.lst_pac1.DataSource = pacListFiltered;
            this.lst_pac1.DataTextField = "name";
            this.lst_pac1.DataValueField = "id";
            this.lst_pac1.DataBind();
        }

        void populate_Lst_PAC2()
        {
            //Get all PACs into a list
            List<SpecificationAttributeOption> pacList = SpecificationAttributeOption.GetAllSpecificationAttributeOptions(10);
            this.lst_pac2.DataSource = pacList;
            this.lst_pac2.DataTextField = "name";
            this.lst_pac2.DataValueField = "id";
            this.lst_pac2.DataBind();
        }

        void populate_Lst_PAC3()
        {
            List<SpecificationAttributeOption> pacList = SpecificationAttributeOption.GetAllSpecificationAttributeOptions(10);
            if (lst_pac2.SelectedItem.Text.Equals("NONE"))
            {
                //Get all PACs into a list
                List<SpecificationAttributeOption> pacListFiltered = new List<SpecificationAttributeOption>();
                var query = from SpecificationAttributeOption noneoption in pacList
                            where noneoption.Name.Equals("NONE")
                            select noneoption;
                foreach (SpecificationAttributeOption nonvalue in query)
                {
                    pacListFiltered.Add(nonvalue);
                }
                this.lst_pac3.DataSource = pacListFiltered;
                this.lst_pac3.DataTextField = "name";
                this.lst_pac3.DataValueField = "id";
                this.lst_pac3.DataBind();
            }
            else
            {
                //Get all PACs into a list
                this.lst_pac3.DataSource = pacList;
                this.lst_pac3.DataTextField = "name";
                this.lst_pac3.DataValueField = "id";
                this.lst_pac3.DataBind();
            }
           
        }

        void populate_Lst_AQFLevel()
        {
            //Get all AQF Levels into a list
            List<SpecificationAttributeOption> aqfList = SpecificationAttributeOption.GetAllSpecificationAttributeOptions(11);
            this.lst_aqflevel.DataSource = aqfList;
            this.lst_aqflevel.DataTextField = "name";
            this.lst_aqflevel.DataValueField = "id";
            this.lst_aqflevel.DataBind();
        }

    }
}