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
    public partial class Sou_Admin_Daftar_Kategori : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    lblUsername.Text = Session["Username"].ToString();
                    //string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                    // Update the welcome message with the value from the label lblUsername
                    welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                }
                BindGridView();
            }
        }
        protected void BindGridView()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Kategori], [Guid], [Nama_Kategori], [tarikh_daftar] FROM [Sou_Category]";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    GridView1.DataBind();
                }
            }
        }
        protected void BtnDaftar_Kategori_Click(object sender, EventArgs e)
        {
            string tarikhDaftar = txtTarikh.Text;
            string namaKategori = txtNama_Kategori.Text;
            string createdBy = lblUsername.Text;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO [Sou_Category] ([tarikh_daftar], [Nama_Kategori], [CreatedBy], [CreatedDate]) " +
                               "VALUES (@tarikhDaftar, @namaKategori, @createdBy, @createdDate)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@tarikhDaftar", tarikhDaftar);
                    command.Parameters.AddWithValue("@namaKategori", namaKategori);
                    command.Parameters.AddWithValue("@createdBy", createdBy);
                    // Add the current date and time as the value for Created_Date column
                    command.Parameters.AddWithValue("@createdDate", DateTime.Now);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            txtTarikh.Text = string.Empty;
            txtNama_Kategori.Text = string.Empty;
            forbtnDaftar_Kategori.Text = "Berjaya Mendaftar";
            // Refresh the GridView to show the newly added category
            BindGridView();
            // Redirect to the same page to avoid resubmission on page refresh
            Response.Redirect("Sou_Admin_Daftar_Kategori.aspx");
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            string idKategori = GridView1.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtNamaKategori = row.FindControl("txtNamaKategoriEdit") as TextBox;
            string namaKategori = txtNamaKategori.Text;
            // Get the username from the label
            string modifiedBy = lblUsername.Text;
            // Update the database with the new value, the current date and time, and the modified by username
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE [Sou_Category] SET [Nama_Kategori] = @namaKategori, [ModifiedDate] = @modifiedDate, [ModifiedBy] = @modifiedBy WHERE [Id_Kategori] = @idKategori";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@namaKategori", namaKategori);
                    command.Parameters.AddWithValue("@idKategori", idKategori);
                    // Add the current date and time as the value for the Modified_Date column
                    command.Parameters.AddWithValue("@modifiedDate", DateTime.Now);
                    // Add the modified by username
                    command.Parameters.AddWithValue("@modifiedBy", modifiedBy);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            GridView1.EditIndex = -1;
            BindGridView(); // Refresh the GridView
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string idKategori = GridView1.DataKeys[e.RowIndex].Value.ToString();
            // Perform the deletion operation based on the provided ID_Kategori
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Sou_Category WHERE Id_Kategori = @idKategori";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@idKategori", idKategori);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            GridView1.DataBind();
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                // Make sure the appropriate control is in edit mode when editing a row, Use Pattern Matching
                if (e.Row.FindControl("txtNamaKategori") is TextBox txtNamaKategori)
                {
                    txtNamaKategori.Focus();
                }
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1.DataBind();
        }
        protected void TxtNama_Kategori_TextChanged(object sender, EventArgs e)
        { }
    }
}