using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Common
{
    public partial class CreateSchool : System.Web.UI.Page
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
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                this.populate_Lst_College();
            }
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Label4.Text = string.Empty;

            //Constructing a School Object
            int collegeOpt = Convert.ToInt32(this.lst_college.SelectedItem.Value);
            School school=new School(txt_school.Text,txt_description.Text,lst_college.SelectedItem.Value,true);
            bool created = school.CreateNewSchool();

            if (created == true)
            {
                Label4.Text = "School Successfully Created";
            }
            else
            {
                Label4.Text = "Error Creating School, please make sure that a school with a similar name does not exist";
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
    }
}