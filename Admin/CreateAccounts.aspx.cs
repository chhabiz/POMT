﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CurriculumMapping.Admin
{
    public partial class CreateAccounts : System.Web.UI.Page
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

                    List<String> desig = new List<string>();
                    desig.Add("Program Manager");
                    desig.Add("Staff");

                    DropDownListDesignation.DataSource = desig;
                    DropDownListDesignation.DataBind();

                }
                catch (Exception)
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        //If Submit Button is Clicked
        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            status.Text = string.Empty;

            String id = txt_ID.Text.Trim().ToString();
            String password = txt_password.Text.ToString();
            String firstname = txt_firstname.Text.Trim().ToString();
            String lastname = txt_lastname.Text.Trim().ToString();
            String email = txt_email.Text.Trim().ToString();
            String phone = txt_phone.Text.Trim().ToString();
            Staff user = Driver.IdentifyRole(Session);
            bool create = false;

            try
            {
                if (DropDownListDesignation.SelectedItem.Text.ToString().Equals("Program Manager"))
                {
                    //Constructing a Program Manager Object
                    ProgramManager pm = new ProgramManager(id, firstname, lastname, email, phone, new Designation("Program Manager"), true);
                    create = pm.CreateProgramManager(user.ID.ToString());
                }
                else
                {
                    //Constructing a Lecturer Object (for Staff)
                    Lecturer lct = new Lecturer(id, firstname, lastname, email, phone, new Designation("Staff"), true);
                    create = lct.CreateLecturer(user.ID.ToString());
                }

                //Create New Password Authentication for newly Created Account
                bool passCreate = Driver.CreateNewStaffIdPasswordPair(id, password);

                if (create == true && passCreate == true)
                {
                    status.Text = DropDownListDesignation.SelectedValue.ToString() + " Successfully Created";
                }
                else
                {
                    status.Text = "Unable to create account, please check if the user already exists from the manage accounts page";
                }

                clearFields();
            }
            catch (Exception)
            {
                status.Text = "Unable to create account, please check if the user already exists from the manage accounts page";
            }
        }

        protected void clearFields()
        {
            txt_ID.Text = string.Empty;
            txt_firstname.Text = string.Empty;
            txt_lastname.Text = string.Empty;
            txt_password.Text = string.Empty;
            txt_phone.Text = string.Empty;
            txt_email.Text = string.Empty;
            txt_retype_password.Text = string.Empty;
        }
    }
}