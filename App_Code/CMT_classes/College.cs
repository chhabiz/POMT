
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class College
{
    //Instance Variables
    private int id;
    private string name;
    private string description;
    private bool active;
    private Administrator admin;

    //Default Constructor
    public College()
    {
        this.admin = new Administrator();
    }


    //Constructing a College Object
	public College(string name,string description,bool active)
	{
        //Setting the College Instance Variables
        this.Name = name;
        this.Description = description;
        this.Active = active;

        //Administrator is not yet assigned
        this.admin = new Administrator();
	}


    //Constructing Object by id
    public College(int id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure RetrieveCollegeById
        SqlCommand sqlcom = new SqlCommand("RetrieveCollegeById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("Id", id);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);

            this.Id = id;
            this.Name = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
            this.Description = Convert.ToString(ds.Tables[0].Rows[0]["Description"]);
            this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);
            this.Admin = new Administrator(ds.Tables[0].Rows[0]["CollegeAdmin"].ToString());
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Constructing College by Administrator id
    public College(String adminid)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure RetrieveCollegeById
        SqlCommand sqlcom = new SqlCommand("RetrieveCollegeByAdminId", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("Id", adminid);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);

            this.Id = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
            this.Name = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
            this.Description = Convert.ToString(ds.Tables[0].Rows[0]["Description"]);
            this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);

            this.Admin = new Administrator(Convert.ToString(ds.Tables[0].Rows[0]["CollegeAdmin"]));
        }
        catch (Exception)
        {
            this.Admin = null;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Create New College
    public bool CreateNewCollege()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("CreateNewCollege", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@Name", this.Name);
        sqlcom.Parameters.AddWithValue("@Description", this.Description);
        sqlcom.Parameters.AddWithValue("@Active", this.Active);

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

    //Deactivate College
    public bool DeactivateCollege()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate College
        SqlCommand sqlcom = new SqlCommand("DeactivateCollege", sqlcon);
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

    //Reactivate College
    public bool ReactivatorCollege()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Reactivate College
        SqlCommand sqlcom = new SqlCommand("ReactivateCollege", sqlcon);
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


    //Assign an Administrator to a College
    public bool AssignAdmin(Administrator tempAdmin)
    {
        this.Admin = tempAdmin;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Assign an Admin to a College
        SqlCommand sqlcom = new SqlCommand("AssignAdminToCollege", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@CollegeId", this.Id));
        sqlcom.Parameters.Add(new SqlParameter("@AdminId", this.Admin.ID));

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



    //Checks If the College Already Exist with the Requested Name
    public bool doesExist()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Check if a College Already Exist with the Desired Name
        SqlCommand sqlcom = new SqlCommand("DoesCollegeExist", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Name", this.Name));

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

    //Get All Colleges
    public static List<College> GetAllColleges()
    {
        //Temporary College List
        List<College> collegeList = new List<College>();
        College college;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Administrators
        SqlCommand sqlcom = new SqlCommand("GetAllColleges", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the College's Details
            sqlda.Fill(ds);

            //Iterating through all the Admin
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Admin Object
                college = new College();

                //Setting values to the Administrator Object
                college.Id = Convert.ToInt32(dataRow["Id"]);
                college.Name = Convert.ToString(dataRow["Name"]);
                college.Description = Convert.ToString(dataRow["Description"]);
                college.Active = Convert.ToBoolean(dataRow["Active"]);

                try
                {
                    college.Admin = new Administrator(Convert.ToString(dataRow["CollegeAdmin"]));
                }
                catch (Exception)
                {
                    college.Admin = null;
                }

                //Adding the Admin to the Admin List
                collegeList.Add(college);
            }
            return collegeList;
        }
        catch (Exception)
        {
            return collegeList;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Setters and Getters
    public int Id
    {
        get { return this.id; }
        set { this.id = value; }
    }

    public string Name
    {
        set { this.name = value; }
        get { return this.name; }
    }

    public string Description
    {
        set { this.description = value; }
        get { return this.description; }
    }

    public bool Active
    {
        set { this.active = value; }
        get { return this.active; }
    }

    public Administrator Admin
    {
        get{ return this.admin;}
        set { this.admin = value; }
    }


    //Update College
    public void updateCollege(int Id, bool Active)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("updateCollege", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        //sqlcom.Parameters.Add("@Id", SqlDbType.Int).Value = id;
        sqlcom.Parameters.Add("@collegeid", SqlDbType.VarChar).Value = Id;
        sqlcom.Parameters.AddWithValue("@active", SqlDbType.Bit).Value = Active;

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