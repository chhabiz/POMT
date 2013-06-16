using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Common
{
    public partial class CreatePAC : System.Web.UI.Page
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
                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
                this.populate_Lst_Category();
            }
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            Label4.Text = string.Empty;

            //Constructing a SpecificationAttributeOption Object
            int attribOptId = Convert.ToInt32(this.lst_category.SelectedItem.Value);
            SpecificationAttribute sattrib = new SpecificationAttribute(attribOptId);
            SpecificationAttributeOption soption = new SpecificationAttributeOption(sattrib,this.txt_pacgroup.Text,true);
            bool created = soption.CreateNewSpecificationAttributeOption();

            if (created == true)
            {
                Label4.Text = "PAC Group Successfully Created";
            }
            else
            {
                Label4.Text = "Error Creating PAC Group, please make sure that a Group with a similar name does not exist";
            }
        }

        //Method to populate data into lst_Category during page load

        void populate_Lst_Category()
        {
            SpecificationAttribute spattribute = new SpecificationAttribute(10);
            List<SpecificationAttribute> tempListOpt = new List<SpecificationAttribute>();
            tempListOpt.Add(spattribute);
            this.lst_category.DataSource = tempListOpt;
            this.lst_category.DataTextField = "name";
            this.lst_category.DataValueField = "id";
            this.lst_category.DataBind();

        }
    }
}