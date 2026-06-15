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
    public partial class Sou_Keputusan_Permohonan_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    lblUsername.Text = Session["Username"].ToString();
                    string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                    SqlDataSource2.SelectParameters["PemohonName"].DefaultValue = pemohonName;
                    welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                    // Attach the RowDataBound event handler for GridView2
                    GridView2.RowDataBound += GridView2_RowDataBound;
                    if (Request.QueryString["id"] != null)
                    {
                        string requestId = Request.QueryString["id"];
                    }
                }
                else
                {
                    Response.Redirect("~/Logout.aspx");
                }
            }
            // Check if the page is loading for the first time (not postback)
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowConfirmation")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmCancelScript", "ShowConfirmationDialog(" + rowIndex + ");", true);
            }
            else if (e.CommandName == "CancelRequest")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                Label statusLabel = GridView2.Rows[rowIndex].FindControl("StatusLabel") as Label;
                statusLabel.Text = "Cancel";
                // The confirmation dialog will be shown on the client side using OnClientClick
                Button cancelButton = GridView2.Rows[rowIndex].FindControl("CancelButton") as Button;
                cancelButton.OnClientClick = "return showConfirmationDialog();"; // This line sets the client-side confirmation dialog
                string id = GridView2.DataKeys[rowIndex].Value.ToString();
                Label quantityLabel = GridView2.Rows[rowIndex].FindControl("Quantity_Request") as Label;
                int quantityRequest = quantityLabel != null ? Convert.ToInt32(quantityLabel.Text) : 0;

                // Perform addition operation and update Jumlah_Stock in the database
                UpdateStockQuantity(id, quantityRequest);
                // Update status in the UserRequest table
                UpdateStatusInDatabase(id, "Cancel");
                GridView2.DataBind(); // Rebind the GridView to reflect the updated status

                // Hide the CancelButton
                cancelButton.Visible = false; // This hides the button after clicking

                Label pemohonLabel = GridView2.Rows[rowIndex].FindControl("PemohonLabel") as Label;
                // string pemohon = pemohonLabel != null ? pemohonLabel.Text : string.Empty;

                // Redirect to the CancelDescription.aspx page with query string parameters
                Response.Redirect(Request.RawUrl);
            }
        }
        private void UpdateStockQuantity(string id, int quantityRequest)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string selectStockQuery = "SELECT Jumlah_Stock FROM Sou_StockItem WHERE Id_Item IN (SELECT Id_Item FROM Sou_UserRequest WHERE Id = @Id)";
                using (SqlCommand selectStockCommand = new SqlCommand(selectStockQuery, connection))
                {
                    selectStockCommand.Parameters.AddWithValue("@Id", id);
                    int currentStock = Convert.ToInt32(selectStockCommand.ExecuteScalar());
                    // Calculate the new Jumlah_Stock value after addition
                    int newStock = currentStock + quantityRequest;
                    // Update the Jumlah_Stock column in StockItem table
                    string updateStockQuery = "UPDATE Sou_StockItem SET Jumlah_Stock = @NewStock WHERE Id_Item IN (SELECT Id_Item FROM Sou_UserRequest WHERE Id = @Id)";
                    using (SqlCommand updateStockCommand = new SqlCommand(updateStockQuery, connection))
                    {
                        updateStockCommand.Parameters.AddWithValue("@NewStock", newStock);
                        updateStockCommand.Parameters.AddWithValue("@Id", id);
                        updateStockCommand.ExecuteNonQuery();
                    }
                    // Update the Isyarat_Stok column based on Jumlah_Stock and Stok_Minima values
                    string updateIsyaratStokQuery = "UPDATE Sou_StockItem SET Isyarat_Stok = CASE " +
                        "WHEN Jumlah_Stock >= Stok_Minima THEN 'Stok Ok' " +
                        "ELSE 'Stok Perlu Diperbaharui' " +
                        "END " +
                        "WHERE Id_Item IN (SELECT Id_Item FROM Sou_UserRequest WHERE Id = @Id)";
                    using (SqlCommand updateIsyaratStokCommand = new SqlCommand(updateIsyaratStokQuery, connection))
                    {
                        updateIsyaratStokCommand.Parameters.AddWithValue("@Id", id);
                        updateIsyaratStokCommand.ExecuteNonQuery();
                    }
                }
            }
        }
        private void UpdateStatusInDatabase(string id, string newStatus)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "UPDATE Sou_UserRequest SET Status = @NewStatus WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NewStatus", newStatus);
                    command.Parameters.AddWithValue("@Id", id);
                    command.ExecuteNonQuery();
                }
                // Additional code for updating Isyarat_Stok if newStatus is "Cancel"
                if (newStatus == "Cancel")
                {
                    // Retrieve the value from Previous_Stock column in UserRequest
                    query = "SELECT Previous_Stock, Quantity_Request FROM Sou_UserRequest WHERE Id = @Id";
                    using (SqlCommand selectCommand = new SqlCommand(query, connection))
                    {
                        selectCommand.Parameters.AddWithValue("@Id", id);
                        SqlDataReader reader = selectCommand.ExecuteReader();
                        if (reader.Read())
                        {
                            int previousStock = Convert.ToInt32(reader["Previous_Stock"]);
                            int quantityRequest = Convert.ToInt32(reader["Quantity_Request"]);
                            reader.Close(); // Close the DataReader before executing the next query

                            // Update the Jumlah_Stock column in StockItem by adding the Quantity_Request value
                            query = "UPDATE Sou_StockItem SET Jumlah_Stock = Jumlah_Stock - @QuantityRequest WHERE Id_Item IN (SELECT Id_Item FROM Sou_UserRequest WHERE Id = @Id)";
                            using (SqlCommand updateCommand = new SqlCommand(query, connection))
                            {
                                updateCommand.Parameters.AddWithValue("@QuantityRequest", quantityRequest);
                                updateCommand.Parameters.AddWithValue("@Id", id);
                                updateCommand.ExecuteNonQuery();
                            }
                            // Update the Isyarat_Stok column based on Jumlah_Stock and Stok_Minima values
                            query = "UPDATE Sou_StockItem SET Isyarat_Stok = CASE " +
                                        "WHEN Jumlah_Stock >= Stok_Minima THEN 'Stok Ok' " +
                                        "ELSE 'Stok Perlu Diperbaharui' " +
                                        "END " +
                                        "WHERE Id_Item IN (SELECT Id_Item FROM Sou_UserRequest WHERE Id = @Id)";
                            using (SqlCommand updateIsyaratStokCommand = new SqlCommand(query, connection))
                            {
                                updateIsyaratStokCommand.Parameters.AddWithValue("@Id", id);
                                updateIsyaratStokCommand.ExecuteNonQuery();
                            }
                            // Update the Cancel_Description column with the current time formatted as "dd/MMM/yyyy"
                            query = "UPDATE Sou_UserRequest SET Cancel_Description = @CancelDescription WHERE Id = @Id";
                            using (SqlCommand updateCancelDescriptionCommand = new SqlCommand(query, connection))
                            {
                                updateCancelDescriptionCommand.Parameters.AddWithValue("@CancelDescription", DateTime.Now.ToString("dd/MMM/yyyy"));
                                updateCancelDescriptionCommand.Parameters.AddWithValue("@Id", id);
                                updateCancelDescriptionCommand.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
        }
        private int GetPreviousStockFromDatabase(string id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[":eSouvenirConnectionString"].ConnectionString;
            string query = "SELECT  Previous_Stock FROM UserRequest WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    connection.Open();
                    return Convert.ToInt32(command.ExecuteScalar());
                }
            }
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label statusLabel = (Label)e.Row.FindControl("StatusLabel");
                Label modifiedDateLabel = (Label)e.Row.FindControl("Modified_DateLabel");
                Button cancelButton = (Button)e.Row.FindControl("CancelButton");

                if (statusLabel != null && modifiedDateLabel != null && cancelButton != null)
                {
                    string status = statusLabel.Text;
                    // Show the Modified_DateLabel only when the status is "Accept"
                    modifiedDateLabel.Visible = (status == "Accept");
                    // Hide the "Cancel Request" button if the status is "Reject", "Accept", or "Cancel"
                    cancelButton.Visible = (status != "Reject" && status != "Accept" && status != "Cancel");
                }
            }
        }
        protected bool ShowAcceptDate(object status)
        {
            if (status != null)
            {
                string statusValue = status.ToString();
                return statusValue == "Accept"; // Show the date only when the status is "Accept"
            }

            return false; // Hide the date by default if status is null or not "Accept"
        }
        protected void BtnConfirmCancel_Click(object sender, EventArgs e)
        {
            GridView2.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cancelModalHideScript", "$('#cancelModal').modal('hide');", true);
        }
    }
}