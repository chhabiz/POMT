using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
//using System.Data.Objects.SqlClient;

namespace CurriculumMapping.Admin
{
    public partial class Keys : System.Web.UI.Page
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

        protected void RadComboBox1_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //this.label1.Text = "You Selected" + e.Value + " new keyId ="+ this.getNewKeyId();
        }


        private int getNewKeyId()
        {
            int newId = 7;
            return newId;
        }

        protected void RadListView1_ItemCommand(object sender, RadListViewCommandEventArgs e)
        {
            if (e.CommandName == RadListView.CancelCommandName)
            {
                //label1.Text = "Cancel button";
            }
            else if (e.CommandName == RadListView.UpdateCommandName)
            {
                //label1.Text = "update button";
                RadListView1.EditIndexes.Clear();
                RadListView1.Rebind();
            }
            else if (e.CommandName == RadListView.PerformInsertCommandName)
            {
                //label1.Text = "Insert button";
                RadListView1.InsertItemPosition = RadListViewInsertItemPosition.None;
            }
            else if (e.CommandName == RadListView.EditCommandName)
            {
                RadListView1.InsertItemPosition = RadListViewInsertItemPosition.None;
            }
        }
    }
}