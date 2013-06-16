using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

public class FormStatus
{
    //Instance Variables
    private char id;
    private String statusName;


    //Default Constructor
    public FormStatus()
    {
    }

    public FormStatus(char id, String name)
    {
        this.id = id;
        this.statusName = name;
    }

    //Construct Form Object for FormStatus
    public FormStatus(char id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure FormStatus By Id
        SqlCommand sqlcom = new SqlCommand("GetFormStatusById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@Id", id));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Fills the Dataset ds with the Course Details
        sqlda.Fill(ds);
        sqlcon.Close();

        this.id = id;
        this.statusName = Convert.ToString(ds.Tables[0].Rows[0]["StatusName"]);
    }


    //Setters and Getters
    public char Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public String StatusName
    {
        set { this.statusName = value; }
        get { return this.statusName; }
    }

}
