
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;



public class SuperAdministrator : Staff
{
	public SuperAdministrator()
	{

	}

    //Constructing an Super Administrator Object
    public SuperAdministrator(string Id, string firstName, string lastName, string emailId, string phoneNumber, Designation designation, bool active)
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

    
    //Constructing an Super Administrator object using Id
    public SuperAdministrator(string Id)
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

        //Constructing the Super Administrator Object
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
    

    //Create a new Super Administrator (Only to be Used Once When the Application Starts to Create the Root of the Role Tree)
    public bool CreateSuperAdministrator()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        int designation;

        //Query to Retrieve the intergral Representation of Designation
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Description", "Super Administrator"));
        

        sqlcon.Open();
        //Retrieving the intergral Representation of Designation
        designation= Convert.ToInt32(sqlcom.ExecuteScalar());
        sqlcon.Close();

        //Inserting New Staff Record
        sqlcom = new SqlCommand("InsertNewStaff", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));
        sqlcom.Parameters.Add(new SqlParameter("@FirstName", this.FirstName));
        sqlcom.Parameters.Add(new SqlParameter("@LastName", this.LastName));
        sqlcom.Parameters.Add(new SqlParameter("@EmailId", this.EMailId));
        sqlcom.Parameters.Add(new SqlParameter("@PhoneNumber", this.PhoneNumber));
        sqlcom.Parameters.Add(new SqlParameter("@Designation", designation));
        sqlcom.Parameters.Add(new SqlParameter("@Active", "True"));

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

}
