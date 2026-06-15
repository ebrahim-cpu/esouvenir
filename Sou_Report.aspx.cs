using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace eSouvenir
{
    public partial class Sou_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                lblUsername.Text = Session["Username"].ToString();
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }

            if (!IsPostBack)
            {
                PopulateYears();
            }
        }

        private void PopulateYears()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string query = "SELECT DISTINCT YEAR(CreatedDate) AS YearVal FROM Sou_UserRequest WHERE CreatedDate IS NOT NULL ORDER BY YearVal DESC";
            
            ddlYear.Items.Clear();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string y = reader["YearVal"].ToString();
                                ddlYear.Items.Add(new ListItem(y, y));
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Fallback if there's any database error
                    }
                }
            }

            // Default to current year if no years found in database
            if (ddlYear.Items.Count == 0)
            {
                string currentYear = DateTime.Now.Year.ToString();
                ddlYear.Items.Add(new ListItem(currentYear, currentYear));
            }
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            // AutoPostBack will trigger this, rebuilding the chart for the selected year
        }

        protected string GetChartDataJson()
        {
            int selectedYear = DateTime.Now.Year;
            if (ddlYear.SelectedItem != null)
            {
                int.TryParse(ddlYear.SelectedValue, out selectedYear);
            }

            int[] monthlyTotals = new int[12]; // Array for Jan-Dec (index 0 to 11)

            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string query = @"
                SELECT MONTH(CreatedDate) AS MonthNum, SUM(Quantity_Request) AS TotalQty
                FROM Sou_UserRequest
                WHERE YEAR(CreatedDate) = @Year AND CreatedDate IS NOT NULL
                GROUP BY MONTH(CreatedDate)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Year", selectedYear);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int month = Convert.ToInt32(reader["MonthNum"]);
                                int totalQty = Convert.ToInt32(reader["TotalQty"]);
                                if (month >= 1 && month <= 12)
                                {
                                    monthlyTotals[month - 1] = Math.Abs(totalQty);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Fallback leaves array values as 0
                    }
                }
            }

            return JsonConvert.SerializeObject(monthlyTotals);
        }
    }
}
