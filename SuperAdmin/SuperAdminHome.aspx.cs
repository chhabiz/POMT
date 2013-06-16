using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.SuperAdmin
{
    public partial class SuperAdminHome : System.Web.UI.Page
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

                if (!userDesignation.Description.Equals("Super Administrator"))
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
    }
}