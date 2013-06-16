
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public class Snapshot
{
    //Instance Variables
    private int id;
    private string snapshotname;
    private DateTime timestamp;

    //Default Constructor
    public Snapshot()
    {
 
    }


    //Constructing a Snapshot Object
	public Snapshot(string name,DateTime timestmp)
	{
        //Setting the Snapshot Instance Variables
        this.SnapshotName = name;
        this.TimeStamp = timestmp;
	}


    //Create New Snapshot
    public bool CreateNewSnapshot()
    {
        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Create New Snapshot
        SqlCommand sqlcom = new SqlCommand("CreateNewSnapshot", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;

        sqlcom.Parameters.AddWithValue("@SnapshotName", this.SnapshotName);
        sqlcom.Parameters.AddWithValue("@TimeStamp", this.TimeStamp);

        sqlcon.Open();
        sqlcom.ExecuteNonQuery();
        sqlcon.Close();

        return true;
    }

    //Get All Snapshots
    public static List<Snapshot> GetAllSnapshots()
    {
        //Temporary Snapshot List
        List<Snapshot> snapshotList = new List<Snapshot>();
        Snapshot snapshot;

        SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CMT_CS"].ToString());

        //Stored Procedure to Get All the Snapshots
        SqlCommand sqlcom = new SqlCommand("GetAllSnapshots", sqlcon);
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcom);
        DataSet ds = new DataSet();

        sqlcon.Open();
        //Filling the DataSet with All the Snapshots's Details
        sqlda.Fill(ds);
        sqlcon.Close();

        //Creating the first Snapshot entry that is the current report.
        Snapshot currentRep = new Snapshot("Current Report", DateTime.Now);
        snapshotList.Add(currentRep);

        //Iterating through all the Snapshots
        foreach (DataRow dataRow in ds.Tables[0].Rows)
        {
            //Temporary Snapshot Object
            snapshot = new Snapshot();

            //Setting values to the Snapshot Object
            snapshot.Id = Convert.ToInt32(dataRow["Id"]);
            snapshot.SnapshotName = Convert.ToString(dataRow["SnapshotName"]);
            snapshot.TimeStamp = Convert.ToDateTime(dataRow["TimeStamp"]);

            //Adding the Snapshot to the Snapshot List
            snapshotList.Add(snapshot);
        }

        return snapshotList;
    }


    //Setters and Getters
    public int Id
    {
        get { return this.id; }
        set { this.id = value; }
    }

    public string SnapshotName
    {
        set { this.snapshotname = value; }
        get { return this.snapshotname; }
    }

    public DateTime TimeStamp
    {
        set { this.timestamp = value; }
        get { return this.timestamp; }
    }

}