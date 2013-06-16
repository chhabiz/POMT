using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1;

namespace CurriculumMapping
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Designation userDesignation;

            //Authenticating using the Provided Authentication Details
            bool authResult= Driver.Authenticate(txt_Staff.Text.Trim(), txt_Password.Text.Trim());

            if (authResult == true)
            {
                //Getting User Designation
                userDesignation = Driver.GetUserDesignation(txt_Staff.Text.Trim());

                //Creating the User Object based on the Role to Store it in the Session
                if (userDesignation.Description.Equals("Super Administrator"))
                {
                    SuperAdministrator superAdmin = new SuperAdministrator(txt_Staff.Text.Trim());
                    Session["CMT_User"] = superAdmin;
                    Response.Redirect("SuperAdmin/SuperAdminHome.aspx");
                }
                else if (userDesignation.Description.Equals("Administrator"))
                {
                    Administrator admin = new Administrator(txt_Staff.Text.Trim());
                    Session["CMT_User"] = admin;
                    Response.Redirect("Admin/AdminHome.aspx");
                }
                else if (userDesignation.Description.Equals("Program Manager"))
                {
                    ProgramManager programManager = new ProgramManager(txt_Staff.Text.Trim());
                    Session["CMT_User"] = programManager;
                    Response.Redirect("ProgramAdmin/ProgramAdminHome.aspx");
                }
                else
                {
                    Lecturer lecturer = new Lecturer(txt_Staff.Text.Trim());
                    Session["CMT_User"] = lecturer;
                    Response.Redirect("LecturerStaff/LecturerStaffHome.aspx");
                }
            }
            else
            {
                txt_Staff.Text = "Authentication Failed";
                txt_Password.Text = "Authentication Failed";
            }
        }
    }
}