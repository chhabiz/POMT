using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.Admin
{
    public partial class ManageSchool : System.Web.UI.Page
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
                    College coll = new College(user.ID);
                    this.HiddenField1.Value = Convert.ToString(coll.Id);

                    // This basically removes the fieldeditors as below (although for some reason the .add() method removes them!)
                    //Currently RadFilter can be integrated only with LinqDataSource, EntityDataSource and OpenAccessDataSource.
                    //It does not provide support for inherited data source controls.
                    //To overcome the issue, you can try handling the ApplyExpressions event manually.

                    RadFilterTextFieldEditor collegeFieldEditor = new RadFilterTextFieldEditor();
                    collegeFieldEditor.FieldName = "College";
                    collegeFieldEditor.DisplayName = "College";
                    collegeFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(collegeFieldEditor);

                    RadFilter1.DataBind();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                //Get the College ID assigned to the Administrator to get all the Schools under it

            }
        }
    }
}