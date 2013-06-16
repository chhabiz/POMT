
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class CourseOffering
{
    //Instance Variables
    private int id;
    private Course course;
    private Program program;
    private DateTime calendarYear;
    private int calendarSem;
    private int programYear;
    private int programSem;
    private Staff coordinator;
    private bool cotaught;
    private string syllabus;
    private bool active;


    //Default Constructor
    public CourseOffering()
    {
    }

    //Construct a CourseOffering Object
    public CourseOffering(Course course, Program program, DateTime calendarYear, int calendarSem, int progyear, int progsem, Staff coordinator,bool cotaught,string syllabus,bool active)
	{
        this.Course=course;
        this.Program = program;
        this.CalendarYear=calendarYear;
        this.CalendarSem=calendarSem;
        this.ProgramYear = progyear;
        this.ProgramSem = progsem;
        this.Coordinator=coordinator;
        this.Cotaught=cotaught;
        this.Syllabus=syllabus;
        this.Active=active;
	}

     //Constructing Object by Code
    public CourseOffering(int id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Program By Code
        SqlCommand sqlcom = new SqlCommand("RetrieveOfferingByCode", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Id", id));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        String cCode = "";
        String pCode = "";

        try
        {
            sqlcon.Open();
            //Fills the Dataset ds with the Course Offering Details
            sqlda.Fill(ds);

            this.Id = id;
            this.CalendarYear = Convert.ToDateTime(ds.Tables[0].Rows[0]["CalanderYear"]);
            this.CalendarSem = Convert.ToInt32(ds.Tables[0].Rows[0]["CalanderSem"]);
            this.ProgramYear = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgramYear"]);
            this.ProgramSem = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgramSem"]);
            this.Cotaught = Convert.ToBoolean(ds.Tables[0].Rows[0]["CoTaught"]);
            this.Syllabus = Convert.ToString(ds.Tables[0].Rows[0]["Syllabus"]);
            this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);

            //Get the course by course code
            cCode = Convert.ToString(ds.Tables[0].Rows[0]["CourseCode"]);

            Course course = new Course(cCode);
            this.Course = course;

            //Get the Program by Program code
            pCode = Convert.ToString(ds.Tables[0].Rows[0]["ProgramCode"]);

            Program program = new Program(pCode);
            this.Program = program;

            //Get the course coordinator by coordinator Id
            ProgramManager tempStaff = new ProgramManager(ds.Tables[0].Rows[0]["Coordinator_Id"].ToString().Trim());
            this.Coordinator = tempStaff;
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Construct a Course Offering Object
    public CourseOffering(Course course,int calanderYear,int calanderSem)
    {

    }

    // To check if a course offering already exists for the calendar year and sem provided
    public int checkCourseOfferingExists(String courseCode, int calYear, int calSem)
    {
        int exists = 0;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Course
        SqlCommand sqlcom = new SqlCommand("CheckCourseOfferingExists", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@code", courseCode));
        sqlcom.Parameters.Add(new SqlParameter("@year", calYear));
        sqlcom.Parameters.Add(new SqlParameter("@sem", calSem));

        try
        {
            sqlcon.Open();
            exists = (int)sqlcom.ExecuteScalar();
            return exists;
        }
        catch (Exception)
        {
            return 0;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Create a new Course Offering
    public int CreateNewOffering()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Course
        SqlCommand sqlcom = new SqlCommand("CreateNewOffering", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@CourseCode", this.Course.Code));
        sqlcom.Parameters.Add(new SqlParameter("@ProgramCode", this.Program.Code));
        sqlcom.Parameters.Add(new SqlParameter("@CalendarYear", this.CalendarYear));
        sqlcom.Parameters.Add(new SqlParameter("@CalendarSem", this.CalendarSem));
        sqlcom.Parameters.Add(new SqlParameter("@ProgYear", this.ProgramYear));
        sqlcom.Parameters.Add(new SqlParameter("@ProgSem", this.ProgramSem));
        sqlcom.Parameters.Add(new SqlParameter("@Coordinator", this.Coordinator.ID));
        sqlcom.Parameters.Add(new SqlParameter("@CoTaught", this.Cotaught));
        sqlcom.Parameters.Add(new SqlParameter("@Syllabus", this.Syllabus));
        sqlcom.Parameters.Add(new SqlParameter("@Active", this.Active));

        SqlParameter param = new SqlParameter("@AutoId", SqlDbType.Int);
        param.Direction = ParameterDirection.Output;
        sqlcom.Parameters.Add(param);

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            int autoId = (int)sqlcom.Parameters["@AutoId"].Value;

            return autoId;
        }
        catch (Exception)
        {
            return 0;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Deactivate a Course Offering
    public bool DeactivateOffering()
    {
        return true;
    }

    //Reactivate a Course Offering
    public bool ReactivateOffering()
    {
        return true;
    }
    
    //Assign a Lecturer to a Course Offering
    public bool AssignStaff(Lecturer courseLecturer)
    {
        return true;
    }

    //Get All Course Offerings
    public static List<CourseOffering> GetAllOfferings(String programCode)
    {
        //Temporary Course Offering List
        List<CourseOffering> offeringList = new List<CourseOffering>();
        CourseOffering offering;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Course Offerings
        SqlCommand sqlcom = new SqlCommand("GetAllOfferings", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Course Offering's Details
            sqlda.Fill(ds);

            //Iterating through all the Course Offerings
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Course Offering Object
                offering = new CourseOffering();

                //Setting values to the Course Offering Object
                offering.Id = Convert.ToInt32(dataRow["Id"]);
                offering.CalendarYear = Convert.ToDateTime(dataRow["CalanderYear"]);
                offering.CalendarSem = Convert.ToInt32(dataRow["CalanderSem"]);
                offering.ProgramYear = Convert.ToInt32(dataRow["ProgramYear"]);
                offering.ProgramSem = Convert.ToInt32(dataRow["ProgramSem"]);
                offering.Cotaught = Convert.ToBoolean(dataRow["CoTaught"]);
                offering.Syllabus = Convert.ToString(dataRow["Syllabus"]);
                offering.Active = Convert.ToBoolean(dataRow["Active"]);

                //Get course Information
                try
                {
                    offering.Course = new Course(Convert.ToString(dataRow["CourseCode"]));
                }
                catch (Exception)
                {
                    offering.Course.Code = Convert.ToString(dataRow["CourseCode"]);
                }

                //Get Program Information
                try
                {
                    offering.Program = new Program(Convert.ToString(dataRow["ProgramCode"]));
                }
                catch (Exception)
                {
                    offering.Program.Code = Convert.ToString(dataRow["ProgramCode"]);
                }

                //Get Coordinator Information
                try
                {
                    offering.Coordinator = new Lecturer(Convert.ToString(dataRow["Coordinator_Id"]));
                }
                catch (Exception)
                {
                    offering.Coordinator.ID = Convert.ToString(dataRow["Coordinator_Id"]);

                }
                //Adding the Course to the Course List
                offeringList.Add(offering);
            }
            return offeringList;
        }
        catch (Exception)
        {
            return offeringList;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Retrieving All ULO's for Step 2 of the Wizard
    public List<string> getAllULO(int OfferingId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Course Offerings
        SqlCommand sqlcom = new SqlCommand("GetAllDistinctOfferingULOs", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        
        sqlcom.Parameters.Add("@OfferingId", SqlDbType.VarChar).Value = OfferingId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();
        List<string> ulos = new List<string>();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Course Offering's Details
            sqlda.Fill(ds);
            
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ulos.Add(dr[0].ToString());
            }

            return ulos;
        }
        catch (Exception)
        {
            return ulos;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Get the last Offering of a Course
    public static CourseOffering GetLastOfferingOfCourse(int offeringId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        CourseOffering coffering = new CourseOffering(offeringId);
        String courseCode = coffering.Course.Code;
        String programCode = coffering.Program.Code;
        //Stored Procedure Program By Code
        SqlCommand sqlcom = new SqlCommand("GetLastOfferingOfCourse", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@CourseCode", courseCode));
        sqlcom.Parameters.Add(new SqlParameter("@ProgramCode", programCode));
        sqlcom.Parameters.Add(new SqlParameter("@OfferingId", offeringId));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        CourseOffering coff = new CourseOffering();
        String cCode = "";
        String pCode = "";

        try
        {
            sqlcon.Open();
            //Fills the Dataset ds with the Course Offering Details
            sqlda.Fill(ds);

            coff.Id = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
            coff.CalendarYear = Convert.ToDateTime(ds.Tables[0].Rows[0]["CalanderYear"]);
            coff.CalendarSem = Convert.ToInt32(ds.Tables[0].Rows[0]["CalanderSem"]);
            coff.ProgramYear = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgramYear"]);
            coff.ProgramSem = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgramSem"]);
            coff.Cotaught = Convert.ToBoolean(ds.Tables[0].Rows[0]["CoTaught"]);
            coff.Syllabus = Convert.ToString(ds.Tables[0].Rows[0]["Syllabus"]);
            coff.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);

            //Get the course by course code
            cCode = Convert.ToString(ds.Tables[0].Rows[0]["CourseCode"]);

            Course course = new Course(cCode);
            coff.Course = course;

            //Get the Program by program code
            pCode = Convert.ToString(ds.Tables[0].Rows[0]["ProgramCode"]);

            Program program = new Program(pCode);
            coff.Program = program;

            //Get the course coordinator by coordinator Id
            ProgramManager tempStaff = new ProgramManager(ds.Tables[0].Rows[0]["Coordinator_Id"].ToString().Trim());
            coff.Coordinator = tempStaff;
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
        return coff;
    }


    //Getters and Setters 
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }
    public Course Course
    {
        set { this.course = value;}
        get {return this.course;}
    }
    public Program Program
    {
        set { this.program = value; }
        get { return this.program; }
    }

    public DateTime CalendarYear
    {
        set { this.calendarYear = value; }
        get { return this.calendarYear; }
    }

    public int CalendarSem
    {
        set { this.calendarSem = value; }
        get { return this.calendarSem; }
    }

    public int ProgramYear
    {
        set { this.programYear = value; }
        get { return this.programYear; }
    }

    public int ProgramSem
    {
        set { this.programSem = value; }
        get { return this.programSem; }
    }

    public Staff Coordinator
    {
        set { this.coordinator=value;}
        get { return this.coordinator; }
    }

    public bool Cotaught
    {
        set { this.cotaught = value; }
        get { return this.cotaught; }
    }

    public string Syllabus
    {
        set { this.syllabus = value; }
        get { return this.syllabus; }
    }

    public bool Active
    {
        set { this.active = value; }
        get { return this.active; }
    }


}