using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.ProgramAdmin
{
    public partial class CreateOffering : System.Web.UI.Page
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

                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                this.populate_Lst_Program();
                this.populate_Lst_Course();
                this.populate_Lst_Coordinator();
                this.lst_calendaryear.SelectedDate = DateTime.Now;
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

        //Method to populate data into lst_Course during page load

        void populate_Lst_Course()
        {
            //Populate the Course combobox
            String progId = lst_program.SelectedItem.Value;
            List<Course> tempListOpt = Course.GetProgCourses(progId);
            List<Course> formattedList = new List<Course>();
            var query = from Course courseWithCode in tempListOpt
                        select new Course(courseWithCode.Code, String.Format("{0}- {1}", courseWithCode.Code, courseWithCode.Title), courseWithCode.CreditValue, courseWithCode.PrequisiteList, courseWithCode.Qua_Equivalent, courseWithCode.School,courseWithCode.ProgramYear,courseWithCode.ProgramSem, courseWithCode.Active);

            foreach (Course course in query)
            {
                formattedList.Add(course);
            }
            this.lst_course.DataSource = formattedList;
            this.lst_course.DataTextField = "title";
            this.lst_course.DataValueField = "code";
            this.lst_course.DataBind();

        }

        //Method to populate data into lst_Coordinator during page load
        void populate_Lst_Coordinator()
        {
            //Identifies the User Role
            //Display only lecturers from this program
            Staff user = Driver.IdentifyRole(Session);

            try
            {
                List<Lecturer> tempListOpt = Lecturer.getAllLecturers(user.ID.ToString());
                List<Lecturer> filteredList = new List<Lecturer>();
                var query = from Lecturer activeLecturer in tempListOpt
                            where activeLecturer.Active.Equals(true)
                            select new Lecturer(activeLecturer.ID, String.Format("{0} {1}", activeLecturer.FirstName, activeLecturer.LastName), activeLecturer.LastName, activeLecturer.EMailId, activeLecturer.PhoneNumber, activeLecturer.Designation, activeLecturer.Active);

                foreach (Lecturer lect in query)
                {
                    filteredList.Add(lect);
                }

                this.lst_coordinator.DataSource = filteredList;
                this.lst_coordinator.DataTextField = "FirstName";
                this.lst_coordinator.DataValueField = "ID";
                this.lst_coordinator.DataBind();
            }
            catch (Exception)
            {
                this.lst_coordinator.DataSource = null;
            }
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Label4.Text = string.Empty;

            List<Course> preqList = new List<Course>();
            String coCode = this.lst_course.SelectedItem.Value;
            String poCode = this.lst_program.SelectedItem.Value;
            DateTime calYear = Convert.ToDateTime(this.lst_calendaryear.SelectedDate.Value);
            int calSem = Convert.ToInt32(this.lst_calsem.SelectedItem.Value);
            int progYear = Convert.ToInt32(this.lst_pyear.SelectedItem.Value);
            int progSem = Convert.ToInt32(this.lst_psem.SelectedItem.Value);
            String Coord = this.lst_coordinator.SelectedItem.Value;
            bool ctaught = Convert.ToBoolean(this.lst_cotaught.SelectedItem.Value);
            String syllab = this.txt_syllabus.Text;

            //Constructing a Course Offering Object
            Course course = new Course(coCode);
            Program program = new Program(poCode);
            Lecturer lect = new Lecturer(Coord);
            CourseOffering coff = new CourseOffering(course,program, calYear, calSem, progYear, progSem, lect, ctaught, syllab, true);

            // Check if course offering exists for the current calendar year, calendar sem and course id
            // If yes, do not create one, else create
            int courseOfferingExists = 0;
            courseOfferingExists = coff.checkCourseOfferingExists(course.Code, calYear.Year, calSem);

            if (courseOfferingExists == 1)
            {
                Label4.Text = "A course offering for the Calendar Year and Calendar Semester already exists, duplicates not allowed";
            }
            else
            {
                int coffId = coff.CreateNewOffering();
                CourseOffering coffering = new CourseOffering(coffId);
                //Create and send the Form to the Lecturer
                FormStatus createStatus = new FormStatus('C');
                MyForm form = new MyForm(coffering, createStatus, DateTime.Now, txt_comments.Text);
                form.CreateNewForm();

                if (coffId == 0)
                {
                    Label4.Text = "Error creating course offering";
                }
                else
                {
                    Label4.Text = "Form for new Course Offering has been successfully sent to the Lecturer";
                }
            }

            clearFields();
        }

        protected void clearFields()
        {
            txt_syllabus.Text = string.Empty;
            txt_comments.Text = string.Empty;
        }

        protected void lst_prog_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Populate the Course combobox
            String progId = lst_program.SelectedItem.Value;
            List<Course> tempListOpt = Course.GetProgCourses(progId);
            this.lst_course.DataSource = tempListOpt;
            this.lst_course.DataTextField = "title";
            this.lst_course.DataValueField = "code";
            this.lst_course.DataBind();
        }

        protected void lst_prog_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //Populate the Course combobox
            String progId = lst_program.SelectedItem.Value;
            List<Course> tempListOpt = Course.GetProgCourses(progId);
            this.lst_course.DataSource = tempListOpt;
            this.lst_course.DataTextField = "title";
            this.lst_course.DataValueField = "code";
            this.lst_course.DataBind();
        }
    }
}