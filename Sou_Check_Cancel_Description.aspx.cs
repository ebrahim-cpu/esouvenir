using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Check_Cancel_Description : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the session variable exists and has a value
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                // Set the value of the label to the session variable value
                lblUsername.Text = Session["Username"].ToString();

                string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();

                // Update the welcome message with the value from the label lblUsername
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";

                if (!IsPostBack)
                {
                    if (Request.QueryString["id"] != null && Request.QueryString["pemohon"] != null)
                    {
                        txtId.Text = Request.QueryString["id"];
                        txtNamaPengguna.Text = Server.UrlDecode(Request.QueryString["pemohon"]);

                        // Retrieve and display cancellation description
                        string requestId = Request.QueryString["id"];
                        string cancelDescription = RetrieveCancelDescriptionFromDatabase(requestId);
                        txtCancelDescription.Text = cancelDescription;



                        // Retrieve other data associated with the selected row using the provided id
                        PopulateTextFieldsFromDatabase(requestId, pemohonName);
                    }
                }
            }
        }

        // You need to define the RetrieveCancelDescriptionFromDatabase method
        // Updated method to retrieve CancelDescribtionAdmin n User from the database
        private string RetrieveCancelDescriptionFromDatabase(string id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string cancelDescription = "";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string selectQuery = "SELECT Cancel_Description FROM Sou_UserRequest WHERE Id = @RequestId";

                using (SqlCommand cmd = new SqlCommand(selectQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@RequestId", id);

                    connection.Open();
                    object result = cmd.ExecuteScalar();
                    connection.Close();

                    if (result != null)
                    {
                        cancelDescription = result.ToString();
                    }
                }
            }

            return cancelDescription;
        }



        private void PopulateTextFieldsFromDatabase(string id, string pemohon)
        {
            // Implement code to retrieve data from the database using the provided id
            // and populate the text fields with the corresponding values

            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string selectQuery = "SELECT Id, Kategori, Nama_Item, Description, Quantity_Request, CreatedDate FROM Sou_UserRequest WHERE Id = @Id";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtId.Text = reader["Id"].ToString();
                            txtCategory.Text = reader["Kategori"].ToString();
                            txtItem.Text = reader["Nama_Item"].ToString();
                            txtDescription.Text = reader["Description"].ToString();
                            txtQuantity_Request.Text = reader["Quantity_Request"].ToString();
                            txtDate.Text = reader["CreatedDate"].ToString(); // Assign Created_Date to the txtDate TextBox


                            // Set the date value and format it
                            DateTime currentDate = DateTime.Now; // Replace this with the actual date value
                            txtDate.Text = currentDate.ToString("dd/MMM/yyyy");
                        }
                    }
                }
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Redirect to the "Kelulusan_Alat_Tulis.aspx" page
            Response.Redirect("Sou_Kelulusan_Alat_Tulis.aspx");
        }
    }
}
