using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Admin
{
    public partial class AssignProgramCourse : System.Web.UI.Page
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
                    this.populate_Lst_School();
                    this.populate_Lst_Program();
                    this.populate_Lst_Course();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            String programId = lst_program.SelectedItem.Value;
            String courseId = lst_course.SelectedItem.Value;

            if (Driver.AssignCourseToProgram(programId, courseId) == true)
            {
                Label4.Text = "Course Successfully Assigned";
            }
            else
            {
                Label4.Text = "The Program already contains this Course";
                Label4.ForeColor.Equals("red");
            }
           
        }

        //Method to populate data into lst_School during page load

        void populate_Lst_School()
        {
            //Identifies the User Role
            Staff user = Driver.IdentifyRole(Session);
            College coll = new College(user.ID);
            List<School> tempListOpt = School.GetAllSchools(coll.Id);
            this.lst_school.DataSource = tempListOpt;
            this.lst_school.DataTextField = "name";
            this.lst_school.DataValueField = "id";
            this.lst_school.DataBind();

        }

        //Method to populate data into lst_Program during page load

        void populate_Lst_Program()
        {
            List<Program> filteredList = new List<Program>();
            //Identifies the User Role
            Staff user = Driver.IdentifyRole(Session);
            College coll = new College(user.ID);
            List<Program> tempListOpt = Program.GetAllPrograms(coll.Id);
            var query = from Program tempSch in tempListOpt
                       where tempSch.School.Id.ToString().Equals(lst_school.SelectedItem.Value)
                       select tempSch;
            foreach (Program p in query)
            {
                filteredList.Add(p);
            }
            this.lst_program.DataSource = filteredList;
            this.lst_program.DataTextField = "name";
            this.lst_program.DataValueField = "code";
            this.lst_program.DataBind();

        }

        //Method to populate data into lst_course during page load

        void populate_Lst_Course()
        {
            //Identifies the User Role
            Staff user = Driver.IdentifyRole(Session);
            College coll = new College(user.ID);
            List<Course> tempListOpt = Course.GetAllCourses(Convert.ToInt32(lst_school.SelectedItem.Value));
            this.lst_course.DataSource = tempListOpt;
            this.lst_course.DataTextField = "title";
            this.lst_course.DataValueField = "code";
            this.lst_course.DataBind();

        }

        protected void lst_school_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.populate_Lst_Program();
            this.populate_Lst_Course();
        }

    }
}