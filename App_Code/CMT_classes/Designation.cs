
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class Designation
{
    private int id;
    private string description;

    //Default Constructor
    public Designation()
    {

    }

    public Designation(int id)
    {
        this.Id = id;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Retrieve the Designation Description
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Id));
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

        //Constructing the Designation Object
        this.Id = id;
        this.Description = Convert.ToString(ds.Tables[0].Rows[0]["Description"]);
    }

    //Construct a Designation Object
    public Designation(int id, string description)
    {
        this.Id = id;
        this.Description = description;
    }


    //Construct a Designation Object
	public Designation(string description)
	{
        this.Description = description;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Retrieve the Designation Description
        SqlCommand sqlcom = new SqlCommand("RetrieveDesignationIdByDescription", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Description", this.Description));

        try
        {
            sqlcon.Open();
            this.Id = Convert.ToInt32(sqlcom.ExecuteScalar());
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
	}

    //Checks if a Designation Exist
    public bool Exist()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to check if the Designation Exist
        SqlCommand sqlcom = new SqlCommand("DoesDesignationExist", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Description", this.Description));

        bool exist;

        try
        {
            sqlcon.Open();
            exist = Convert.ToBoolean(sqlcom.ExecuteScalar());
            return exist;
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


    //Setters and Getters
    public string Description
    {
        set { this.description = value; }
        get { return this.description; }
    }

    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }
}