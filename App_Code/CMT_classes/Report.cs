
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;



public class Report
{
    private College college;
    private School school;
    private Program program;

    //Default Constructor
    public Report()
    {
    }

    //Constructing Report Object
	public Report(College college,School school, Program program)
	{
        this.College = college;
        this.School = school;
        this.Program = program;
	}

    //View Report For a Program of a School of a College
    public void ViewReport()
    {

    }

    //Saving a Report in a PDF
    public bool SaveReport()
    {
        return true;
    }

    //Getters and Setters
    public College College
    {
        set { this.college = value; }
        get { return this.college; }
    }

    public School School
    {
        set { this.school = value; }
        get { return this.school; }
    }

    public Program Program
    {
        set { this.program = value; }
        get { return this.program; }
    }

}