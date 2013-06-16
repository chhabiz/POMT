using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CurriculumMapping
{
    public partial class UnauthorizedPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //Identifies the User Role
                Staff user = Driver.IdentifyRole(Session);

                //Creates a User Designation Object
                Designation userDesignation = new Designation();
                userDesignation = user.Designation;

                if (userDesignation.Description.Equals("Super Administrator"))
                {
                    //Link to go back to home page of super admin
                    anchorHome.HRef = "SuperAdmin/SuperAdminHome.aspx";
                }
                else if(userDesignation.Description.Equals("Administrator"))
                {
                    //Link to go back to home page of super admin
                    anchorHome.HRef = "Admin/AdminHome.aspx";
                }
                else if (userDesignation.Description.Equals("Program Manager"))
                {
                    //Link to go back to home page of super admin
                    anchorHome.HRef = "ProgramAdmin/ProgramAdminHome.aspx";
                }
                else if (userDesignation.Description.Equals("Lecturer"))
                {
                    //Link to go back to home page of super admin
                    anchorHome.HRef = "LecturerStaff/LecturerStaffHome.aspx";
                }
            }
            catch (Exception)
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }
}