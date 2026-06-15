using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace eSouvenir
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateVisitorCount();
                TangkapInfoPelawat();
            }
        }
        private void UpdateVisitorCount()
        {
            string pageName = "Login.aspx"; // Change this based on your page name
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            int visitCount = 0;
            DateTime lastVisited = DateTime.Now;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Check if the page entry already exists in the database
                SqlCommand checkCmd = new SqlCommand("SELECT VisitCount, LastVisited FROM Sou_VisitorCount WHERE PageName = @PageName", connection);
                checkCmd.Parameters.AddWithValue("@PageName", pageName);
                SqlDataReader reader = checkCmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    visitCount = Convert.ToInt32(reader["VisitCount"]);
                    lastVisited = Convert.ToDateTime(reader["LastVisited"]);
                    Label3.Text = "Visitor Count:";
                    //Label3.ForeColor = Color.Red;
                    Label1.Visible = true;
                    Label1.Text = visitCount.ToString();
                    Label2.Text = "Last Visit:";
                    Label4.Text = lastVisited.ToString();
                    reader.Close();
                }
                else
                {
                    reader.Close();
                    // If the page entry doesn't exist, insert a new record for the page
                    SqlCommand insertCmd = new SqlCommand("INSERT INTO Sou_VisitorCount (PageName, VisitCount, LastVisited) VALUES (@PageName, @VisitCount, @LastVisited)", connection);
                    insertCmd.Parameters.AddWithValue("@PageName", pageName);
                    insertCmd.Parameters.AddWithValue("@VisitCount", visitCount);
                    insertCmd.Parameters.AddWithValue("@LastVisited", lastVisited);
                    insertCmd.ExecuteNonQuery();
                }
                // Update the visit count and last visited date
                visitCount++;
                lastVisited = DateTime.Now;
                // Update the database with the new values
                SqlCommand updateCmd = new SqlCommand("UPDATE Sou_VisitorCount SET VisitCount = @VisitCount, LastVisited = @LastVisited WHERE PageName = @PageName", connection);
                updateCmd.Parameters.AddWithValue("@PageName", pageName);
                updateCmd.Parameters.AddWithValue("@VisitCount", visitCount);
                updateCmd.Parameters.AddWithValue("@LastVisited", lastVisited);
                updateCmd.ExecuteNonQuery();
                connection.Close();
            }
        }
        private void TangkapInfoPelawat()
        {
            string ipAddress = Request.UserHostAddress;
            SqlConnection konn = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ToString());
            konn.Open();
            using (SqlCommand arahan = new SqlCommand("Sou_SPInsertVisitorLog", konn))
            {
                arahan.CommandType = CommandType.StoredProcedure;
                arahan.Parameters.AddWithValue("@Ip_Address", ipAddress);
                arahan.ExecuteNonQuery();
            }
        }
        protected string CapaiIPaddress()
        {
            string ipaddress = Request.ServerVariables["HTTP_X_CLUSTER_CLIENT_IP"];
            if (ipaddress == null || ipaddress == "")
                ipaddress = Request.ServerVariables["REMOTE_ADDR"];
            return ipaddress;
        }
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            //var Kebenaran = new FormsAuth.LdapAuthentication("LDAP://KHTP");
            //bool PenggunaSah = Kebenaran.IsAuthenticated("KHTP", txtUsername.Text.Trim(), txtPassword.Text.Trim());
            Session["Username"] = txtUsername.Text; // untuk run local
            bool PenggunaSah = true; // untuk run local
            Label1.Text = PenggunaSah.ToString();
            Label3.Text = PenggunaSah.ToString();
            if (PenggunaSah)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HQConnectionString"].ToString());
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = string.Format("SELECT IsAdmin_eSouvenir,IsUser_eSouvenir, IsHead_eSouvenir,Username,Department,Divisyen,Email FROM Pekerja WHERE Username ='{0}'", Session["Username"]);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        Session["IsAdmin"] = dt.Rows[0]["IsAdmin_eSouvenir"];
                        Session["IsUser"] = dt.Rows[0]["IsUser_eSouvenir"];
                        Session["IsHead"] = dt.Rows[0]["IsHead_eSouvenir"];
                        Session["Username"] = dt.Rows[0]["Username"];
                        Session["Department"] = dt.Rows[0]["Department"];
                        Session["Divisyen"] = dt.Rows[0]["Divisyen"];
                        Session["email"] = dt.Rows[0]["Email"];
                        // AuditTrailAkses();
                        if ((bool)(Session["IsAdmin"]))
                        {
                            Response.Redirect("Sou_Kelulusan_Souvenir.aspx");
                        }
                        else
                        if ((bool)(Session["IsUser"]))
                        { Response.Redirect("Sou_Senarai_Item_User.aspx"); }
                    }
                }
            }
            else
            {
                Label2.Text = "Username atau Password tak betul!";
                Label2.ForeColor = Color.Red;
                Label2.Visible = true;
                Label3.Text = DateTime.Now.ToString();
            }
        }
        protected void AuditTrailAkses()
        {
            SqlConnection konn = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ToString());
            konn.Open();
            String kariAyam = @"INSERT INTO Sou_LOG_Access(Username,Department,Division,TimeDateAccess,LocationAccess) VALUES (@Username,@Department,@Division,@TimeDateAccess,@LocationAccess)";
            SqlCommand arahan = new SqlCommand(kariAyam, konn);
            arahan.Parameters.AddWithValue("@Username", Session["Username"]);
            arahan.Parameters.AddWithValue("@Department", Session["Department"]);
            arahan.Parameters.AddWithValue("@Division", Session["Divisyen"]);
            arahan.Parameters.AddWithValue("@TimeDateAccess", DateTime.Now);
            arahan.Parameters.AddWithValue("@LocationAccess", CapaiIPaddress());
            int kambing = Convert.ToInt32(arahan.ExecuteScalar());
            konn.Close();
        }
    }
}