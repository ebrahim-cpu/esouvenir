using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Admin_UpdateOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int OrderId = Convert.ToInt32(Request.QueryString["OrderId"]);
                txtOrderId.Text = OrderId.ToString();
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    if (Request.QueryString["OrderId"] != null)
                    {
                        LoadData(OrderId);
                        if (!string.IsNullOrEmpty(txtItemId.Text))
                        {
                            int ItemId = Convert.ToInt32(txtItemId.Text);
                            PopulateContactPhotos(ItemId);
                        }
                        txtBilKuantitiYgDimahukan.Focus();
                    }
                }
                else
                {
                    Response.Redirect("~/Logout.aspx");
                }
            }
        }
        private void LoadData(int OrderId)
        {
            if (!IsPostBack)
            {
                lblUsername.Text = txtNamaPengguna.Text = Session["Username"].ToString();
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                if (Session[name: "Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand("SELECT * FROM Sou_UserRequest WHERE Id = @Id", connection);
                        command.Parameters.AddWithValue("@Id", OrderId);
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            txtTarikhPermohonan.Text = ((DateTime)reader["RequestDate"]).ToString("yyyy-MM-dd");
                            txtNamaPengguna.Text = reader["Pemohon"].ToString();
                            txtKategori.Text = reader["Kategori"].ToString();
                            txtNamaItem.Text = reader["Nama_Item"].ToString();
                            txtKuantiti.Text = reader["Jumlah_Stock"].ToString();
                            txtBilKuantitiYgDimahukan.Text = reader["Quantity_Request"].ToString();
                            txtDescription.Text = reader["Description"].ToString();
                            txtItemId.Text = reader["Id_Item"].ToString(); // Grab Item Id
                            txtPreviousOrderQuantity.Text = reader["Quantity_Request"].ToString(); ; // Grab Original Quantity Request
                            string quantityRequestString = reader["Quantity_Request"].ToString();
                            // Parse the string representation of the quantity request as a number
                            if (int.TryParse(quantityRequestString, out int quantityRequestInt))
                            {
                                int positiveQuantityRequestInt = Math.Abs(quantityRequestInt); // -neg or +pos, it will always +ve. ****
                                txtBilKuantitiYgDimahukan.Text = positiveQuantityRequestInt.ToString();
                            }
                            else
                            {
                            }
                            // Fetch latest Stock Quantity.
                            if (int.TryParse(reader["Id_Item"].ToString(), out int IdItem))
                            {
                                using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
                                {
                                    connection2.Open();
                                    SqlCommand command2 = new SqlCommand("SELECT * FROM Sou_StockItem WHERE Id_Item = @Id", connection2);
                                    command2.Parameters.AddWithValue("@Id", IdItem);
                                    SqlDataReader reader2 = command2.ExecuteReader();
                                    if (reader2.Read())
                                    {
                                        txtKuantiti.Text = reader2["Jumlah_Stock"].ToString();
                                    }
                                    reader2.Close();
                                }
                            }
                            else
                            {
                            }
                        }
                        reader.Close();
                        // int previousOrderQuantity;
                        if (int.TryParse(txtKuantiti.Text.ToString(), out int jumlahStock) && int.TryParse(txtPreviousOrderQuantity.Text.ToString(), out int previousOrderQuantity))
                        {
                            int totalQuantity = jumlahStock + Math.Abs(previousOrderQuantity);
                            txtKuantiti.Text = totalQuantity.ToString();
                        }
                        else
                        {
                            // Handle parsing errors if necessary
                            txtKuantiti.Text = "Error";
                        }
                    }
                }
                else
                {
                    Response.Redirect(url: "LogOut.aspx");
                }
            }

        }
        protected void AdjustButton_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null && string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                Response.Redirect("Logout.aspx");
            }
            string OrderId = Request.QueryString["OrderId"];
            string ItemId = txtItemId.Text;
            string previousStock = txtKuantiti.Text; // From latest Stock Quantity. This is not from current record.
            string Description = txtDescription.Text;
            string bilanganUnitDimahukan = txtBilKuantitiYgDimahukan.Text; //

            int jumlahStock = int.Parse(previousStock);
            int jumlahKuantitiDimahukan = int.Parse(bilanganUnitDimahukan);
            int newjumlahStock = jumlahStock + (-jumlahKuantitiDimahukan); // 
            int bakiStock = jumlahStock - jumlahKuantitiDimahukan; //
            if (newjumlahStock < 0)
            {
                lblErrorMessage.Text = "Cannot request more than the available stock.";
                lblErrorMessage.Visible = true;
                return; // Exit the method if request is -neg
            }
            if (jumlahKuantitiDimahukan > jumlahStock)
            {
                lblErrorMessage.Text = "Cannot request more than the available quantity.";
                lblErrorMessage.Visible = true;
                return; // Exit the method if request is more than latest stock
            }
            if (int.TryParse(bilanganUnitDimahukan, out int quantityRequestInt))
            {
                int negativeQuantityRequestInt = quantityRequestInt * -1; // Convert positive to negative
                txtBilKuantitiYgDimahukan.Text = negativeQuantityRequestInt.ToString();
            }
            else
            {
            }
            // Update new request quantity
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string updateQuery = @"UPDATE Sou_UserRequest 
                       SET Quantity_Request = @QuantityRequest, 
                           Description = @Description, 
                           Previous_Stock = @PreviousStock, Jumlah_Stock = @JumlahStock,
                           ModifiedBy = @ModifiedBy, 
                           ModifiedDate = @ModifiedDate 
                       WHERE Id = @OrderId";

                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@QuantityRequest", txtBilKuantitiYgDimahukan.Text);
                    command.Parameters.AddWithValue("@Description", Description);
                    command.Parameters.AddWithValue("@OrderId", OrderId);
                    command.Parameters.AddWithValue("@JumlahStock", bakiStock); // After Minus Stock Qty

                    command.Parameters.AddWithValue("@ModifiedBy", Session["Username"].ToString());
                    command.Parameters.AddWithValue("@ModifiedDate", DateTime.Now);
                    // int previousStockVar;
                    if (int.TryParse(txtKuantiti.Text, out int previousStockVar))
                    {
                        command.Parameters.AddWithValue("@PreviousStock", previousStockVar); // Before Minus
                    }
                    else
                    {
                    }
                    command.ExecuteNonQuery();
                }
            }
            // Update new Qty Stock to main StockItem
            string connectionString2 = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection2 = new SqlConnection(connectionString2))
            {
                connection2.Open();
                string updateQuery2 = "UPDATE Sou_StockItem SET Jumlah_Stock = @JumlahStock WHERE Id_Item = @IdItem";
                using (SqlCommand command2 = new SqlCommand(updateQuery2, connection2))
                {
                    command2.Parameters.AddWithValue("@JumlahStock", newjumlahStock);
                    command2.Parameters.AddWithValue("@IdItem", ItemId);
                    command2.ExecuteNonQuery();
                }
            }

            Response.Redirect("Sou_Kelulusan_Souvenir.aspx");
        }
        protected void AcceptButton_Click(object sender, EventArgs e)
        {
            int OrderId = Convert.ToInt32(Request.QueryString["OrderId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string updateQuery = "UPDATE Sou_UserRequest SET Status = @Status, ModifiedDate = @ModifiedDate, Tarikh_Pemberian = @TarikhPemberian, ModifiedBy = @ModifiedBy, Description = @Description WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@Status", "Accept");
                    command.Parameters.AddWithValue("@ModifiedDate", System.DateTime.Now);
                    command.Parameters.AddWithValue("@TarikhPemberian", System.DateTime.Now);
                    command.Parameters.AddWithValue("@ModifiedBy", Session["Username"]);
                    command.Parameters.AddWithValue("@Description", txtDescription.Text);
                    command.Parameters.AddWithValue("@Id", OrderId);
                    command.ExecuteNonQuery();
                }
            }
            Response.Redirect("Sou_Kelulusan_Souvenir.aspx");
        }
        protected void RejectButton_Click(object sender, EventArgs e)
        {
            String id = Request.QueryString["OrderId"];
            UpdateSetatus(id, "Reject", DateTime.Now, Session["Username"].ToString());
            UpdateStockItemQuantity(id);
            Response.Redirect("Sou_Kelulusan_Souvenir.aspx");
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

        private void UpdateSetatus(string id, string status, DateTime modifiedDate, string modifiedBy)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            string updateQuery = "UPDATE Sou_UserRequest SET Status = @Status, ModifiedDate = @ModifiedDate, ModifiedBy = @ModifiedBy, Description = @Description WHERE Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@ModifiedDate", modifiedDate);
                    command.Parameters.AddWithValue("@ModifiedBy", modifiedBy);
                    command.Parameters.AddWithValue("@Description", txtDescription.Text);
                    command.Parameters.AddWithValue("@Id", id);
                    command.ExecuteNonQuery();
                }
            }
        }

        private string FormatMultipleEmailAddresses(string emailAddresses)
        { // 238
            var delimiters = new[] { ',', ';' };
            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);
            return string.Join(",", addresses);
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblIsyaratStok = (Label)e.Row.FindControl("lblIsyaratStok");
                //TextBox txtTarikhPendaftaranItemEdit = (TextBox)e.Row.FindControl("txtTarikhPendaftaranItemEdit");
                if (lblIsyaratStok != null)
                {
                    object jumlahStockObj = DataBinder.Eval(e.Row.DataItem, "Jumlah_Stock");
                    object stokMinimaObj = DataBinder.Eval(e.Row.DataItem, "Stok_Minima");
                    int jumlahStock = jumlahStockObj != DBNull.Value ? Convert.ToInt32(jumlahStockObj) : 0;
                    int stokMinima = stokMinimaObj != DBNull.Value ? Convert.ToInt32(stokMinimaObj) : 0;
                    if (jumlahStock > stokMinima)
                    {
                        lblIsyaratStok.Text = "Stok Ok";
                    }
                    else
                    {
                        lblIsyaratStok.Text = "Stok Perlu Ditambah";
                    }
                }
            }
        }
        private void PopulateContactPhotos(int contactId)
        {
            List<PhotoInfo> photos = GetPhotosFromDatabase(contactId);
            if (photos.Count > 0)
            {
                // Create a CSS class for centering images
                string centerImageClass = "center-image";

                // Display images and delete buttons
                foreach (PhotoInfo photo in photos)
                {
                    string imageFormat = GetImageFormat(photo.ContentType);
                    if (!string.IsNullOrEmpty(imageFormat))
                    {
                        // Convert the byte array into an image
                        System.Drawing.Image image = ByteArrayToImage(photo.FileData);
                        // Create an image control
                        System.Web.UI.WebControls.Image imgControl = new System.Web.UI.WebControls.Image();
                        imgControl.ImageUrl = "data:image/" + imageFormat + ";base64," + Convert.ToBase64String(photo.FileData);
                        imgControl.AlternateText = "Image " + photo.Photo_Id;
                        imgControl.Width = 400;
                        imgControl.Height = 500;
                        imgControl.CssClass = centerImageClass;
                        // Create a delete button
                        // Button deleteButton = new Button();
                        // deleteButton.Text = "Delete";
                        // deleteButton.PostBackUrl = "ConfirmDelete.aspx?Photo_Id=" + photo.Photo_Id;
                        Panel imagePanel = new Panel();
                        imagePanel.Controls.Add(imgControl);
                        // imagePanel.Controls.Add(deleteButton);
                        imageContainer.Controls.Add(imagePanel);
                    }
                }
            }
        }
        private List<PhotoInfo> GetPhotosFromDatabase(int contactId)
        {
            List<PhotoInfo> photos = new List<PhotoInfo>();
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT Photo_Id, FileData, ContentType FROM Sou_Photo_Item WHERE Id_Item = @Id_Item", connection))
                {
                    command.Parameters.AddWithValue("@Id_Item", contactId);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            PhotoInfo photo = new PhotoInfo
                            {
                                Photo_Id = (int)reader["Photo_Id"],
                                FileData = (byte[])reader["FileData"],
                                ContentType = reader["ContentType"].ToString()
                            };
                            photos.Add(photo);
                        }
                    }
                }
            }
            return photos;
        }
        public class PhotoInfo
        {
            public int Photo_Id { get; set; }
            public byte[] FileData { get; set; }
            public string ContentType { get; set; }
        }
        private string GetImageFormat(string contentType)
        {
            switch (contentType.ToLower())
            {
                case "image/jpeg":
                case "image/jpg":
                    return "jpeg";
                case "image/gif":
                    return "gif";
                case "image/png":
                    return "png";
                default:
                    return string.Empty;
            }
        }
        private System.Drawing.Image ByteArrayToImage(byte[] byteArray)
        {
            using (MemoryStream stream = new MemoryStream(byteArray))
            {
                return System.Drawing.Image.FromStream(stream);
            }
        }
    }
}