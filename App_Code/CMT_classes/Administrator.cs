
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class Administrator : Staff
{

    //Default Constructor
    public Administrator()
    {

    }

    //Constructing an Administrator Object
    public Administrator(string Id, string firstName, string lastName, string emailId, string phoneNumber, Designation designation, bool active)
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


    //Constructing an Administrator object using Id
    public Administrator(string Id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure RetrieveStaffById to Retrieve Staff Details
        SqlCommand sqlcom = new SqlCommand("RetrieveStaffById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlParameter idParam = new SqlParameter("@Id", Id.Trim());
        sqlcom.Parameters.Add(idParam);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with the Query Result
            sqlda.Fill(ds);
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }

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


    //Create New Administrator
    public bool CreateAdministrator(String staffID)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        int designation;

        //Query to Retrieve the intergral Representation of Designation
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Description", "Administrator"));

        try
        {
            sqlcon.Open();
            //Retrieving the intergral Representation of Designation
            designation = Convert.ToInt32(sqlcom.ExecuteScalar());
            sqlcon.Close();

            //Inserting New Staff Record
            sqlcom = new SqlCommand("InsertNewAdmin", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;

            sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));
            sqlcom.Parameters.Add(new SqlParameter("@FirstName", this.FirstName));
            sqlcom.Parameters.Add(new SqlParameter("@LastName", this.LastName));
            sqlcom.Parameters.Add(new SqlParameter("@EmailId", this.EMailId));
            sqlcom.Parameters.Add(new SqlParameter("@PhoneNumber", this.PhoneNumber));
            sqlcom.Parameters.Add(new SqlParameter("@Designation", designation));
            sqlcom.Parameters.Add(new SqlParameter("@Active", "True"));
            sqlcom.Parameters.Add(new SqlParameter("@adminid", staffID));

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


    //Deactivate an Administrator
    public bool DeactivateAdministrator()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate Staff
        SqlCommand sqlcom = new SqlCommand("DeactivateStaff", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

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




    //Reactivate an Administrator
    public bool ReactivateAdministrator()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Procedure to Reactivate Staff
        SqlCommand sqlcom = new SqlCommand("ReactivateStaff", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            return true;
        }
        catch(Exception)
        {
            return false;
        }
        finally
        {
        sqlcon.Close();
        }
    }

    //Get All Admini Ids
    public static List<string> getAllAdminIds()
    {
        //Temporary Administrator Ids List
        List<string> adminList = new List<string>();
        string admin;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Administrator Ids
        SqlCommand sqlcom = new SqlCommand("GetAllAdministratorIds", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Admin's Ids
            sqlda.Fill(ds);
            //Iterating through all the Admin
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                admin = Convert.ToString(dataRow["StaffId"]);

                //Adding the Admin to the Admin Ids List
                adminList.Add(admin);
            }

            return adminList;
        }
        catch (Exception)
        {
            return adminList;
        }
        finally
        {
            sqlcon.Close();
        }

    }

    //Get All Administrators
    public static List<Administrator> getAllAdministrators()
    {
        //Temporary Administrator List
        List<Administrator> adminList = new List<Administrator>();
        Administrator admin;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Administrators
        SqlCommand sqlcom = new SqlCommand("GetAllAdministrators", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Admin's Details
            sqlda.Fill(ds);
            //Iterating through all the Admin
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Admin Object
                admin = new Administrator();

                //Setting values to the Administrator Object
                admin.ID = Convert.ToString(dataRow["StaffId"]);
                admin.FirstName = Convert.ToString(dataRow["FirstName"]);
                admin.LastName = Convert.ToString(dataRow["LastName"]);
                admin.EMailId = Convert.ToString(dataRow["EmailId"]);
                admin.PhoneNumber = Convert.ToString(dataRow["PhoneNumber"]);
                admin.Designation = new Designation(Convert.ToInt32(dataRow["Designation"]));
                admin.Active = Convert.ToBoolean(dataRow["Active"]);

                //Adding the Admin to the Admin List
                adminList.Add(admin);
            }

            return adminList;
        }
        catch (Exception)
        {
            return adminList;
        }
        finally
        {
            sqlcon.Close();
        }        
    }

    //Update Administrator
    public void updateAdmin(String ID, bool Active, String firstName, String lastName, String emailId, String phoneNumber)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("updateAdmin", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        //sqlcom.Parameters.Add("@Id", SqlDbType.Int).Value = id;
        sqlcom.Parameters.Add("@adminId", SqlDbType.VarChar).Value = ID;
        sqlcom.Parameters.AddWithValue("@active", SqlDbType.Bit).Value = Active;
        sqlcom.Parameters.AddWithValue("@firstname", SqlDbType.VarChar).Value = firstName;
        sqlcom.Parameters.AddWithValue("@lastname", SqlDbType.VarChar).Value = lastName;
        sqlcom.Parameters.AddWithValue("@emailid", SqlDbType.VarChar).Value = emailId;
        sqlcom.Parameters.AddWithValue("@phonenumber", SqlDbType.VarChar).Value = phoneNumber;

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteScalar();
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
    }
}
