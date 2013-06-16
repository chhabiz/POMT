using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.Admin
{
    public partial class AssignProgramAdmin : System.Web.UI.Page
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
                this.HiddenField1.Value = user.ID;
                College coll=new College(user.ID);
                this.HiddenField2.Value = coll.Id.ToString();

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
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Assign")
            {
                //Getting the Index
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[index];
                
                //Finding the Controls and Getting the Values
                RadComboBox adminList = (RadComboBox)row.FindControl("ddl_ProgAdmin");
                Label program = (Label)row.FindControl("lbl_ProgramId");

                string programId = program.Text.Trim();
                string newAdmin= adminList.SelectedItem.Value;

                //Creating Objects
                Program tempProgram = new Program(Convert.ToString(programId));
                ProgramManager tempAdmin = new ProgramManager(newAdmin);

                //Set New Program Manager to the Program
                tempProgram.AssignProgramManager(tempAdmin);

                GridView1.DataBind();
            }
        }
    }
}