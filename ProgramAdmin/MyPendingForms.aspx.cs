using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.ProgramAdmin
{
    public partial class MyPendingForms : System.Web.UI.Page
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

                    if (!(userDesignation.Description.Equals("Program Manager")) && !(userDesignation.Description.Equals("Administrator")))
                    {
                        //UnAuthorized Access Page.
                        Response.Redirect("../UnauthorizedPage.aspx", false);
                    }
                    this.HiddenField1.Value = user.ID;

                    // This basically removes the fieldeditors as below (although for some reason the .add() method removes them!)
                    //Currently RadFilter can be integrated only with LinqDataSource, EntityDataSource and OpenAccessDataSource.
                    //It does not provide support for inherited data source controls.
                    //To overcome the issue, you can try handling the ApplyExpressions event manually.

                    RadFilterTextFieldEditor courseFieldEditor = new RadFilterTextFieldEditor();
                    courseFieldEditor.FieldName = "CourseOffering";
                    courseFieldEditor.DisplayName = "CourseOffering";
                    courseFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(courseFieldEditor);

                    RadFilterTextFieldEditor statusFieldEditor = new RadFilterTextFieldEditor();
                    statusFieldEditor.FieldName = "Status";
                    statusFieldEditor.DisplayName = "Status";
                    statusFieldEditor.DataType = typeof(char);
                    RadFilter1.FieldEditors.Add(statusFieldEditor);
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }

            }
        }

        //This method determines the URL of the page the user- 
        //needs to be directed to for that particular Course Offering

        public String determineURL(Object statusIdObj, Object OfferingObj, Object TitleString)
        {
            String statusId = statusIdObj.ToString();
            String offerId = OfferingObj.ToString();
            int offerIdInt = Convert.ToInt32(OfferingObj);
            String titleStr = TitleString.ToString();
            String URL = "";
            CourseOffering coff = new CourseOffering(offerIdInt);
            Staff user = Driver.IdentifyRole(Session);
            if (statusId.Equals("C"))
            {
                if (coff.Coordinator.ID.Equals(user.ID))
                {
                    int coffering = CourseOffering.GetLastOfferingOfCourse(offerIdInt).Id;
                    URL = "GenerateNewForm.aspx?id=" + offerId + "&C=1&CF=" + coffering;
                }
                else
                {
                    URL = "";
                }

            }
            else if (statusId.Equals("E"))
            {
                if (coff.Coordinator.ID.Equals(user.ID))
                {
                    URL = "GenerateNewForm.aspx?id=" + offerId + "&C=1&CF=" + offerId;
                }
                else
                {
                    URL = "";
                }
            }
            else if (statusId.Equals("S"))
            {
                URL = "ViewForm.aspx?id=" + offerId + "&title=" + titleStr;
            }
            else if (statusId.Equals("R"))
            {
                if (coff.Coordinator.ID.Equals(user.ID))
                {
                    URL = "GenerateNewForm.aspx?id=" + offerId + "&C=1&CF=" + offerId;
                }
                else
                {
                    URL = "";
                }
            }
            else if (statusId.Equals("A"))
            {
                URL = "ViewForm.aspx?id=" + offerId + "&title=" + titleStr;
            }
            return URL;
        }
    }
}