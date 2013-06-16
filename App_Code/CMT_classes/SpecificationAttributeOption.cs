
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class SpecificationAttributeOption
{
    //Instance Variables
    private int id;
    private SpecificationAttribute specificationAttribute;
    private string name;
    private bool haskeyvalue;
    // private string description;


    //Default Constructor
    public SpecificationAttributeOption()
    {

    }


    public static bool hasKeyValuePair(int Id)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("hasKeyValuePair", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Id",Id);

        sqlcon.Open();
        bool result = Convert.ToBoolean(sqlcom.ExecuteScalar().ToString());
        sqlcon.Close();

        return result;
    }

    public List<SpecificationAttributeOption> testData ()
    {
        List<SpecificationAttributeOption> testList = new List<SpecificationAttributeOption>();
        SpecificationAttributeOption data1 = new SpecificationAttributeOption();
        data1.id = 1;
        data1.name = "data1";
        SpecificationAttributeOption data2 = new SpecificationAttributeOption();
        data2.id = 2;
        data2.name ="data2";
        testList.Add(data1);
        testList.Add(data2);

        return testList;
    
    }


    /*Construction Object based on Name
     Note: SpecificationAttribute taken as an argument bcoz of the case when two 
                SpecificationAttributes have SpecificationAttributeOptions of same name..*/
    public SpecificationAttributeOption(SpecificationAttribute specificationAttribute, string name, bool haskey)
    {
        this.name = name;
        this.specificationAttribute = specificationAttribute;
        this.haskeyvalue = haskey;

    }

    //Constructor with SpecificationAttributeOptionId from the database to construct the SpecificationAttributeOption object

    public SpecificationAttributeOption(int optionid)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New College
        SqlCommand sqlcom = new SqlCommand("GetAttributeOptionById", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@Id", optionid);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr, "SpecificationAttributeOptionById");
        sqlcon.Close();

        this.Id = optionid;
        this.Name = Convert.ToString(dsattr.Tables["SpecificationAttributeOptionById"].Rows[0]["Name"]);
        this.SpecificationAttribute = new SpecificationAttribute(Convert.ToInt32(dsattr.Tables["SpecificationAttributeOptionById"].Rows[0]["SpecificationAttributeId"]));

    }


    //Construction an Object Using Specification Attribute Option Name

    public SpecificationAttributeOption(string name)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("GetSpecificationAttributeOptionByName", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.AddWithValue("@name", name);

        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr);
        sqlcon.Close();

        this.Id = Int32.Parse(dsattr.Tables[0].Rows[0]["Id"].ToString().Trim());
        this.Name = name;
        this.SpecificationAttribute = new SpecificationAttribute(Convert.ToInt32(dsattr.Tables[0].Rows[0]["SpecificationAttributeId"]));

    }

    //Create New SpecificationAttributeOption
    public bool CreateNewSpecificationAttributeOption()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Specification Attribute Option
        SqlCommand sqlcom = new SqlCommand("CreateNewSpecificationOption", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@SpecificationAttributeId", this.SpecificationAttribute.Id);
        sqlcom.Parameters.AddWithValue("@OptionName", this.Name);
        sqlcom.Parameters.AddWithValue("@HasKey", this.HasKeyValue);

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;
    }

    //Deactivate SpecificationAttribute
    public bool DeactivateSpecificationAttributeOption()
    {
        return true;
    }

    //Reactivate SpecificationAttribute
    public bool ReactivatorSpecificationAttributeOption()
    {
        return true;
    }

    //Get All Specification Attributes Options for a SpecificationAttribute
    public static List<SpecificationAttributeOption> GetAllSpecificationAttributeOptions(int SpecificationAttribId)
    {
        //Temporary SpecificationAttribute Options List
        List<SpecificationAttributeOption> sattribOptList = new List<SpecificationAttributeOption>();
        SpecificationAttributeOption sattribopt;
        SpecificationAttribute sattrib = null;

        //Get all the SpecificationAttributes
        List<SpecificationAttribute> tempList = SpecificationAttribute.GetAllSpecificationAttributes();
        List<SpecificationAttribute> filteredList = new List<SpecificationAttribute>();

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Specification Attribute Options
        SqlCommand sqlcom = new SqlCommand("GetAllSpecificationAttributeOptionsBySpecificationAttributeId", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add("@SpecificationAttributeId", SqlDbType.VarChar).Value = SpecificationAttribId;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet dsattr = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Specification Attribute Options' Details
        sqlda.Fill(dsattr, "SpecificationAttributeOption");
        sqlcon.Close();

        //Iterating through all the Specification Attribute Options
        foreach (DataRow dataRow in dsattr.Tables["SpecificationAttributeOption"].Rows)
        {
            //Temporary Specification Attribute Option Object
            sattribopt = new SpecificationAttributeOption();

            //Setting values to the Specification Attributes Object
            sattribopt.id = Convert.ToInt32(dataRow["Id"]);
            sattribopt.Name = Convert.ToString(dataRow["Name"]);

            //Get Parent Specification Attribute for each Specification Attribute Option
            var query = from SpecificationAttribute spAttribute in tempList
                        where spAttribute.Id.Equals(SpecificationAttribId)
                        select spAttribute;
            foreach (SpecificationAttribute s in query)
            {
                sattrib = s;
                break;
            }
            sattribopt.specificationAttribute = sattrib;
            //Adding the Specification Attributes to the Specification Attributes List
            sattribOptList.Add(sattribopt);
        }
        //Console.WriteLine(sattribList[2]);
        return sattribOptList;
    }


    //Gets All Keys for a SpecificationAttributeOption
    public List<SpecificationAttributeOptionKeyValue> getAllKeyValuePairs()
    {
        return new List<SpecificationAttributeOptionKeyValue>();
    }
  
    //Setters and Getters
    public int Id
    {
        set { this.id = value; }
        get { return this.id; }
    }

    public SpecificationAttribute SpecificationAttribute
    {
        set { this.specificationAttribute = value; }
        get { return this.specificationAttribute; }
    }

    public string Name
    {
        set { this.name = value; }
        get { return this.name; }
    }

    public bool HasKeyValue
    {
        set { this.haskeyvalue = value; }
        get { return this.haskeyvalue; }
    }

    /*  public string Description
      {
          set { this.description = value; }
          get { return this.description; }
      } */
}