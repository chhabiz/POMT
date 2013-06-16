
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class Course
{
    //Instance Variables
    private string code;
    private string title;
    private int credit_Value;
    private List<Course> prequisiteList;
    private string qua_Equivalent;
    private School school;
    private int programYear;
    private int programSem;
    private bool active;


    //Default Constructor
    public Course()
    {
    }

    //Constructing a New Course Object
	public Course(string courseCode,string title,int credit_Value, List<Course> preqList, string qequivalent,School school,int programYear,int programSem,bool active)
	{
        this.Code = courseCode;
        this.Title = title;
        this.CreditValue = credit_Value;
        this.prequisiteList = preqList;
        this.qua_Equivalent = qequivalent;
        this.school = school;
        this.ProgramYear= programYear;
        this.ProgramSem = programSem;
        this.active = active;
	}

     //Constructing Object by Code
    public Course(String code)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Program By Code
        SqlCommand sqlcom = new SqlCommand("RetrieveCourseByCode", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Code", code));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Fills the Dataset ds with the Course Details
            sqlda.Fill(ds);

            this.code = code;
            this.title = Convert.ToString(ds.Tables[0].Rows[0]["Title"]);
            this.credit_Value = Convert.ToInt32(ds.Tables[0].Rows[0]["Credit_Value"]);
            this.ProgramSem = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgSem"]);
            this.ProgramYear = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgYear"]);
            this.Qua_Equivalent = Convert.ToString(ds.Tables[0].Rows[0]["OUA_Equivalent"]);
            this.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);

            this.PrequisiteList = this.getPreRequisites();

            this.School = new School(Convert.ToInt32(ds.Tables[0].Rows[0]["SchoolId"]));
        }
        catch (Exception)
        {
            this.prequisiteList = null;
            this.School = null;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Retrieve all the Prerequisites for a course
    public List<Course> getPreRequisites()
    {
        List<Course> tempList = new List<Course>();
        //School preqSchool;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Prerequisite By Code
        SqlCommand sqlcom = new SqlCommand("GetCoursePreRequisites", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Code", code));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Fills the Dataset ds with the Course Details
            sqlda.Fill(ds);

            //Iterating through all the Prerequisites
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Prerequisites Object
                Course preqCourse = new Course();

                //Setting values to the Prerequisites Object
                preqCourse.Code = Convert.ToString(dataRow["Code"]);
                preqCourse.title = Convert.ToString(ds.Tables[0].Rows[0]["Title"]);
                preqCourse.credit_Value = Convert.ToInt32(ds.Tables[0].Rows[0]["Credit_Value"]);
                preqCourse.ProgramSem = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgSem"]);
                preqCourse.ProgramYear = Convert.ToInt32(ds.Tables[0].Rows[0]["ProgYear"]);
                preqCourse.Qua_Equivalent = Convert.ToString(ds.Tables[0].Rows[0]["OUA_Equivalent"]);
                preqCourse.School = new School(Convert.ToInt32(ds.Tables[0].Rows[0]["SchoolId"]));
                preqCourse.Active = Convert.ToBoolean(ds.Tables[0].Rows[0]["Active"]);

                //Adding the Prerequisite to the Prerequisite List
                tempList.Add(preqCourse);
            }

            return tempList;
        }
        catch (Exception)
        {
            return tempList;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Creating a New Course
    public bool CreateNewCourse()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Course
        SqlCommand sqlcom = new SqlCommand("CreateNewCourse", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Code", this.Code));
        sqlcom.Parameters.Add(new SqlParameter("@Title", this.Title));
        sqlcom.Parameters.Add(new SqlParameter("@CreditValue", this.CreditValue));
        sqlcom.Parameters.Add(new SqlParameter("@OEquiv", this.Qua_Equivalent));
        sqlcom.Parameters.Add(new SqlParameter("@ProgSem", this.ProgramSem));
        sqlcom.Parameters.Add(new SqlParameter("@ProgYear", this.ProgramYear));
        sqlcom.Parameters.Add(new SqlParameter("@SchoolId", this.School.Id));
        sqlcom.Parameters.Add(new SqlParameter("@Active", this.Active));

        try
        {
            sqlcon.Open();
            sqlcom.ExecuteNonQuery();

            foreach (Course prequisite in this.PrequisiteList)
            {
                this.AddPreRequisite(prequisite);
            }
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

    //this mehtod is for update coures 
    public bool updateCourse(String Code, bool Active)
    {
        this.Code = Code;
        this.Active = Active;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate College
        SqlCommand sqlcom = new SqlCommand("updateCourse", sqlcon);
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

    //This method adds Prerequisite courses for a Course

    private bool AddPreRequisite(Course prequisite)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        //Stored Procedure to add Prerequisites
        SqlCommand sqlcompreq = new SqlCommand("AddPrequisite", sqlcon);
        sqlcompreq.CommandType = CommandType.StoredProcedure;
        sqlcompreq.Parameters.Add(new SqlParameter("@CourseCode", this.Code));
        sqlcompreq.Parameters.Add(new SqlParameter("@PreqCode", prequisite.Code));

        try
        {
            sqlcon.Open();
            sqlcompreq.ExecuteNonQuery();

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

    //Deactivate a Course
    protected bool DeactivateCourse()
    {
        return true;
    }

    //Reactivate a Course
    protected bool ReactivateCourse()
    {
        return true;
    }

    //Get All Courses
    public static List<Course> GetAllCourses(int schoolId)
    {
        //Temporary Course List
        List<Course> courseList = new List<Course>();
        Course course;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Programs
        SqlCommand sqlcom = new SqlCommand("GetAllCourses", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@Id", SqlDbType.VarChar).Value = schoolId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Course's Details
            sqlda.Fill(ds);

            //Iterating through all the Courses
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Course Object
                course = new Course();

                //Setting values to the Course Object
                course.Code = Convert.ToString(dataRow["Code"]);
                course.Title = Convert.ToString(dataRow["Title"]);
                course.CreditValue = Convert.ToInt32(dataRow["Credit_Value"]);
                course.Qua_Equivalent = Convert.ToString(dataRow["OUA_Equivalent"]);
                course.School = new School(Convert.ToInt32(dataRow["SchoolId"]));
                course.ProgramSem = Convert.ToInt32(dataRow["ProgSem"]);
                course.ProgramYear = Convert.ToInt32(dataRow["ProgYear"]);
                course.Active = Convert.ToBoolean(dataRow["Active"]);

                try
                {
                    course.PrequisiteList = course.getPreRequisites();
                }
                catch (Exception)
                {
                    course.PrequisiteList = null;

                }
                //Adding the Course to the Course List
                courseList.Add(course);
            }

            return courseList;
        }
        catch (Exception)
        {
            return courseList;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Get All Courses under a program
    public static List<Course> GetProgCourses(String programId)
    {
        //Temporary Course List
        List<Course> courseList = new List<Course>();
        Course course;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Programs
        SqlCommand sqlcom = new SqlCommand("GetProgCourses", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@ProgramId", SqlDbType.VarChar).Value = programId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            //Filling the DataSet with All the Course's Details
            sqlda.Fill(ds);

            //Iterating through all the Courses
            foreach (DataRow dataRow in ds.Tables[0].Rows)
            {
                //Temporary Course Object
                course = new Course();

                //Setting values to the Course Object
                course.Code = Convert.ToString(dataRow["Code"]);
                course.Title = Convert.ToString(dataRow["Title"]);
                course.CreditValue = Convert.ToInt32(dataRow["Credit_Value"]);
                course.Qua_Equivalent = Convert.ToString(dataRow["OUA_Equivalent"]);
                course.School = new School(Convert.ToInt32(dataRow["SchoolId"]));
                course.ProgramSem = Convert.ToInt32(dataRow["ProgSem"]);
                course.ProgramYear = Convert.ToInt32(dataRow["ProgYear"]);
                course.Active = Convert.ToBoolean(dataRow["Active"]);

                try
                {
                    course.PrequisiteList = course.getPreRequisites();
                }
                catch (Exception)
                {
                    course.PrequisiteList = null;
                }
                //Adding the Course to the Course List
                courseList.Add(course);
            }
            return courseList;
        }
        catch (Exception)
        {
            return courseList;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Setters and Getters

    public string Code
    {
        get { return this.code; }
        set { this.code = value; }
    }

    public string Title
    {
        get { return this.title; }
        set { this.title = value; }
    }

    public int CreditValue
    {
        get { return this.credit_Value; }
        set { this.credit_Value = value; }
    }

    public List<Course> PrequisiteList
    {
        get { return this.prequisiteList; }
        set { this.prequisiteList = value; }
    }

    public string Qua_Equivalent
    {
        get { return this.qua_Equivalent; }
        set { this.qua_Equivalent = value; }
    }

    public School School
    {
        get { return this.school; }
        set { this.school = value; }
    }

    public int ProgramYear
    {
        get { return this.programYear; }
        set { this.programYear = value; }
    }

    public int ProgramSem
    {
        get { return this.programSem; }
        set { this.programSem = value; }
    }

    public bool Active
    {
        get { return this.active; }
        set { this.active = value; }
    }


}