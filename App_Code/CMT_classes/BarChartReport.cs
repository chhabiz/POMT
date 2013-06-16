 
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;



public class BarChartReport
{
    private String category;
    private String yearSemData;
    private int count;
    private int percentage;

    //Default Constructor
    public BarChartReport()
    {
    }

    //Constructing Report Object
	public BarChartReport(String Category, String yrsmData,int Count, int Percentage)
	{
        this.Category = Category;
        this.Count = Count;
        this.Percentage = Percentage;
        this.YearSemData = yrsmData;
	}


    //This method gets the List of all the Bar Chart Report Data from the Stored Procedures per Program

    public static List<BarChartReport> getReportBarChartStatistics(String programCode, String calendarYear,String sprocedureName)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@ProgCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            String progSemYr="Y"+Convert.ToString(dataRow["ProgramYear"])+"S"+Convert.ToString(dataRow["ProgramSem"]);
            reportData = new BarChartReport();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportData.YearSemData =progSemYr;
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Bar Chart Report Data from the Stored Procedures per Program for PAC

    public static List<BarChartReport> getReportPACBarChartStatistics(String programCode, String calendarYear, String sprocedureName, String pac)
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        SqlCommand sqlcom = new SqlCommand(sprocedureName, sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcom.Parameters.Add("@ProgramCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@ProgCode", SqlDbType.VarChar).Value = programCode;
        sqlcom.Parameters.Add("@CalendarYear", SqlDbType.DateTime).Value = calendarYear;
        sqlcom.Parameters.Add("@PAC", SqlDbType.VarChar).Value = pac;

        sqlcon.Open();
        da.Fill(ds);
        sqlcon.Close();

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            String progSemYr = "Y" + Convert.ToString(dataRow["ProgramYear"]) + "S" + Convert.ToString(dataRow["ProgramSem"]);
            reportData = new BarChartReport();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportData.YearSemData = progSemYr;
            reportDataList.Add(reportData);
        }

        return reportDataList;
    } 
	
    //This method gets the List of all the Bar Chart Report Data in Proportions from the Stored Procedures per Program

    public static List<BarChartReport> getReportBarChartStatisticsProp(String programCode, String calendarYear, String sprocedureName)
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

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            String week = "Week " + Convert.ToString(dataRow["DueWeek"]);
            reportData = new BarChartReport();
            reportData.Category = week;
            reportData.Count = Convert.ToInt32(dataRow["Proportion"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Bar Chart Report Data in Proportions from the Stored Procedures per Program for PAC

    public static List<BarChartReport> getReportPACBarChartStatisticsProp(String programCode, String calendarYear, String sprocedureName, String pac)
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

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            String week = "Week " + Convert.ToString(dataRow["DueWeek"]);
            reportData = new BarChartReport();
            reportData.Category = week;
            reportData.Count = Convert.ToInt32(dataRow["Proportion"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Bar Chart Report Data from the Stored Procedures per Program
    //For Triple I Curriculum Themes

    public static List<BarChartReport> getReportTripleIBarChartStatistics(String programCode, String calendarYear, String sprocedureName)
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

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            reportData = new BarChartReport();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportData.YearSemData = Convert.ToString(dataRow["Level"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
    }

    //This method gets the List of all the Bar Chart Report Data from the Stored Procedures per Program
    //For Australian Blueprint for Career Development

    public static List<BarChartReport> getReportABCDBarChartStatistics(String programCode, String calendarYear, String sprocedureName)
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

        List<BarChartReport> reportDataList = new List<BarChartReport>();

        BarChartReport reportData;
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Getting Data for Reports
            reportData = new BarChartReport();
            reportData.Category = Convert.ToString(dataRow["Value"]);
            reportData.Count = Convert.ToInt32(dataRow["Occurences"]);
            reportData.YearSemData = Convert.ToString(dataRow["Question"]);
            reportDataList.Add(reportData);
        }

        return reportDataList;
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

    public String YearSemData
    {
        set { this.yearSemData = value; }
        get { return this.yearSemData; }
    }
}