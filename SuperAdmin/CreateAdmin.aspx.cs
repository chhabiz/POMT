using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.SuperAdmin
{
    public partial class CreateAdmin : System.Web.UI.Page
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
            }
            catch (Exception)
            {
                Response.Redirect("../Login.aspx");
            }  
        }


        //If Submit Button is Clicked
        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            String id = txt_staffId.Text.Trim().ToString();
            String password = txt_password.Text.ToString();
            String firstname = txt_firstname.Text.Trim().ToString();
            String lastname = txt_lastname.Text.Trim().ToString();
            String email = txt_email.Text.Trim().ToString();
            String phone = txt_phone.Text.Trim().ToString();
            Staff user = Driver.IdentifyRole(Session);

            //Constructing an Admin Object
            Administrator admin = new Administrator(id, firstname, lastname, email, phone, new Designation("Administrator"), true);
            
            //Checking if Staff Already Exist with the Provided Id
            if (!Driver.CheckStaffIdExist(admin))
            {
                admin.CreateAdministrator(id);

                //Create New Password Authentication for newly Created Admin, Password is (staffId + first two letter of first Name + First two Letters of Last Name)
                Driver.CreateNewStaffIdPasswordPair(id, password);

                Label1.Text = "Administrator Successfully Created";

                clearFields();
            }
            else
            {
                Label1.Text = "An administrator with the specified ID already exists";
            }
        }

        protected void clearFields()
        {
            txt_staffId.Text = string.Empty;
            txt_firstname.Text = string.Empty;
            txt_lastname.Text = string.Empty;
            txt_password.Text = string.Empty;
            txt_phone.Text = string.Empty;
            txt_email.Text = string.Empty;
            txt_retype_password.Text = string.Empty;
        }
    }
}