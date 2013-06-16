
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.ObjectModel;


public class ProgramManager : Staff
{
    //Default Constructor
    public ProgramManager()
    {

    }

    //Calling Base Constructor to Build a Program Manager Object
    public ProgramManager(string Id, string firstName, string lastName, string emailId, string phoneNumber, Designation designation, bool active)
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

    //Construct the Program Manager Object using its Id
    public ProgramManager(string Id)
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

        //Constructing the Program Manager Object
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
        sqlcon.Open();

        //Get the string Representation of the Designation
        description = Convert.ToString(sqlcom.ExecuteScalar());
        sqlcon.Close();

        //Setting Up the Staff Designation Object and Setting it to the Designation Attribute of Staff
        this.Designation = new Designation(designation, description);
    }


    //Create a New Program Manager
    public bool CreateProgramManager(String staffID)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        int designation;

        //Query to Retrieve the intergral Representation of Designation
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Description", "Program Manager"));

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
            sqlcom.Parameters.AddWithValue("@FirstName", this.firstName);
            sqlcom.Parameters.AddWithValue("@LastName", this.LastName);
            sqlcom.Parameters.AddWithValue("@EmailId", this.EMailId);
            sqlcom.Parameters.AddWithValue("@PhoneNumber", this.PhoneNumber);
            sqlcom.Parameters.AddWithValue("@Designation", designation);
            sqlcom.Parameters.AddWithValue("@Active", "True");
            sqlcom.Parameters.AddWithValue("@adminid", staffID);

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

    //Deactivate a Program Manager
    public bool DeactivateProgramManager()
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

    //Reactivate a Program MAnager If Deactivate
    public bool ReactivateProgramManager()
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

    //Get All Program Managers
    //public static List<ProgramManager> GetAllProgramManagers(int college)
    public static List<ProgramManager> GetAllProgramManagers(String adminId)
    {
        //Temporary ProgramManager List
        List<ProgramManager> programManagerList = new List<ProgramManager>();
        ProgramManager programManager;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the ProgramManager
        SqlCommand sqlcom = new SqlCommand("GetProgramManagersforSchoolAdmin", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@adminId", adminId);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the ProgramManager's Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the ProgramManagers
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary Program Manager Object
            programManager = new ProgramManager();

            //Setting values to the Program Manager Object
            programManager.ID = Convert.ToString(dataRow["StaffId"]);
            programManager.FirstName = Convert.ToString(dataRow["FirstName"]);
            programManager.LastName = Convert.ToString(dataRow["LastName"]);
            programManager.EMailId = Convert.ToString(dataRow["EmailId"]);
            programManager.PhoneNumber = Convert.ToString(dataRow["PhoneNumber"]);
            programManager.Designation = new Designation(Convert.ToInt32(dataRow["Designation"]));
            programManager.Active = Convert.ToBoolean(dataRow["Active"]);

            //Adding the ProgramManager to the ProgramManager List
            programManagerList.Add(programManager);
        }

        return programManagerList;
    }

    //Get All ProgramAdmin Ids
    public static List<string> getAllProgAdminIds(String adminId)
    {
        //Temporary {rogram Manager Ids List
        List<string> progAdminList = new List<string>();
        string pAdmin;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Administrator Ids
        SqlCommand sqlcom = new SqlCommand("GetAllProgAdminIds", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@adminId", adminId);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Program Admin's Ids
            sqlda.Fill(ds);
            //Iterating through all the Program Admin
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                pAdmin = Convert.ToString(dataRow["StaffId"]);

                //Adding the Program Admin to the Program Admin Ids List
                progAdminList.Add(pAdmin);
            }

            return progAdminList;
        }
        catch (Exception)
        {
            return progAdminList;
        }
        finally
        {
            sqlcon.Close();
        }

    }
}