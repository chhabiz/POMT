using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.SuperAdmin
{
    public partial class ListAdmins : System.Web.UI.Page
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

                // This basically removes the fieldeditors as below (although for some reason the .add() method removes them!)
                //Currently RadFilter can be integrated only with LinqDataSource, EntityDataSource and OpenAccessDataSource.
                //It does not provide support for inherited data source controls.
                //To overcome the issue, you can try handling the ApplyExpressions event manually.

                RadFilterTextFieldEditor designationFieldEditor = new RadFilterTextFieldEditor();
                designationFieldEditor.FieldName = "Designation";
                designationFieldEditor.DisplayName = "Designation";
                designationFieldEditor.DataType = typeof(string);
                RadFilter1.FieldEditors.Add(designationFieldEditor);
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        //protected void btn_Update_Click(object sender, EventArgs e)
        //{
        //    //Iterating through all the GridView Rows
        //    foreach (GridViewRow gvr in GridViewListAdmins.Rows)
        //    {
        //        //Finding the Controls
        //        CheckBox active = (CheckBox)gvr.FindControl("cbk_Active");
        //        Label Id = (Label)gvr.FindControl("lbl_Id");

        //        //Create a Administrator Object
        //        Administrator admin = new Administrator(Id.Text.Trim());

        //        //Check the Checkbox Status
        //        if (active.Checked)
        //        {
        //            //Reactivate if Checked
        //            admin.ReactivateAdministrator();
        //            lbl_msg.Text = "Action Successfully Performed";
        //        }
        //        else
        //        {
        //            //Deactivate if UnChecked
        //            admin.DeactivateAdministrator();
        //            lbl_msg.Text = "Action Successfully Performed";
        //        }
        //    }

        //}

      
    }
}