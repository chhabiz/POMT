using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

public class MyForm
{
    //Instance Variables
    private int id;
    private CourseOffering courseOffering;
    private FormStatus status;
    private DateTime actionDate;
    private String comments;


    //Default Constructor
    public MyForm()
    {
    }

    public MyForm(CourseOffering courseOffering, FormStatus status, DateTime dateofaction, String comments)
    {
        this.CourseOffering = courseOffering;
        this.Status = status;
        this.ActionDate = dateofaction;
        this.Comments = comments;

    }

    //Construct Form Object for an Offering 
    //Latest state of the form for that offering will be returned
    public MyForm(CourseOffering cOffering)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Form By OfferingId
        SqlCommand sqlcom = new SqlCommand("GetFormByOfferingId", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Id", cOffering.Id));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Fills the Dataset ds with the Form Details
        sqlda.Fill(ds);
        sqlcon.Close();

        this.CourseOffering = cOffering;
        FormStatus formStatus=new FormStatus(Convert.ToChar(ds.Tables[0].Rows[0]["FormStatus"]));
        this.Status = formStatus;
        this.ActionDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfAction"]);
        this.Comments = Convert.ToString(ds.Tables[0].Rows[0]["Comments"]);

    }

    //Create a New Form
    public bool CreateNewForm()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("CreateNewForm", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@CourseOfferingId", this.CourseOffering.Id);
        sqlcom.Parameters.AddWithValue("@Status", this.Status.Id);
        sqlcom.Parameters.AddWithValue("@DateofAction", this.ActionDate);
        sqlcom.Parameters.AddWithValue("@Comments", this.Comments);

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;
    }


    public static char getFormStatusByOfferingId(int OfferingId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("GetFormStatusByOfferingId", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@CourseOfferingId",OfferingId);
        
        sqlcon.Open();
        char formStatus= Char.Parse(sqlcom.ExecuteScalar().ToString());
        sqlcon.Close();

        return formStatus;
    }
    
    //Deactivate Form
    public bool DeactivateForm()
    {
        return true;
    }

    //Approve Form
    public bool ApproveForm()
    {
        return true;
    }

    //Reject Form
    public bool RejectForm()
    {
        return true;
    }

    //Does Form Exist
    public bool doesExist()
    {
        return true;
    }


    //Get the List of Forms for a Lecturer
    public static List<MyForm>GetLecturerFormList(String lecturer)
    {
        List<MyForm> formList = new List<MyForm>();
        MyForm form = null;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Form By OfferingId
        SqlCommand sqlcom = new SqlCommand("GetMyFormsList", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@CoordinatorId", lecturer));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Fills the Dataset ds with the Form Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Forms List
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary MyForm Object
            form = new MyForm();

            //Setting values to the MyForm Object
            form.id = Convert.ToInt32(dataRow["Id"]);
            CourseOffering coffer=new CourseOffering(Convert.ToInt32(dataRow["CourseOfferingId"]));
            form.CourseOffering=coffer;
            FormStatus fstatus = new FormStatus(Convert.ToChar(dataRow["FormStatus"]));
            form.status = fstatus;
            form.ActionDate = Convert.ToDateTime(dataRow["DateOfAction"]);
            form.Comments = Convert.ToString(dataRow["Comments"]);
            
            //Adding the Form to the Form List
            formList.Add(form);
        }
        return formList;

    }



    //Get the List of Forms for a Program Manager
    public static List<MyForm> GetProgramAdminFormList(String ProgramAdminId)
    {
        List<MyForm> formList = new List<MyForm>();
        MyForm form = null;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Form By OfferingId
        SqlCommand sqlcom = new SqlCommand("GetFormsListProgramAdmin", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@ProgramAdminId", ProgramAdminId));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Fills the Dataset ds with the Form Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Forms List
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary MyForm Object
            form = new MyForm();

            //Setting values to the MyForm Object
            form.id = Convert.ToInt32(dataRow["Id"]);
            CourseOffering coffer = new CourseOffering(Convert.ToInt32(dataRow["CourseOfferingId"]));
            form.CourseOffering = coffer;
            FormStatus fstatus = new FormStatus(Convert.ToChar(dataRow["FormStatus"]));
            form.status = fstatus;
            form.ActionDate = Convert.ToDateTime(dataRow["DateOfAction"]);
            form.Comments = Convert.ToString(dataRow["Comments"]);

            //Adding the Form to the Form List
            formList.Add(form);
        }
        return formList;

    }




    //Setters and Getters
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public CourseOffering CourseOffering
    {
        set { this.courseOffering = value; }
        get { return this.courseOffering; }
    }

    public FormStatus Status
    {
        set { this.status = value; }
        get { return this.status; }
    }

    public DateTime ActionDate
    {
        set { this.actionDate = value; }
        get { return this.actionDate; }
    }

    public String Comments
    {
        set { this.comments = value; }
        get { return this.comments; }
    }
}
