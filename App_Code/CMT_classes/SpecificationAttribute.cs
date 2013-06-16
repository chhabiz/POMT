

/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class SpecificationAttribute
{
    //Instance Variables
    private int id;
    private string name;
    private string description;

    //Default Constructor
	public SpecificationAttribute()
	{

	}

    //Constructor with SpecificationAttributeId from the database to construct an Object
    public SpecificationAttribute(int id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Specification Attribute
        SqlCommand sqlcom = new SqlCommand("GetSpecificationAttributeById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Id", id);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr);
        sqlcon.Close();

        this.Id = id;
        this.Name = Convert.ToString(dsattr.Tables[0].Rows[0]["Name"]);
        this.Description= Convert.ToString(dsattr.Tables[0].Rows[0]["Description"]);
        
    }

    public SpecificationAttribute(int id, string name, string description)
    {
        this.Id = id;
        this.Name = name;
        this.Description = description;
    }
    
    //Construction Object based on Name
    public SpecificationAttribute(string name)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        
        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("GetSpecificationAttributeByName", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Name", name);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr);
        sqlcon.Close();

        this.Id = Convert.ToInt32(dsattr.Tables[0].Rows[0]["Id"]);
        this.Name = name;
        this.Description = Convert.ToString(dsattr.Tables[0].Rows[0]["Description"]);

    }

    //Create New SpecificationAttribute
    public bool CreateNewSpecificationAttribute()
    {
        return true;
    }

    //Deactivate SpecificationAttribute
    public bool DeactivateSpecificationAttribute()
    {
        return true;
    }

    //Reactivate SpecificationAttribute
    public bool ReactivatorSpecificationAttribute()
    {
        return true;
    }

    ////Gets All SpecificationAttributeOption for this SpecificationAttribute
    //public List<SpecificationAttributeOption> getAllSpecificationAttributeOptions()
    //{
    //    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

    //    SqlCommand sqlcom = new SqlCommand("GetAllSpecificationAttributeOptionsBySpecificationAttributeId", sqlcon);
    //    sqlcom.CommandType = CommandType.StoredProcedure;
    //    sqlcom.Parameters.AddWithValue("@SpecificationAttributeId", this.Id);

    //    SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
    //    DataSet dsattr = new DataSet();

    //    sqlcon.Open();
    //    //Filling the DataSet with All the Specification Attribute Options' Details
    //    sqlda.Fill(dsattr);
    //    sqlcon.Close();

    //    return new List<SpecificationAttributeOption>();
    //}

    //Get All Specification Attributes
    public static List<SpecificationAttribute> GetAllSpecificationAttributes()
    {
        //Temporary SpecificationAttribute List
        List<SpecificationAttribute> sattribList = new List<SpecificationAttribute>();
        SpecificationAttribute sattrib;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Specification Attributes
        SqlCommand sqlcom = new SqlCommand("GetAllSpecificationAttributes", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attributes' Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Iterating through all the Specification Attributes
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary Specification Attributes Object
            sattrib = new SpecificationAttribute();

            //Setting values to the Specification Attributes Object
            sattrib.id = Convert.ToInt32(dataRow["Id"]);
            sattrib.name = Convert.ToString(dataRow["Name"]);
            sattrib.Description = Convert.ToString(dataRow["Description"]);

            //Adding the Specification Attributes to the Specification Attributes List
            sattribList.Add(sattrib);
        }
        //Console.WriteLine(sattribList[2]);
        return sattribList;
    }


    //Setters and Getters
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
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
}