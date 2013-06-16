
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Collections.ObjectModel;


public class Lecturer : Staff
{
    //Default Constructor
    public Lecturer()
    {
    }

    //Setting Up a Lecturer Object
	public Lecturer(string Id,string firstName,string lastName, string emailId, string phoneNumber, Designation designation,bool active)
	{
        //Setting the Instance Variables
        this.ID = Id;
        this.FirstName = firstName;
        this.LastName = lastName;
        this.EMailId = emailId;
        this.PhoneNumber = phoneNumber;
        this.Designation = designation;
        this.Active = active;
	}

    //Setting Up a Lecturer Object using StaffId
    public Lecturer(string Id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure RetrieveStaffById to Retrieve Staff Details
        SqlCommand sqlcom = new SqlCommand("RetrieveStaffById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlParameter idParam = new SqlParameter("@Id", Id.Trim());
        sqlcom.Parameters.Add(idParam);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with the Query Result
        sqlda.Fill(ds);
        sqlcon.Close();

        //Constructing the Administrator Object
        this.ID = ds.Tables[0].Rows[0]["StaffId"].ToString();
        this.FirstName = ds.Tables[0].Rows[0]["FirstName"].ToString();
        this.LastName = ds.Tables[0].Rows[0]["LastName"].ToString();
        this.EMailId = ds.Tables[0].Rows[0]["EmailId"].ToString();
        this.PhoneNumber = ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
        this.Active = true;

        //Get the Integral Representation of Designation from Staff Class
        int designation = Convert.ToInt32(ds.Tables[0].Rows[0]["Designation"].ToString());

        sqlcom.CommandText = "RetrieveDesignationById";
        sqlcom.CommandType = CommandType.StoredProcedure;


        //Changing the IdParam (Parameter for Id)
        idParam.Value = designation;

        string description;

        try
        {
            sqlcon.Open();

            //Get the string Representation of the Designation
            description = Convert.ToString(sqlcom.ExecuteScalar());
            //Setting Up the Staff Designation Object and Setting it to the Designation Attribute of Staff
            this.Designation = new Designation(designation, description);
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Create a New Lecturer
    public bool CreateLecturer(String staffID)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        int designation;

        //Query to Retrieve the intergral Representation of Designation
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Description", "Lecturer");

        try
        {
            sqlcon.Open();
            //Retrieving the intergral Representation of Designation
            designation = Convert.ToInt32(sqlcom.ExecuteScalar());

            sqlcon.Close();

            //Inserting New Staff Record
            sqlcom = new SqlCommand("InsertNewStaff", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;

            sqlcom.Parameters.AddWithValue("@Id", this.Id);
            sqlcom.Parameters.AddWithValue("@FirstName", this.FirstName);
            sqlcom.Parameters.AddWithValue("@LastName", this.LastName);
            sqlcom.Parameters.AddWithValue("@EmailId", this.EMailId);
            sqlcom.Parameters.AddWithValue("@PhoneNumber", this.PhoneNumber);
            sqlcom.Parameters.AddWithValue("@Designation", designation);
            sqlcom.Parameters.AddWithValue("@Active", "True");
            sqlcom.Parameters.AddWithValue("@adminid", staffID);
            // CHECK THIS ONE
            // sqlcom.Connection = sqlcon;

            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            return true;
        }
        catch (Exception)
        {
            return false;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Create a New Lecturer from Program Admin
    public bool CreateLecturer2(String staffID)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        int designation;

        //Query to Retrieve the intergral Representation of Designation
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Description", "Lecturer");

        try
        {
            sqlcon.Open();
            //Retrieving the intergral Representation of Designation
            designation = Convert.ToInt32(sqlcom.ExecuteScalar());

            sqlcon.Close();

            //Inserting New Staff Record
            sqlcom = new SqlCommand("InsertNewLecturerStaff", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;

            sqlcom.Parameters.AddWithValue("@Id", this.Id);
            sqlcom.Parameters.AddWithValue("@FirstName", this.FirstName);
            sqlcom.Parameters.AddWithValue("@LastName", this.LastName);
            sqlcom.Parameters.AddWithValue("@EmailId", this.EMailId);
            sqlcom.Parameters.AddWithValue("@PhoneNumber", this.PhoneNumber);
            sqlcom.Parameters.AddWithValue("@Designation", designation);
            sqlcom.Parameters.AddWithValue("@Active", "True");
            sqlcom.Parameters.AddWithValue("@adminid", staffID);
            // CHECK THIS ONE
            // sqlcom.Connection = sqlcon;

            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            return true;
        }
        catch (Exception)
        {
            return false;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Deactivate a Lecturer
    public bool DeactivateLecturer()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate Staff
        SqlCommand sqlcom = new SqlCommand("DeactivateStaff", sqlcon);
        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteNonQuery();

            return true;
        }
        catch (Exception)
        {
            return false;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Reactivate a Lecturer If Deactivate
    public bool ReactivateLecturer()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Procedure to Reactivate Staff
        SqlCommand sqlcom = new SqlCommand("ReactivateStaff", sqlcon);
        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            return true;
        }
        catch (Exception)
        {
            return false;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Get All Lecturers (modified to get all lecturers under the current program admin) - 22/10/2012
    public static List<Lecturer> getAllLecturers(String progAdminId)
    {
        //Temporary lecturer List
        List<Lecturer> lecturerList = new List<Lecturer>();
        Lecturer lecturer;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Administrators
        SqlCommand sqlcom = new SqlCommand("GetAllLecturers", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@progadminid", progAdminId);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Lecturer's Details
            sqlda.Fill(ds);

            //Iterating through all the Lecturers
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Lecturer Object
                lecturer = new Lecturer();

                //Setting values to the Administrator Object
                lecturer.ID = Convert.ToString(dataRow["StaffId"]);
                lecturer.FirstName = Convert.ToString(dataRow["FirstName"]);
                lecturer.LastName = Convert.ToString(dataRow["LastName"]);
                lecturer.EMailId = Convert.ToString(dataRow["EmailId"]);
                lecturer.PhoneNumber = Convert.ToString(dataRow["PhoneNumber"]);
                lecturer.Designation = new Designation(Convert.ToInt32(dataRow["Designation"]));
                lecturer.Active = Convert.ToBoolean(dataRow["Active"]);

                //Adding the Admin to the Admin List
                lecturerList.Add(lecturer);
            }

            return lecturerList;
        }
        catch (Exception)
        {
            return lecturerList;
        }
        finally
        {
            sqlcon.Close();
        }
        
    }
}
