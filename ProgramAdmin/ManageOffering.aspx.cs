using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CurriculumMapping.ProgramAdmin
{
    public partial class ManageOffering : System.Web.UI.Page
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

                    populate_Lst_Program();
                    this.HiddenField1.Value = lst_program.SelectedItem.Value.ToString();                    

                    // This basically removes the fieldeditors as below (although for some reason the .add() method removes them!)
                    //Currently RadFilter can be integrated only with LinqDataSource, EntityDataSource and OpenAccessDataSource.
                    //It does not provide support for inherited data source controls.
                    //To overcome the issue, you can try handling the ApplyExpressions event manually.

                    RadFilterTextFieldEditor courseFieldEditor = new RadFilterTextFieldEditor();
                    courseFieldEditor.FieldName = "Course";
                    courseFieldEditor.DisplayName = "Course";
                    courseFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(courseFieldEditor);
                    
                    RadFilterTextFieldEditor calSemFieldEditor = new RadFilterTextFieldEditor();
                    calSemFieldEditor.FieldName = "CalendarSem";
                    calSemFieldEditor.DisplayName = "CalendarSem";
                    calSemFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(calSemFieldEditor);

                    RadFilterTextFieldEditor syllabusFieldEditor = new RadFilterTextFieldEditor();
                    syllabusFieldEditor.FieldName = "Syllabus";
                    syllabusFieldEditor.DisplayName = "Syllabus";
                    syllabusFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(syllabusFieldEditor);

                    RadFilterTextFieldEditor coordFieldEditor = new RadFilterTextFieldEditor();
                    coordFieldEditor.FieldName = "Coordinator";
                    coordFieldEditor.DisplayName = "Coordinator";
                    coordFieldEditor.DataType = typeof(string);
                    RadFilter1.FieldEditors.Add(coordFieldEditor);

                    RadFilterBooleanFieldEditor activeFieldEditor = new RadFilterBooleanFieldEditor();
                    activeFieldEditor.FieldName = "Active";
                    activeFieldEditor.DisplayName = "Active";
                    activeFieldEditor.DataType = typeof(Boolean);
                    RadFilter1.FieldEditors.Add(activeFieldEditor);

                    RadFilter1.DataBind();

                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                
            }
        }

        //Method to populate data into lst_Program during page load
        void populate_Lst_Program()
        {
            //Identifies the User Role
            ProgramManager me = new ProgramManager(Driver.IdentifyRole(Session).ID);
            List<Program> myPrograms = Driver.MyProgramList(me);
            List<Program> progList = new List<Program>();
            var query = from Program progWithCode in myPrograms
                        select new Program(progWithCode.Code, progWithCode.School, String.Format("{0}- {1}", progWithCode.Code, progWithCode.Name), progWithCode.Description, progWithCode.Active, progWithCode.ProgramManager);

            foreach (Program prog in query)
            {
                progList.Add(prog);
            }
            this.lst_program.DataSource = progList;
            this.lst_program.DataTextField = "name";
            this.lst_program.DataValueField = "code";
            this.lst_program.DataBind();

        }

        protected void lst_prog_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            this.HiddenField1.Value = lst_program.SelectedItem.Value.ToString();
            ObjectDataSource1.DataBind();
        }
    }
}