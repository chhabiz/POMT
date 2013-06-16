using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.Admin
{
    public partial class ManageCourse : System.Web.UI.Page
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

                    RadFilterTextFieldEditor preReqFieldEditor = new RadFilterTextFieldEditor();
                    preReqFieldEditor.FieldName = "PrequisiteList";
                    preReqFieldEditor.DisplayName = "PrequisiteList";
                    preReqFieldEditor.DataType = typeof(Course);
                    RadFilter1.FieldEditors.Add(preReqFieldEditor);

                    RadFilterTextFieldEditor ouaFieldEditor = new RadFilterTextFieldEditor();
                    ouaFieldEditor.FieldName = "Qua_Equivalent";
                    ouaFieldEditor.DisplayName = "Qua_Equivalent";
                    ouaFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(ouaFieldEditor);

                    RadFilterTextFieldEditor schoolFieldEditor = new RadFilterTextFieldEditor();
                    schoolFieldEditor.FieldName = "School";
                    schoolFieldEditor.DisplayName = "School";
                    schoolFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(schoolFieldEditor);

                    RadFilter1.DataBind();
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                this.populate_Lst_School();
            }
        }

        //Method to populate data into lst_school during page load

        void populate_Lst_School()
        {
            //Identifies the User Role
            Staff user = Driver.IdentifyRole(Session);
            College coll = new College(user.ID);
            List<School> tempListOpt = School.GetAllSchools(coll.Id);
            this.lst_school.DataSource = tempListOpt;
            this.lst_school.DataTextField = "name";
            this.lst_school.DataValueField = "id";
            this.lst_school.DataBind();

        }

        protected void lst_school_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (Page.IsPostBack)
            {
                this.lst_school.SelectedItem.Value = e.Value;
                this.lst_school.SelectedItem.Text = e.Text;
                
            }
        }
    }
}