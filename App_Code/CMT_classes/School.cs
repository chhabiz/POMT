
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class School
{
	
    //Instance Variables
    private int id;
    private string name;
    private string description;
    private bool active;
    private College college;


    //Default Constructor
    public School()
    {
        this.college = new College();
    }

    //Constructing a School Object
    public School(string name, string description, bool active)
    {
        this.Name = name;
        this.Description = description;
        this.Active = active;

        this.college = new College();
    }

    //Constructing a School Object
	public School(string name,string description,string collegeId,bool active)
	{
        this.Name = name;
        this.Description = description;
        this.Active = active;
        try
        {
            this.college = new College(Convert.ToInt32(collegeId));
        }
        catch (Exception)
        {
            this.College = null;
        }
	}

    //Constructing Object by id
    public School(int id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure RetrieveSchoolById
        SqlCommand sqlcom = new SqlCommand("RetrieveSchoolById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Id", id));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        sqlda.Fill(ds);
        sqlcon.Close();

        this.Id = id;
        this.Name = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
        this.Description = Convert.ToString(ds.Tables[0].Rows[0]["Description"]);
        this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);
        try
        {
            this.College=new College(Convert.ToInt32(ds.Tables[0].Rows[0]["CollegeId"]));
        }
        catch (Exception)
        {
            this.College = null;
        }

    }

    //Create New School
    public bool CreateNewSchool()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("CreateNewSchool", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Name", this.Name));
        sqlcom.Parameters.Add(new SqlParameter("@Description", this.Description));
        sqlcom.Parameters.Add(new SqlParameter("@CollegeId", this.College.Id));
        sqlcom.Parameters.Add(new SqlParameter("@Active", this.Active));

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

    //Deactivate School
    public bool DeactivateSchool()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate College
        SqlCommand sqlcom = new SqlCommand("DeactivateSchool", sqlcon);
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

     public bool updateSchool(int Id, bool Active)
    {
        this.Id = Convert.ToInt32(Id);
        this.Active = Active;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate College
        SqlCommand sqlcom = new SqlCommand("updateSchool", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@Id", SqlDbType.Int).Value =this.Id;
        sqlcom.Parameters.Add("@Active",SqlDbType.Bit).Value = this.Active;

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
    

    //Reactivate School
    public bool ReactivatorSchool()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Reactivate College
        SqlCommand sqlcom = new SqlCommand("ReactivateSchool", sqlcon);
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

    //Get All Schools
    public static List<School> GetAllSchools(int collegeId)
    {
        //Temporary School List
        List<School> schoolList = new List<School>();
        School school;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Schools
        SqlCommand sqlcom = new SqlCommand("GetAllSchools", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@Id", SqlDbType.VarChar).Value = collegeId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the School's Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Schools
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary School Object
            school = new School();

            //Setting values to the School Object
            school.Id = Convert.ToInt32(dataRow["Id"]);
            school.Name = Convert.ToString(dataRow["Name"]);
            school.Description = Convert.ToString(dataRow["Description"]);
            school.Active = Convert.ToBoolean(dataRow["Active"]);

            try
            {
                school.College = new College(Convert.ToInt32(dataRow["CollegeId"]));
            }
            catch (Exception)
            {
                school.College = null;

            }



            //Adding the School to the School List
            schoolList.Add(school);
        }

        return schoolList;
    }



    //Setters and Getters
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public College College
    {
        set { this.college = value; }
        get { return this.college; }
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
}