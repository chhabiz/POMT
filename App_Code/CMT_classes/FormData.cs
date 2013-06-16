using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

public class FormData
{
    //Instance Variables
    private int id;
    private int key;
    private String value;


    //Default Constructor
    public FormData()
    {
    }

    public FormData(int key, String value)
    {
        this.key = key;
        this.value = value;

    }

    //Get the List of Formdata for a Populating Combo boxes for the form
    public static List<FormData> GetFormDataList(String sprocname, String programCode)
    {
        List<FormData> formDataList = new List<FormData>();
        FormData formData = null;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure Form By OfferingId
        SqlCommand sqlcom = new SqlCommand(sprocname, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@ProgramId", programCode));

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Fills the Dataset ds with the Form Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Forms List
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary FormData Object
            formData = new FormData();

            //Setting values to the MyForm Object
            formData.id = Convert.ToInt32(dataRow["Id"]);
            formData.key = Convert.ToInt32(dataRow["Key"]);
            formData.value = Convert.ToString(dataRow["Value"]);

            //Adding the FormData to the FormData List
            formDataList.Add(formData);
        }
        return formDataList;

    }

    //Setters and Getters
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public int Key
    {
        set { this.key = value; }
        get { return this.key; }
    }

    public String Value
    {
        set { this.value = value; }
        get { return this.value; }
    }
}
