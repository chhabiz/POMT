using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;


namespace CurriculumMapping.SuperAdmin
{
    public partial class ListColleges : System.Web.UI.Page
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

                RadFilterTextFieldEditor adminFieldEditor = new RadFilterTextFieldEditor();
                adminFieldEditor.FieldName = "Admin";
                adminFieldEditor.DisplayName = "Admin";
                adminFieldEditor.DataType = typeof(string);
                RadFilter1.FieldEditors.Add(adminFieldEditor);
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
            }
        }
    }
}