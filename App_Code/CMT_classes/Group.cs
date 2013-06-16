
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Group
{
    private int id;
    private string name;
    private string description;

    //Default Constructor
    public Group()
    {

    }

    //Construct a Group Object
    public Group(string name,string description)
	{
        this.Name = name;
        this.Description = description;
	}

    //Checks if a Group Exist
    public bool Exist(Group group)
    {
        return true;
    }

    //Create a New Group
    public bool CreateNewGroup()
    {
        return true;
    }

    //Deactivate Group
    public bool DeactivateGroup()
    {
        return true;
    }

    //Reactivate Group
    public bool ReactivateGroup()
    {
        return true;
    }



    //Setters and Getters
    public string Description
    {
        set { this.description = value; }
        get { return this.description; }
    }

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
}