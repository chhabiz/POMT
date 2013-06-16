using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.SuperAdmin
{
    public partial class CreateArchive : System.Web.UI.Page
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
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
            }

        }

        protected void btn_createArchive_Click(object sender, EventArgs e)
        {
            String snName="Archive as on:"+DateTime.Now.Date;
            DateTime timeStamp = DateTime.Now;
            Snapshot snshot = new Snapshot(snName,timeStamp);
            snshot.CreateNewSnapshot();
            Label1.Text = "Archive Successfully created on:"+DateTime.Now;
            btn_createArchive.Visible = false;
        }
    }
}