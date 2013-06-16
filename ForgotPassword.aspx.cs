using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;

namespace CurriculumMapping
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPass_Click(object sender, EventArgs e)
        {
            string pass = Driver.ForgotPassword(txtUsername.Text.ToString(), txtEmail.Text.ToString());

            if (pass.Length == 0)
            {
                lblMessage.Text = "User with the provided details does not exist";
            }
            else
            {
                //Send mail functionality for forgot password if firewall allows port 587

                MailMessage loginInfo = new MailMessage();
                loginInfo.To.Add(txtEmail.Text.ToString());
                loginInfo.From = new MailAddress("rmit.mappingtool@gmail.com");
                loginInfo.Subject = "Forgot Password Information";

                loginInfo.Body = "Username: " + txtUsername.Text.ToString() + "<br><br>Password: " + pass + "<br><br>";
                loginInfo.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.Credentials = new System.Net.NetworkCredential("rmit.mappingtool@gmail.com", "YoursoftRmit12");
                try
                {
                    smtp.Send(loginInfo);
                    lblMessage.Text = "Password has been sent to your email address,you can now <a href='Login.aspx'>Login</a> using the credentials provided";
                }
                catch (Exception)
                {
                    lblMessage.Text = "Error sending email. Please check if port 587 is open or check your firewall rules";
                }                
            }
        }
    }
}