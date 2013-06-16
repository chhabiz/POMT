using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.SuperAdmin
{
    public partial class AssignAdmin : System.Web.UI.Page
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Assign")
            {
                //Getting the Index
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[index];
                
                //Finding the Controls and Getting the Values
                RadComboBox adminList = (RadComboBox)row.FindControl("ddl_Admin");
                Label college = (Label)row.FindControl("lbl_CollegeId");

                string collegeId = college.Text.Trim();
                string newAdmin= adminList.SelectedItem.Value;

                //Creating Objects
                College tempCollege = new College(Convert.ToInt32(collegeId));
                Administrator tempAdmin = new Administrator(newAdmin);

                //Set New Admin to the College
                tempCollege.AssignAdmin(tempAdmin);

                GridView1.DataBind();
            }
        }
    }
}