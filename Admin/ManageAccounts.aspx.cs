using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.Admin
{
    public partial class ManageAccounts : System.Web.UI.Page
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

                    hiddenfieldadminid.Value = user.ID.ToString();

                    RadFilterTextFieldEditor emailFieldEditor = new RadFilterTextFieldEditor();
                    emailFieldEditor.FieldName = "emailid";
                    emailFieldEditor.DisplayName = "emailid";
                    emailFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(emailFieldEditor);

                    RadFilter1.DataBind();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        //Method to get designation Information

        public String getDesignation(Object designationId)
        {
            int desigId = Convert.ToInt32(designationId);
            Designation designation = new Designation(desigId);
            return designation.Description;
        }
    }
}