using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Saplin.Controls;

namespace CurriculumMapping.Admin
{
    public partial class CreateCourse : System.Web.UI.Page
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
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
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

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Label4.Text = string.Empty;

            List<Course> preqList=new List<Course>();
            String courseCode = this.txt_coursecode.Text;
            String courseTitle = this.txt_course.Text;
            int cValue = Convert.ToInt32(this.txt_creditval.Text);
            String oEqivalent = this.txt_oua_equivalent.Text;
            int pSem = Convert.ToInt32(this.lst_psem.SelectedItem.Value);
            int pYear = Convert.ToInt32(this.lst_pyear.SelectedItem.Value);
 
            int i = 0;
            while (i<dd_prerequisites.Items.Count)
            {
                if(dd_prerequisites.Items[i].Selected==true)
                {
                    String courseItem = dd_prerequisites.Items[i].Value;
                    Course preqCourse = new Course(courseItem);
                    preqList.Add(preqCourse);
                    
                }
                i++;

            }
            //Constructing a Course Object
            School school = new School(Convert.ToInt32(lst_school.SelectedItem.Value));
            Course course = new Course(courseCode,courseTitle,cValue,preqList,oEqivalent,school,pYear,pSem,true);
            bool created = course.CreateNewCourse();

            if (created == true)
            {
                Label4.Text = "Course Successfully Created";
            }
            else
            {
                Label4.Text = "Error Creating Course, please make sure that a course with a similar course code does not exist";
            }

            clearFields();
        }

        protected void clearFields()
        {
            txt_course.Text = string.Empty;
            txt_coursecode.Text = string.Empty;
            txt_creditval.Text = string.Empty;
            txt_oua_equivalent.Text = string.Empty;
        }

    }
}