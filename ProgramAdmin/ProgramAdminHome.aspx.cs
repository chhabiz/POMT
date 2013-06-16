using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.ProgramAdmin
{
    public partial class ProgramAdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //FormStatus fs = new FormStatus('C');
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

                // Check if the user is active and redirect accordingly
                Boolean active = Driver.VerifyUserStatus(user.ID.ToString());
                if (active == false)
                {
                    Response.Redirect("../InactiveUser.aspx", false);
                }

                lblLoggedInUser.Text = user.ID.ToString() + " - " + user.FirstName.ToString() + " " + user.LastName.ToString();
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        protected void butSelectLoginRole_Click(object sender, EventArgs e)
        {
            string val = comboLoginRoles.SelectedItem.Text.ToString();
            string redirectURL = "";

            Staff user = Driver.IdentifyRole(Session);

            //Creates a User Designation Object
            Designation userDesignation = new Designation();
            userDesignation = user.Designation;

            bool testSwitch = Driver.validSwitch(userDesignation.Description.ToString(), val.ToString());
            

            if (testSwitch == true)
            {
                if (val.ToString().Equals("Program Manager"))
                    redirectURL = "../" + "ProgramAdmin/ProgramAdminHome.aspx";
                else if (val.ToString().Equals("Administrator"))
                    redirectURL = "../" + "Admin/AdminHome.aspx";
                else if (val.ToString().Equals("Staff"))
                    redirectURL = "../" + "LecturerStaff/LecturerStaffHome.aspx";

                Response.Redirect(redirectURL);
            }
            else
            {
                lblSwitchMessage.Text = "Sorry you do not have sufficient privileges to switch!";
                lblSwitchMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}