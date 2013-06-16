
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class SpecificationAttributeOptionKeyValue
{
    //Instance Variables
    private int id;
    private SpecificationAttributeOption specificationAttributeOption;
    private string key;
    private string value;
    private bool active;


    //Constructing SpecificationAttributeOptionKeyValue Object
    public SpecificationAttributeOptionKeyValue(int id, SpecificationAttributeOption specificationAttributeOption,string key,string value,bool active)
	{
        this.Id = id;
        this.SpecificationAttributeOption = specificationAttributeOption;
        this.Key = key;
        this.Value = value;
        this.Active = active;
	}

    //Constructing SpecificationAttributeOptionKeyValue Object
    public SpecificationAttributeOptionKeyValue(SpecificationAttributeOption specificationAttributeOption, string key, string value, bool active)
    {
        this.SpecificationAttributeOption = specificationAttributeOption;
        this.Key = key;
        this.Value = value;
        this.Active = active;
    }



    //Set Up an Object Based on the id
    public SpecificationAttributeOptionKeyValue(int id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to fetch key value pair by Id
        SqlCommand sqlcom = new SqlCommand("GetKeyValueById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Id", id);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr, "KeyValueById");
        sqlcon.Close();

        this.Id = id;
        this.Key=Convert.ToString(dsattr.Tables["KeyValueById"].Rows[0]["Key"]);
        this.Value=Convert.ToString(dsattr.Tables["KeyValueById"].Rows[0]["Value"]);
        this.Active=Convert.ToBoolean(dsattr.Tables["KeyValueById"].Rows[0]["Active"]);
        this.SpecificationAttributeOption = new SpecificationAttributeOption(Convert.ToInt32(dsattr.Tables["KeyValueById"].Rows[0]["SpecificationAttributeOptionId"]));
    }

    //Default Constructor
    public SpecificationAttributeOptionKeyValue()
    {
    }

    //Get Id By Name
    public static int GetSpecificationAttributeOptionKeyValueIdByValue(string name)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("[GetSpecificationOptionKeyValueIdByValue]", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Value", name);
        
        sqlcon.Open();
        int Id = Convert.ToInt32(sqlcom.ExecuteScalar().ToString());
        sqlcon.Close();

        return Id;
    }

    //Create New SpecificationAttributeOptionKeyValue
    public bool CreateNewSpecificationAttributeOptionKeyValue()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("CreateNewKeyValuePair", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionId", this.SpecificationAttributeOption.Id);
        sqlcom.Parameters.AddWithValue("@Key", this.Key);
        sqlcom.Parameters.AddWithValue("@Value", this.Value);
        sqlcom.Parameters.AddWithValue("@Active", this.Active);

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;
    }

    //Deactivate SpecificationAttributeOptionKeyValue
    public bool DeactivateSpecificationAttributeOptionKeyValue()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Deactivate the key value pair
        SqlCommand sqlcom = new SqlCommand("DeactivateKeyValue", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@Id", this.Id);

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;
    }

    //Reactivate SpecificationAttributeOptionKeyValue
    public bool ReactivatorSpecificationAttributeOptionKeyValue()
    {
        return true;
    }

    //Get All Key Value Pairs for a SpecificationAttributeOption
    public static List<SpecificationAttributeOptionKeyValue> GetAllKeyValuePairs(int SpecificationOptId)
    {
        //Temporary Key Value List
        List<SpecificationAttributeOptionKeyValue> sattribKVList = new List<SpecificationAttributeOptionKeyValue>();
        SpecificationAttributeOptionKeyValue sattribkv;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Key Value Pairs
        SqlCommand sqlcom = new SqlCommand("GetAllKeyValuePairs", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@SpecificationAttributeOptionId", SqlDbType.VarChar).Value = SpecificationOptId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Key Value Pairs' Details
        sqlda.Fill(dsattr, "KeyValueTable");
        sqlcon.Close();

        //Iterating through all the Key Value Pairs
        foreach (DataRow dataRow in dsattr.Tables["KeyValueTable"].Rows)
        {
            //Temporary Key Value Pair Object
            sattribkv = new SpecificationAttributeOptionKeyValue();

            //Setting values to the Key Value Pair Object
            sattribkv.id = Convert.ToInt32(dataRow["Id"]);
            sattribkv.key=Convert.ToString(dataRow["Key"]);
            sattribkv.value = Convert.ToString(dataRow["Value"]);
            sattribkv.active=Convert.ToBoolean(dataRow["Active"]);
            SpecificationAttributeOption soption = new SpecificationAttributeOption(Convert.ToInt32(dataRow["SpecificationAttributeOptionId"]));
            sattribkv.specificationAttributeOption = soption;
            //Adding the Specification Attributes Options to the Specification Attributes Options List
            sattribKVList.Add(sattribkv);
        }
        //Console.WriteLine(sattribList[2]);
        return sattribKVList;
    }

    //Get All Key Value Pairs for a SpecificationAttributeOption to populate user form
    public static List<SpecificationAttributeOptionKeyValue> GetAllKeyValueByName(String SpecificationOptName)
    {
        //Temporary Key Value List
        List<SpecificationAttributeOptionKeyValue> sattribKVList = new List<SpecificationAttributeOptionKeyValue>();
        SpecificationAttributeOptionKeyValue sattribkv;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Key Value Pairs
        SqlCommand sqlcom = new SqlCommand("GetAllKVPairsByName", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@SpecificationAttributeOption", SqlDbType.VarChar).Value = SpecificationOptName;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Key Value Pairs' Details
        sqlda.Fill(dsattr, "KeyValueTable");
        sqlcon.Close();

        //Iterating through all the Key Value Pairs
        foreach (DataRow dataRow in dsattr.Tables["KeyValueTable"].Rows)
        {
            //Temporary Key Value Pair Object
            sattribkv = new SpecificationAttributeOptionKeyValue();

            //Setting values to the Key Value Pair Object
            sattribkv.id = Convert.ToInt32(dataRow["Id"]);
            sattribkv.key = Convert.ToString(dataRow["Key"]);
            sattribkv.value = Convert.ToString(dataRow["Value"]);
            sattribkv.active = Convert.ToBoolean(dataRow["Active"]);
            SpecificationAttributeOption soption = new SpecificationAttributeOption(Convert.ToInt32(dataRow["SpecificationAttributeOptionId"]));
            sattribkv.specificationAttributeOption = soption;
            //Adding the Specification Attributes Options to the Specification Attributes Options List
            sattribKVList.Add(sattribkv);
        }
        //Console.WriteLine(sattribList[2]);
        return sattribKVList;
    }

    //Get All Key Value Pairs for Managing All Register Attributes
    public static List<SpecificationAttributeOptionKeyValue> GetManageKVPairs(String sprocName)
    {
        //Temporary Key Value List
        List<SpecificationAttributeOptionKeyValue> sattribKVList = new List<SpecificationAttributeOptionKeyValue>();
        SpecificationAttributeOptionKeyValue sattribkv;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Key Value Pairs
        SqlCommand sqlcom = new SqlCommand(sprocName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Key Value Pairs' Details
        sqlda.Fill(dsattr, "SpKeyValueTable");
        sqlcon.Close();

        //Iterating through all the Key Value Pairs
        foreach (DataRow dataRow in dsattr.Tables["SpKeyValueTable"].Rows)
        {
            //Temporary Key Value Pair Object
            sattribkv = new SpecificationAttributeOptionKeyValue();

            //Setting values to the Key Value Pair Object
            sattribkv.id = Convert.ToInt32(dataRow["Id"]);
            //sattribkv.key = Convert.ToString(dataRow["Key"]);
            sattribkv.value = Convert.ToString(dataRow["Value"]);
            sattribkv.active = Convert.ToBoolean(dataRow["Active"]);
            SpecificationAttributeOption soption = new SpecificationAttributeOption(Convert.ToInt32(dataRow["SpecificationAttributeOptionId"]));
            sattribkv.specificationAttributeOption = soption;
            //Adding the Specification Attributes Options to the Specification Attributes Options List
            sattribKVList.Add(sattribkv);
        }
        //Console.WriteLine(sattribList[2]);
        return sattribKVList;
    }


    //created by Mk, to get all the key values when specification the table id.
    public static List<SpecificationAttributeOptionKeyValue> GetManageKVPairs(int SAId)
    {
        //Temporary Key Value List
        List<SpecificationAttributeOptionKeyValue> sattribKVList = new List<SpecificationAttributeOptionKeyValue>();
        SpecificationAttributeOptionKeyValue sattribkv;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Key Value Pairs
        SqlCommand sqlcom = new SqlCommand("ManageULOKVPairs", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add("@Id", SqlDbType.VarChar).Value = SAId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Key Value Pairs' Details
        sqlda.Fill(dsattr, "SAKVPairs");
        sqlcon.Close();

        //Iterating through all the Key Value Pairs
        foreach (DataRow dataRow in dsattr.Tables["SAKVPairs"].Rows)
        {
            //Temporary Key Value Pair Object
            sattribkv = new SpecificationAttributeOptionKeyValue();

            //Setting values to the Key Value Pair Object
            sattribkv.id = Convert.ToInt32(dataRow["Id"]);
            sattribkv.value = Convert.ToString(dataRow["Value"]);
            sattribkv.active = Convert.ToBoolean(dataRow["Active"]);
            SpecificationAttributeOption soption = new SpecificationAttributeOption();
            soption.Name = Convert.ToString(dataRow["Name"]);
            sattribkv.specificationAttributeOption = soption;
            //Adding the Specification Attributes Options to the Specification Attributes Options List
            sattribKVList.Add(sattribkv);
        }
        return sattribKVList;
    }

    public void updateKey(int id, String value, bool active) {

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("updateKeys", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add("@Id", SqlDbType.Int).Value = id;
        sqlcom.Parameters.Add("@Value", SqlDbType.VarChar).Value = value;
        sqlcom.Parameters.Add("@Active", SqlDbType.Bit).Value = active;
        sqlcon.Open();
        sqlcom.ExecuteScalar();
        sqlcon.Close();
        
    }

    public void insertKey(String name, String value, bool active) {

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("CreateNewKeyValuePairBeta", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add("@SpecificationAttributeName", SqlDbType.VarChar).Value = name;
        sqlcom.Parameters.Add("@Value", SqlDbType.VarChar).Value = value;
        sqlcom.Parameters.Add("@Active", SqlDbType.Bit).Value = active;
        sqlcon.Open();
        sqlcom.ExecuteScalar();
        sqlcon.Close();
        
    }
    
    

    //Setters and Getters

    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public SpecificationAttributeOption SpecificationAttributeOption
    {
        set { this.specificationAttributeOption = value; }
        get { return this.specificationAttributeOption; }
    }

    public string Key
    {
        set { this.key = value; }
        get { return this.key; }
    }

    public string Value
    {
        set { this.value = value; }
        get { return this.value; }
    }

    public bool Active
    {
        set { this.active = value; }
        get { return this.active; }
    }
}