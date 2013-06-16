
/*Coprights Reserved 2012 to Capablity Mapping Tool Team */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public abstract class Staff
{
    //Staff Attributes
    protected string Id;
    protected string firstName;
    protected string lastName;
    protected string emailId;
    protected string phoneNumber;
    protected Designation designation;
    protected bool active;


    //Setter and Getters
    public string ID
    {
        get { return this.Id;}
        set { this.Id = value; }
    }

    public string FirstName
    {
        get { return this.firstName; }
        set { this.firstName = value; }
    }

    public string LastName
    {
        get { return this.lastName; }
        set { this.lastName = value; }
    }

    public string EMailId
    {
        get { return this.emailId; }
        set { this.emailId = value; }
    }

    public string PhoneNumber
    {
        get { return this.phoneNumber; }
        set { this.phoneNumber = value; }
    }

    public Designation Designation
    {
        get { return this.designation; }
        set { this.designation = value; }
    }

    public bool Active
    {
        get { return this.active; }
        set { this.active = value; }
    }
}
