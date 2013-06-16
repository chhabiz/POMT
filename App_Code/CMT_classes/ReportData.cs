 
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;



public class ReportData
{
    private String category;
    private int count;
    private int percentage;

    //Default Constructor
    public ReportData()
    {
    }

    //Constructing Report Object
	public ReportData(String Category,int Count, int Percentage)
	{
        this.Category = Category;
        this.Count = Count;
        this.Percentage = Percentage;
	}


    //This method gets the List of all the Report Data from the Stored Procedures per Program in a Semester

    public static List<ReportData> getReportLOTStatistics(String programCode, String calendarYear,String sprocedureName)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            reportData = new ReportData();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Report Data from the Stored Procedures per Program in a Semester for a Particular PAC

    public static List<ReportData> getReportPACStatistics(String programCode, String calendarYear, String sprocedureName,String pac)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;
        sqlcom.Parameters.Add("@PAC", SqlDbType.VarChar).Value = pac;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            reportData = new ReportData();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    } 

    //This method gets the List of all the Report Data from the Stored Procedures per Program in a Semester

    public static List<ReportData> getReportLOTStatisticsPercentage(String programCode, String calendarYear, String sprocedureName)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        double countSum = getReportLOTSumCount(programCode,calendarYear,sprocedureName);

        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            int countData=Convert.ToInt32(dataRow["Occurences"]);
            reportData = new ReportData();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Percentage = Convert.ToInt32((countData*100)/countSum);
            reportDataList.Add(reportData);
        }

        countSum = 0;
        return reportDataList;
    }

    //This method gets the List of all the Report Data from the Stored Procedures per Program in a Semester for PAC

    public static List<ReportData> getReportPACStatisticsPercentage(String programCode, String calendarYear, String sprocedureName, String pac)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;
        sqlcom.Parameters.Add("@PAC", SqlDbType.VarChar).Value = pac;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        double countSum = getReportPACSumCount(programCode, calendarYear, sprocedureName,pac);

        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            int countData = Convert.ToInt32(dataRow["Occurences"]);
            reportData = new ReportData();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            try
            {
                reportData.Percentage = Convert.ToInt32((countData * 100) / countSum);
            }
            catch (Exception e)
            {
                reportData.Percentage = 100;
            }
            reportDataList.Add(reportData);
        }

        countSum = 0;
        return reportDataList;
    }

    //This method gets the List of all the Weighted Report Data from the Stored Procedures per Program in a Semester

    public static List<ReportData> getReportLOTStatisticsProp(String programCode, String calendarYear, String sprocedureName)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        double countSum = getReportLOTSumCount(programCode,calendarYear,sprocedureName);
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Populating the List for Report
            reportData = new ReportData();
            double propValue=Convert.ToDouble(dataRow["Occurences"]);
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Percentage = Convert.ToInt32((propValue * 100) / countSum);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Weighted Report Data from the Stored Procedures per Program in a Semester

    public static List<ReportData> getReportPACStatisticsProp(String programCode, String calendarYear, String sprocedureName, String pac)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;
        sqlcom.Parameters.Add("@PAC", SqlDbType.VarChar).Value = pac;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<ReportData> reportDataList = new List<ReportData>();

        ReportData reportData;
        double countSum = getReportPACSumCount(programCode, calendarYear, sprocedureName,pac);
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Populating the List for Report
            reportData = new ReportData();
            double propValue = Convert.ToDouble(dataRow["Occurences"]);
            reportData.Category = Convert.ToString(dataRow["Value"]);
            try
            {
                reportData.Percentage = Convert.ToInt32((propValue * 100) / countSum);
            }
            catch (Exception e)
            {
                reportData.Percentage = 100;
            }
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the Sum of all the Counts

    public static double getReportLOTSumCount(String programCode, String calendarYear, String sprocedureName)
    {
        double sumCount = 0;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            double addedCount=Convert.ToDouble(dataRow["Occurences"]);
            sumCount = sumCount+addedCount;
        }

        return sumCount;
    }

    //This method gets the Sum of all the Counts for PAC

    public static double getReportPACSumCount(String programCode, String calendarYear, String sprocedureName, String pac)
    {
        double sumCount = 0;
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;
        sqlcom.Parameters.Add("@PAC", SqlDbType.VarChar).Value = programCode;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Setting Up a Mapping Object
            double addedCount = Convert.ToDouble(dataRow["Occurences"]);
            sumCount = sumCount + addedCount;
        }

        return sumCount;
    }


    //Getters and Setters
    public String Category
    {
        set { this.category = value; }
        get { return this.category; }
    }

    public int Count
    {
        set { this.count = value; }
        get { return this.count; }
    }

    public int Percentage
    {
        set { this.percentage = value; }
        get { return this.percentage; }
    }
}