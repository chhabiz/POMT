
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class Program
{
    //Instance Variables
    private string code;
    private string name;
    private string description;
    private bool active;
    private School school;
    private ProgramManager programManager;


    //Default Constructor
    public Program()
    {
    }

    //Constructing a Program Object
    public Program(string code, School school, string name, string description, bool active, ProgramManager programManager)
	{
        //Setting the Instance Variables
        this.Code = code;
        this.School = school;
        this.ProgramManager = programManager;
        this.Name = name;
        this.Description = description;
        this.Active = active;
        this.ProgramManager = programManager;
	}


    //Constructing Object by Code
    public Program(string code)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Program By Code
        SqlCommand sqlcom = new SqlCommand("RetrieveProgramByCode", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Code", code));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Fills the Dataset ds with the Program Details
            sqlda.Fill(ds);

            this.Code = code;
            this.Name = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
            this.Description = Convert.ToString(ds.Tables[0].Rows[0]["Description"]);
            this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);
            this.School = new School(Convert.ToInt32(ds.Tables[0].Rows[0]["SchoolId"]));
            this.ProgramManager = new ProgramManager(Convert.ToString(ds.Tables[0].Rows[0]["ProgramHead"]));
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Create New Program
    public bool CreateNewProgram()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Program
        SqlCommand sqlcom = new SqlCommand("CreateNewProgram", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Code", this.Code));
        sqlcom.Parameters.Add(new SqlParameter("@Name", this.Name));
        sqlcom.Parameters.Add(new SqlParameter("@ProgramHead", this.ProgramManager.ID));
        sqlcom.Parameters.Add(new SqlParameter("@SchoolId", this.School.Id));
        sqlcom.Parameters.Add(new SqlParameter("@Description", this.Description));
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

    //Deactivate Program
    public bool DeactivateProgram()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate Program
        SqlCommand sqlcom = new SqlCommand("DeactivateProgram", sqlcon);
        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Code));

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;

    }

    public bool updateProgram(String Code,bool Active)
    {
        this.Code = Code;
        this.Active = Active;
        this.Description = Description;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate College
        SqlCommand sqlcom = new SqlCommand("updateProgram", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@Code", SqlDbType.VarChar).Value = this.Code;
        sqlcom.Parameters.Add("@Active", SqlDbType.Bit).Value = this.Active;

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

    //Reactivate Program
    public bool ReactivatorProgram()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Reactivate Program
        SqlCommand sqlcom = new SqlCommand("ReactivateProgram", sqlcon);
        sqlcom.Parameters.Add(new SqlParameter("@Id", this.Code));

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

    //Assign a Program Manager
    public bool AssignProgramManager(ProgramManager tempPm)
    {
        this.ProgramManager = tempPm;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Assign a Program Manager to a Program
        SqlCommand sqlcom = new SqlCommand("AssignProgramManager", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@ProgramCode", this.Code));
        sqlcom.Parameters.Add(new SqlParameter("@ProgramManagerId", this.ProgramManager.ID));

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

    //Assign a School to 
    public bool AssignSchooltoProgram()
    {
        return true;
    }

    //Get All Programs
    public static List<Program> GetAllPrograms(int collegeId)
    {
        //Temporary Program List
        List<Program> programList = new List<Program>();
        Program program;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Programs
        SqlCommand sqlcom = new SqlCommand("GetAllPrograms", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@Id", SqlDbType.VarChar).Value = collegeId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Program's Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Programs
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary Program Object
            program = new Program();

            //Setting values to the Program Object
            program.Code = Convert.ToString(dataRow["Code"]);
            program.Name = Convert.ToString(dataRow["Name"]);
            program.Description = Convert.ToString(dataRow["Description"]);
            program.Active = Convert.ToBoolean(dataRow["Active"]);
            program.School = new School(Convert.ToInt32(dataRow["SchoolId"]));
            try
            {
                program.ProgramManager = new ProgramManager(Convert.ToString(dataRow["ProgramHead"]));
            }
            catch (Exception)
            {
                program.ProgramManager = null;
                
            }



            //Adding the Program to the Program List
            programList.Add(program);
        }

        return programList;
    }

    //Setters and Getters
    public string Code
    {
        set { this.code = value; }
        get { return this.code; }
    }

    public School School
    {
        set { this.school = value; }
        get { return this.school; }
    }

    public ProgramManager ProgramManager
    {
        set { this.programManager = value; }
        get { return this.programManager; }
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