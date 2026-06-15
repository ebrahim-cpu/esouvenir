using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Kelulusan_Souvenir : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                lblUsername.Text = Session["Username"].ToString();
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
            }
            // Initialize the ViewState variable StockUpdated if it's a new page load
            if (!IsPostBack)
            {
                ViewState["StockUpdated"] = false;
                GridView1.PageSize = 50;
            }
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                Response.Redirect(string.Format("Sou_Check_Cancel_Description.aspx?id={0}", id));
            }
        }
        private string GetCancelDescriptionFromDatabase(string id)
        {
            string cancelDescription = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string selectQuery = "SELECT Cancel_Description FROM Sou_UserRequest WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    // ExecuteScalar returns the single value (Cancel_Description) from the query
                    var result = command.ExecuteScalar();
                    if (result != null)
                    {
                        cancelDescription = result.ToString();
                    }

                }
            }
            return cancelDescription;
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void AcceptButton_Click(object sender, EventArgs e)
        {
            Button acceptButton = (Button)sender;
            GridViewRow row = (GridViewRow)acceptButton.NamingContainer;
            string id = GridView1.DataKeys[row.RowIndex].Value.ToString(); // Use "Value" instead of "Values"
            // Your code to update the database
            UpdateStatusAndModifiedDateInDatabase(id, "Accept", DateTime.Now, lblUsername.Text);
            // Find the Modified_DateLabel inside the GridView row
            Label modifiedDateLabel = (Label)row.FindControl("Modified_DateLabel");
            // Update the "Modified_Date" column value to the current date and time
            if (modifiedDateLabel != null)
            {
                modifiedDateLabel.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            }
            // Update the "Modified_By" column value to the current username
            Label modifiedByLabel = (Label)row.FindControl("Modified_ByLabel");
            if (modifiedByLabel != null)
            {
                modifiedByLabel.Text = lblUsername.Text;
            }
            // Update the "Status", "Modified_Date", and "Modified_By" columns values in the database
            UpdateStatusAndModifiedDateInDatabase(id, "Accept", DateTime.Now, lblUsername.Text);
            acceptButton.Visible = false;
            // Refresh the page
            Response.Redirect(Request.Url.ToString());
        }
        private void UpdateStatusAndModifiedDateInDatabase(string id, string status, DateTime modifiedDate, string modifiedBy)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string updateQuery = "UPDATE Sou_UserRequest SET Status = @Status, ModifiedDate = @ModifiedDate, ModifiedBy = @ModifiedBy WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@ModifiedDate", modifiedDate);
                    command.Parameters.AddWithValue("@ModifiedBy", modifiedBy);
                    command.Parameters.AddWithValue("@Id", id);
                    command.ExecuteNonQuery();
                }
            }
        }
        private void UpdateStatusInDatabase(string id, string status)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string updateQuery = "UPDATE Sou_UserRequest SET Status = @Status WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@Id", id);
                    command.ExecuteNonQuery();
                }
            }
        }
        protected bool ShowAcceptButton(object status)
        {
            if (status != null)
            {
                string statusValue = status.ToString();
                return !(statusValue == "Accept" || statusValue == "Cancel" || statusValue == "Reject");  /*NK BGI BILA TKN BUTTON, IA AKAN HILANG*/
            }
            return true; // Show the button by default if status is null
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
        protected void RejectButton_Click(object sender, EventArgs e)
        {
            Button rejectButton = (Button)sender;
            GridViewRow row = (GridViewRow)rejectButton.NamingContainer;
            string id = GridView1.DataKeys[row.RowIndex].Value.ToString();
            UpdateStatusAndModifiedDateInDatabase(id, "Reject", DateTime.Now, lblUsername.Text);
            UpdateStockItemQuantity(id);
            // Find the AcceptButton inside the GridView row and hide it
            Button acceptButton = (Button)row.FindControl("AcceptButton");
            if (acceptButton != null)
            {
                acceptButton.Visible = false;
            }
            // Find the Modified_DateLabel inside the GridView row and update its value
            Label modifiedDateLabel = (Label)row.FindControl("Modified_DateLabel");
            if (modifiedDateLabel != null)
            {
                modifiedDateLabel.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            }
            // Update the "Modified_By" column value to the current username
            Label modifiedByLabel = (Label)row.FindControl("Modified_ByLabel");
            if (modifiedByLabel != null)
            {
                modifiedByLabel.Text = lblUsername.Text;
            }
            // Perform addition operation and update Jumlah_Stock in StockItem table
            rejectButton.Visible = false;
            // Refresh the page
            Response.Redirect(Request.Url.ToString());
        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Button updateButton = (Button)sender;
            GridViewRow row = (GridViewRow)updateButton.NamingContainer;
            string id = GridView1.DataKeys[row.RowIndex].Value.ToString();
            Response.Redirect("Sou_Admin_UpdateOrder?OrderId=" + id);
        }
        private void UpdateStockItemQuantity(string id)
        {
            int quantityRequest;
            int idItem;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
            {
                connection.Open();
                // Fetch Quantity_Request and Id_Item from UserRequest table
                string selectUserRequestQuery = "SELECT Quantity_Request, Id_Item FROM Sou_UserRequest WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(selectUserRequestQuery, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            quantityRequest = Convert.ToInt32(reader["Quantity_Request"]);
                            idItem = Convert.ToInt32(reader["Id_Item"]);
                        }
                        else
                        {
                            return;
                        }
                    }
                }
                // Fetch Jumlah_Stock from StockItem table using Id_Item
                string selectStockItemQuery = "SELECT Jumlah_Stock FROM Sou_StockItem WHERE Id_Item = @Id_Item";
                int jumlahStock;
                using (SqlCommand command = new SqlCommand(selectStockItemQuery, connection))
                {
                    command.Parameters.AddWithValue("@Id_Item", idItem);
                    jumlahStock = Convert.ToInt32(command.ExecuteScalar());
                }
                // Update the Jumlah_Stock in StockItem table by subtracting Quantity_Request
                string updateQuery = "UPDATE Sou_StockItem SET Jumlah_Stock = @JumlahStock WHERE Id_Item = @Id_Item";
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@JumlahStock", jumlahStock - quantityRequest); // Subtract Quantity_Request
                    command.Parameters.AddWithValue("@Id_Item", idItem);
                    command.ExecuteNonQuery();
                }
            }
        }
        protected bool ShowRejectButton(object status)
        {
            if (status != null)
            {
                string statusValue = status.ToString();
                return (statusValue != "Accept" && statusValue != "Cancel" && statusValue != "Reject");
            }
            return true; // Show the button by default if status is null
        }
        protected bool ShowUpdateButton(object status)
        {
            if (status != null)
            {
                string statusValue = status.ToString();
                return (statusValue != "Accept" && statusValue != "Cancel" && statusValue != "Reject");
            }
            return true; // Show the button by default if status is null
        }
        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {
        }
        protected string GetCancelDescriptionLink(object status, object id, object pemohon)
        {
            if (status != null && status.ToString() == "Cancel")
            {
                return string.Format("Check_Cancel_Description.aspx?id={0}&pemohon={1}", id, HttpUtility.UrlEncode(pemohon.ToString()));
            }
            return "#"; // Return a non-clickable link for other statuses

        }
        protected bool ShowHyperlink(object status)
        {
            if (status != null && status.ToString() == "Cancel")
            {
                return true; // Show the hyperlink for "Cancel" status
            }
            return false; // Hide the hyperlink for other statuses
        }
        protected void BtnExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewData.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";
            // Create a StringBuilder to hold the CSV content
            StringBuilder sb = new StringBuilder();
            // Append header row
            for (int i = 0; i < GridView1.Columns.Count; i++)
            {
                sb.Append(GridView1.Columns[i].HeaderText);
                if (i < GridView1.Columns.Count - 1)
                {
                    sb.Append(",");
                }
            }
            sb.AppendLine();
            // Append data rows
            foreach (GridViewRow row in GridView1.Rows)
            {
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    sb.Append(row.Cells[i].Text.Replace(",", ""));
                    if (i < row.Cells.Count - 1)
                    {
                        sb.Append(",");
                    }
                }
                sb.AppendLine();
            }
            // Write the CSV content to the response stream
            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                string[] args = e.CommandArgument.ToString().Split(',');
                string id = args[0];
                // Redirect to Check_Cancel_Description.aspx and pass the Id parameter
                Response.Redirect(string.Format("Check_Cancel_Description.aspx?id={0}", id));
            }
        }
        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            GridView1.PageIndex = 0;
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
        }
    }
}