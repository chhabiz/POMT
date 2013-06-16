
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.SessionState;
using System.Web.Security;

public static class Driver
{
    //Get myCollege List
    public static List<College> MyCollegeList(Administrator admin)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("GetMyCollegeList", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", admin.ID));
        List<College> tempList = new List<College>();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);

            foreach (DataRow tempDr in ds.Tables[0].Rows)
            {
                tempList.Add(new College(Convert.ToInt32(tempDr[0].ToString())));
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

    //Get myProgram List
    public static List<Program> MyProgramList(ProgramManager programManager)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("GetMyProgramList", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", programManager.ID));
        List<Program> tempList = new List<Program>();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);

            foreach (DataRow tempDr in ds.Tables[0].Rows)
            {
                tempList.Add(new Program(tempDr[0].ToString()));
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

    //Check If StaffId Already Exist
    public static bool CheckStaffIdExist(Staff staff)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("CheckStaffIdExist", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", staff.ID));
        bool exist = false;

        try
        {
            sqlcon.Open();
            exist = Convert.ToBoolean(Convert.ToInt32(sqlcom.ExecuteScalar()));
            return exist;
        }
        catch (Exception)
        {
            return exist;
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Getting Admin Active Status
    public static bool GetActiveStatus(Staff staff)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Gets the Staff Status (Active or DeActive)
        SqlCommand sqlcom = new SqlCommand("GetStaffStatus", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@Id", staff.ID));
        bool status = false;

        try
        {
            sqlcon.Open();
            status = Convert.ToBoolean(sqlcom.ExecuteScalar());

            return status;
        }
        catch (Exception)
        {
            return status;
        }
        finally
        {
            sqlcon.Close();
        }      
    }


    public static bool canOperateOnCourse(Staff oprationStaff)
    {
        string designation=oprationStaff.Designation.Description;
        
        //Only Super Administrator cannot operate on Courses
        if (designation.Equals("Super Administrator"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public static bool canOperateOnProgram(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;

        //Only Administrator and Program Manager can Operate on Program
        if (designation.Equals("Super Administrator") || designation.Equals("Lecturer"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public static bool canOperateOnSchool(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;

        //Only Administrator can operate on Schools
        if (designation.Equals("Administrator"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public static bool canOperateOnCollege(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;
   
        //Only Super Administrator can operate on Colleges
        if (designation.Equals("Super Administrator"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

   

    public static bool canOperateOnLecturer(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;

        //Anyone other than the Lecturer can operate on Courses
        if (designation.Equals("Lecturer"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public static bool canOperateOnProgramManager(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;

        //Only Administrator cannot operate on Courses
        if (designation.Equals("Administrator"))
        {
            return true;
        }
        else
        {
            return false;
        }

    }

    public static bool canOperateOnAdministrator(Staff oprationStaff)
    {
        string designation = oprationStaff.Designation.Description;

        //Only Super Administrator can operate on Courses
        if (designation.Equals("Super Administrator"))
        {
            return true;
        }
        else
        {
            return false;
        }

    }


    public static List<MyForm> ViewMyApprovedForms(Staff operationStaff)
    {
        return new List<MyForm>();
    }

    public static List<MyForm> ViewMyUnApprovedForms(Staff operationStaff)
    {
        return new List<MyForm>();
    }

    public static List<MyForm> ViewMyPendingForms(Staff operationStaff)
    {
        return new List<MyForm>();
    }


    //Authentication Related Methods

    //Values Stored in Plain text at the Moment.. Will change it to Encrypted Text once the V 1.0 is complete.
    public static bool Authenticate(string staffId, string password)
    {
        //String hashedPass = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "sha1");
        String hashedPass = Encode(password);
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Authenticate Staff 
        SqlCommand sqlcom = new SqlCommand("Authenticate", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@StaffId", staffId));
        sqlcom.Parameters.Add(new SqlParameter("@Password", hashedPass));

        try
        {
            sqlcon.Open();
            bool status = Convert.ToBoolean(sqlcom.ExecuteScalar());
            return status;
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


    //Create new Id/Staff Pair
    public static bool CreateNewStaffIdPasswordPair(string staffId, string password)
    {
        //String hashedPass = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "sha1");
        String hashedPass = Encode(password);
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Authenticate Staff 
        SqlCommand sqlcom = new SqlCommand("NewAuthenticationPair", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add(new SqlParameter("@StaffId", staffId));
        sqlcom.Parameters.Add(new SqlParameter("@Password", hashedPass));

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



    //Changing Staff Password
    public static bool ChangePassword(string staffId, string password)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Authenticate Staff 
        SqlCommand sqlcom = new SqlCommand("ChangePassword", sqlcon);
        sqlcom.Parameters.Add(new SqlParameter("@StaffId", staffId));
        sqlcom.Parameters.Add(new SqlParameter("@Password", password));

        bool status = false;

        try
        {
            sqlcon.Open();
            status = Convert.ToBoolean(sqlcom.ExecuteScalar());
            return status;
        }
        catch (Exception)
        {
            return status;
        }
        finally
        {
            sqlcon.Close();
        }
    }
    

    //Should be Implemented Later
    public static bool SendPasswordToEmail(string userName)
    {
        return true;
    }


    //Identify User Designation
    public static Designation GetUserDesignation(string staffId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
      
        SqlCommand sqlcom = new SqlCommand("GetUserDesignation", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@StaffId", staffId));
        Designation role = new Designation();

        try
        {
            sqlcon.Open();
            //Getting the Integral Representation of Staff Designation
            int designation = Convert.ToInt32(sqlcom.ExecuteScalar());

            //Creating a Designation Object
            role = new Designation(designation);
            return role;
        }
        catch (Exception)
        {
            return role;
        }
        finally
        {
            sqlcon.Close();
        }
    }

    //Assign Course to a Program
    public static bool AssignCourseToProgram(string programId,string courseId)
    {
        try
        {
            SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

            SqlCommand sqlcom = new SqlCommand("AssignCourseProgram", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.Add(new SqlParameter("@courseCode", courseId));
            sqlcom.Parameters.Add(new SqlParameter("@programCode", programId));

            sqlcon.Open();
            sqlcom.ExecuteNonQuery();
            sqlcon.Close();

            return true;
        }
        catch (Exception)
        {
            return false;
        }

    }



    //Identify the Session User Role
    public static Staff IdentifyRole(HttpSessionState session)
    {
        Staff a1=null;

        if (session["CMT_User"].GetType().ToString().Equals("Administrator"))
        {
            a1 = (Administrator)session["CMT_User"];
        }
        else if (session["CMT_User"].GetType().ToString().Equals("ProgramManager"))
        {
            a1 = (ProgramManager)session["CMT_User"];
        }
        else if (session["CMT_User"].GetType().ToString().Equals("Lecturer"))
        {
            a1 = (Lecturer)session["CMT_User"];
        }
        else if (session["CMT_User"].GetType().ToString().Equals("SuperAdministrator"))
        {
            a1 = (SuperAdministrator)session["CMT_User"];
        }

        return a1; 
    }

    //Get user status (active/inactive)
    public static bool VerifyUserStatus(String staffid)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("SelectIfUserActive", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@userid", staffid));

        try
        {
            sqlcon.Open();
            int num_rows_returned = (int)sqlcom.ExecuteScalar();
            if (num_rows_returned > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
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

    //Get user status (active/inactive)
    public static bool VerifyAdminAssignedStatus(String staffid)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("VerifyAdminAssignedStatus", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@userid", staffid));

        try
        {
            sqlcon.Open();
            int num_rows_returned = (int)sqlcom.ExecuteScalar();
            if (num_rows_returned > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
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

    //Forgot Password Email functionality
    public static string ForgotPassword(String userid, String email)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("ForgotPassword", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@userid", userid));
        sqlcom.Parameters.Add(new SqlParameter("@emailid", email));
        String password = "";

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        try
        {
            sqlcon.Open();
            sqlda.Fill(dsattr, "AuthDetails");
            password = Convert.ToString(dsattr.Tables["AuthDetails"].Rows[0]["Password"]);
            password = Decode(password);
            //password = "Select password from authentication where staffid=" + userid;
            return password;
        }
        catch (Exception)
        {
            return "";
        }
        finally
        {
            sqlcon.Close();
        }
    }


    //Encrypt and Decrypt for passwords
    public static string Encode(string str)
    {
        try
        {
            byte[] encbuff = System.Text.Encoding.UTF8.GetBytes(str);
            return Convert.ToBase64String(encbuff);
        }
        catch (Exception)
        {
            return "";
        }    
    }

    public static string Decode(string str)
    {
        try
        {
            byte[] decbuff = Convert.FromBase64String(str);
            return System.Text.Encoding.UTF8.GetString(decbuff);
        }
        catch (Exception)
        {
            return "";
        }        
    }

    //This method maps PACs to a Program. A maximum of 3 Groups of PACs can be added for a Program
    public static bool MapPACs(String programCode, int pac1, int pac2, int pac3)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New PAC Mapping
        SqlCommand sqlcom = new SqlCommand("CreateNewPACMapping", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@ProgramCode", programCode);
        sqlcom.Parameters.AddWithValue("@Pac1", pac1);
        sqlcom.Parameters.AddWithValue("@Pac2", pac2);
        sqlcom.Parameters.AddWithValue("@Pac3", pac3);

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

    //This method maps AQF Level to a Program.
    public static bool MapAQFLevel(String programCode, int aqflevel)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New AQF Mapping
        SqlCommand sqlcom = new SqlCommand("CreateNewAQFMapping", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@ProgramCode", programCode);
        sqlcom.Parameters.AddWithValue("@AQFLevel", aqflevel);

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

    public static Boolean validSwitch(String userDesignation, String val)
    {
        if (userDesignation.Equals("Administrator") && (val.Equals("Administrator") || val.Equals("Program Manager") || val.Equals("Staff")))
        {
            return true;
        }
        else if (userDesignation.Equals("Program Manager") && (val.Equals("Program Manager") || val.Equals("Staff")))
        {
            return true;
        }
        else if (userDesignation.Equals("Lecturer") && val.Equals("Staff"))
        {
            return true;
        }

        return false;
    }

    public static String getPAC(String progCode, String sproc)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        String pac = "";
        //Stored Procedure RetrieveCollegeById
        SqlCommand sqlcom = new SqlCommand(sproc, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@ProgramCode", progCode);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);
            pac = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
        return pac;
    }

    //This Method returns the AQF Level for a Program

    public static String getAQFLevel(String progCode, String sproc)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        String aqf = "";
        //Stored Procedure RetrieveCollegeById
        SqlCommand sqlcom = new SqlCommand(sproc, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@ProgramCode", progCode);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        try
        {
            sqlcon.Open();
            sqlda.Fill(ds);
            aqf = Convert.ToString(ds.Tables[0].Rows[0]["Name"]);
        }
        catch (Exception)
        {
        }
        finally
        {
            sqlcon.Close();
        }
        return aqf;
    }
}