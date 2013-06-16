using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.SuperAdmin
{
    public partial class CreateCollege : System.Web.UI.Page
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


        //If Submit Button is Clicked
        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            //Constructing a College Object
            College coll = new College(txt_collegename.Text.Trim(),txt_collegedesc.Text.Trim(),true);
            bool created = coll.CreateNewCollege();

            if (created == true)
            {
                Label1.Text = "College Successfully Created";
            }
            else
            {
                Label1.Text = "Error Creating College, please check if the college name already exists";
            }

            clearFields();
        }

        protected void clearFields()
        {
            txt_collegename.Text = string.Empty;
            txt_collegedesc.Text = string.Empty;
        }
    }
}