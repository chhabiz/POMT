
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class CourseAttributeOptionMapping
{
    public static List<string> transactionQueryList = new List<string>();

    //Instance Variables
    private int Id;
    private CourseOffering courseOffering;
    private string question;
    private SpecificationAttribute specificationAttribute;
    private SpecificationAttributeOption specificationAttributeOption;
    private SpecificationAttributeOptionKeyValue specificationAttributeOptionKeyValue;
    private string NonKeyText;


    //Default Constructor
    public CourseAttributeOptionMapping()
    {
    }

    //Creating a New Mapping Object
    public CourseAttributeOptionMapping(CourseOffering courseOffering, string question, SpecificationAttribute specificationAttribute, SpecificationAttributeOption specificationAttributeOption, SpecificationAttributeOptionKeyValue specificationAttributeOptionKeyValue, string NonKeyText)
    {
        this.CourseOffering = courseOffering;
        this.Question = question;
        this.SpecificationAttribute = specificationAttribute;
        this.SpecificationAttributeOption = specificationAttributeOption;
        this.SpecificationAttributeOptionKeyValue = specificationAttributeOptionKeyValue;
        this.NonKeyText = NonKeyText;
    }

    public CourseAttributeOptionMapping(int Id, CourseOffering courseOffering, string question, SpecificationAttribute specificationAttribute, SpecificationAttributeOption specificationAttributeOption, SpecificationAttributeOptionKeyValue specificationAttributeOptionKeyValue, string NonKeyText)
    {
        this.Id = Id;
        this.CourseOffering = courseOffering;
        this.Question = question;
        this.SpecificationAttribute = specificationAttribute;
        this.SpecificationAttributeOption = specificationAttributeOption;
        this.SpecificationAttributeOptionKeyValue = specificationAttributeOptionKeyValue;
        this.NonKeyText = NonKeyText;
    }


    //Creating New Mapping
    public bool CreateNewMapping(int sequenceNumber)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("InsertFormMappingEntry", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@CourseOfferingId", this.CourseOffering.Id);
        sqlcom.Parameters.AddWithValue("@Question", this.Question);
        sqlcom.Parameters.AddWithValue("@SequenceNumber", sequenceNumber);
        sqlcom.Parameters.AddWithValue("@SpecificationAttributeId", this.SpecificationAttribute.Id);
        sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionId", this.SpecificationAttributeOption.Id);
        try
        {
            sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionKeyValueId", this.SpecificationAttributeOptionKeyValue.Id);
        }
        catch (Exception)
        {
            sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionKeyValueId", SpecificationAttributeOptionKeyValue.GetSpecificationAttributeOptionKeyValueIdByValue("NONE"));
        }

        if (this.NonKeyText == null)
        {
            sqlcom.Parameters.AddWithValue("@NonKeyText", "NONE");
        }
        else
        {
            sqlcom.Parameters.AddWithValue("@NonKeyText", this.NonKeyText);
        }

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        sqlcom.Parameters.Clear();

        return true;
    }


    //Editing a Mapping in case of Form Rejected
    public bool EditMapping(int sequenceNumber, int offeringId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("INSERT INTO CourseAttributeOptionMapping(CourseOfferingId,Question,SequenceNumber,SpecificationAttributeId,SpecificationAttributeOptionId,KeyId,NonKeyText) VALUES(@CourseOfferingId,@Question,@SequenceNumber,@SpecificationAttributeId,@SpecificationAttributeOptionId,@SpecificationAttributeOptionKeyValueId,@NonKeyText)", sqlcon);

        //Setting the tempSpecificationAttributeId to the ULO Specification AttributeId
        int tempSpecificationAttributeId = new SpecificationAttribute("Unit learning outcomes (ULOs) table").Id;

        sqlcom.Parameters.AddWithValue("@CourseOfferingId", this.CourseOffering.Id).SqlDbType = SqlDbType.Int;
        sqlcom.Parameters.AddWithValue("@Question", this.Question).SqlDbType = SqlDbType.VarChar;
        sqlcom.Parameters.AddWithValue("@SequenceNumber", sequenceNumber).SqlDbType = SqlDbType.Int;
        sqlcom.Parameters.AddWithValue("@SpecificationAttributeId", this.SpecificationAttribute.Id).SqlDbType = SqlDbType.Int;
        sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionId", this.SpecificationAttributeOption.Id).SqlDbType = SqlDbType.Int;
        try
        {
            sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionKeyValueId", this.SpecificationAttributeOptionKeyValue.Id).SqlDbType = SqlDbType.Int;
        }
        catch (Exception)
        {
            sqlcom.Parameters.AddWithValue("@SpecificationAttributeOptionKeyValueId", SpecificationAttributeOptionKeyValue.GetSpecificationAttributeOptionKeyValueIdByValue("NONE")).SqlDbType = SqlDbType.Int;
        }

        if (this.NonKeyText == null)
        {
            sqlcom.Parameters.AddWithValue("@NonKeyText", "NONE").SqlDbType = SqlDbType.VarChar;
        }
        else
        {
            sqlcom.Parameters.AddWithValue("@NonKeyText", this.NonKeyText).SqlDbType = SqlDbType.VarChar;
        }

        //Getting the SqlCommand Query
        string query = sqlcom.CommandText;


        //Substituting the Sql Parameters with Parameter Values
        foreach (SqlParameter p in sqlcom.Parameters)
        {
            if (p.SqlDbType == SqlDbType.VarChar)
            {
                query = query.Replace(p.ParameterName, "'" + p.Value.ToString() + "'");
            }
            else
            {
                query = query.Replace(p.ParameterName, p.Value.ToString());
            }


        }

        transactionQueryList.Add(query.Trim());

        sqlcom.Parameters.Clear();

        return true;
    }


    public static void FireEdit(int specificationAttributeId, int courseOfferingId)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());
        SqlCommand sqlcom = new SqlCommand("", sqlcon);

        string deleteQuery= "DELETE FROM CourseAttributeOptionMapping WHERE SpecificationAttributeId=" + specificationAttributeId + " and CourseOfferingId=" + courseOfferingId;

        SqlTransaction EditTransaction=null;
        try
        {
            //Looping through all the Queries to Insert a Fresh Edited set of Mappings in a Transaction
            sqlcon.Open();

            //Begin a New Transaction
            EditTransaction = sqlcon.BeginTransaction();

            //Setting a Transaction to SqlCommand Transaction
            sqlcom.Transaction = EditTransaction;

            //Setting the Delete Query and Firing it as First Statement in the Transaction
            sqlcom.CommandText = deleteQuery;
            sqlcom.ExecuteNonQuery();

            //Iterating through all the Queries in the Queue for a Specific Specification Attribute Id for a Specific Course Offering
            foreach(string tempQuery in transactionQueryList)
            {
                //Setting the Queries in a Queue and Firing 
                sqlcom.CommandText = tempQuery.Trim();
                sqlcom.ExecuteNonQuery();   
            }

            //Commiting the Edit Transaction After Successful Completion of all the Queries
            EditTransaction.Commit();
            sqlcon.Close();
        }
        catch(Exception)
        {
            //Rolling Back the Edit Transaction
            EditTransaction.Rollback();
        }

        transactionQueryList.Clear();
    }


    //Get the ULO Id by Question
    public static int getULOId(string Question)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("GetULOIdByQuestion", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.Add("@Question", SqlDbType.VarChar).Value = Question;

        sqlcon.Open();
        int id = Convert.ToInt32(sqlcom.ExecuteScalar().ToString());
        sqlcon.Close();

        return id;
    }

    //Getters and Setters
    public CourseOffering CourseOffering
    {
        set { this.courseOffering = value; }
        get { return this.courseOffering; }
    }


    public string Question
    {
        set { this.question = value; }
        get { return this.question; }
    }

    public string NonKeyTextValue
    {
        set { this.NonKeyText = value; }
        get { return this.NonKeyText; }
    }



    public SpecificationAttribute SpecificationAttribute
    {
        set { this.specificationAttribute = value; }
        get { return this.specificationAttribute; }
    }

    public SpecificationAttributeOption SpecificationAttributeOption
    {
        set { this.specificationAttributeOption = value; }
        get { return this.specificationAttributeOption; }
    }

    public SpecificationAttributeOptionKeyValue SpecificationAttributeOptionKeyValue
    {
        set { this.specificationAttributeOptionKeyValue = value; }
        get { return this.specificationAttributeOptionKeyValue; }
    }



    public static List<CourseAttributeOptionMapping> getAllFormMappings(CourseOffering offering)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("GetAllFormMappings", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@OfferingId", SqlDbType.VarChar).Value = offering.Id;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<CourseAttributeOptionMapping> tempMappingList = new List<CourseAttributeOptionMapping>();

        CourseAttributeOptionMapping tempMapping = null;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            tempMapping = new CourseAttributeOptionMapping(Int32.Parse(dr["Id"].ToString().Trim()), new CourseOffering(Int32.Parse(dr["CourseOfferingId"].ToString().Trim())), dr["Question"].ToString(),
                new SpecificationAttribute(Int32.Parse(dr["SpecificationAttributeId"].ToString().Trim())), new SpecificationAttributeOption(Int32.Parse(dr["SpecificationAttributeOptionId"].ToString().Trim())),
                new SpecificationAttributeOptionKeyValue(Int32.Parse(dr["KeyId"].ToString().Trim())), dr["NonKeyText"].ToString().Trim());

            tempMappingList.Add(tempMapping);
        }

        return tempMappingList;
    }

    public static List<CourseAttributeOptionMapping> getAllFormMappingsWithSequenceNumber(CourseOffering offering)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand("GetAllFormMappings", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@OfferingId", SqlDbType.VarChar).Value = offering.Id;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<CourseAttributeOptionMapping> tempMappingList = new List<CourseAttributeOptionMapping>();

        CourseAttributeOptionMapping tempMapping = null;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            tempMapping = new CourseAttributeOptionMapping(Int32.Parse(dr["Id"].ToString().Trim()), new CourseOffering(Int32.Parse(dr["CourseOfferingId"].ToString().Trim())), dr["SequenceNumber"].ToString().Trim(),
                new SpecificationAttribute(Int32.Parse(dr["SpecificationAttributeId"].ToString().Trim())), new SpecificationAttributeOption(Int32.Parse(dr["SpecificationAttributeOptionId"].ToString().Trim())),
                new SpecificationAttributeOptionKeyValue(Int32.Parse(dr["KeyId"].ToString().Trim())), dr["NonKeyText"].ToString().Trim());

            tempMappingList.Add(tempMapping);
        }

        return tempMappingList;
    }

}