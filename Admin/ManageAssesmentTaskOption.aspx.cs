using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


namespace CurriculumMapping.Admin
{
    public partial class ManageAssesmentTaskOption : System.Web.UI.Page
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

                    // This basically removes the fieldeditors as below (although for some reason the .add() method removes them!)
                    //Currently RadFilter can be integrated only with LinqDataSource, EntityDataSource and OpenAccessDataSource.
                    //It does not provide support for inherited data source controls.
                    //To overcome the issue, you can try handling the ApplyExpressions event manually.

                    RadFilterTextFieldEditor keyFieldEditor = new RadFilterTextFieldEditor();
                    keyFieldEditor.FieldName = "Key";
                    keyFieldEditor.DisplayName = "Key";
                    keyFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(keyFieldEditor);

                    RadFilterTextFieldEditor specFieldEditor = new RadFilterTextFieldEditor();
                    specFieldEditor.FieldName = "SpecificationAttributeOption";
                    specFieldEditor.DisplayName = "SpecificationAttributeOption";
                    specFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(specFieldEditor);

                    RadFilter1.DataBind();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
    }
}