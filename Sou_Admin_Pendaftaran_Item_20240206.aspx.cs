using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Admin_Pendaftaran_Item : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKategoriDropdown();
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    lblUsername.Text = Session["Username"].ToString();
                    string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                    // Update the welcome message with the value from the label lblUsername
                    welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                }
            }
        }
        private void BindKategoriDropdown()
        {
            // Retrieve the data from the database
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Kategori], [Nama_Kategori] FROM [Sou_Category]";

                // Append a default row representing "Click Here"
                string defaultText = "Click Here";
                string defaultValue = "-1"; // You can set any default value here
                string defaultRow = string.Format("<option value='{0}'>{1}</option>", defaultValue, defaultText);

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Bind the data to the DropDownList
                    ddlKategori.DataSource = reader;

                    // Modify DataTextField and DataValueField accordingly
                    ddlKategori.DataTextField = "Nama_Kategori";
                    ddlKategori.DataValueField = "Id_Kategori";

                    ddlKategori.DataBind();

                    reader.Close();

                    // Insert the default row at the beginning of the DropDownList
                    ddlKategori.Items.Insert(0, new ListItem(defaultText, defaultValue));
                }
            }
        }
        protected void ddlKategori_SelectedIndexChanged1(object sender, EventArgs e)
        {
            // Get the selected item value from the DropDownList
            string selectedItem = ddlKategori.SelectedValue;
            // Set the value of txtIdKategori to the selected item value
            txtIdKategori.Text = selectedItem;
        }
        protected void btnDaftarItem_Click(object sender, EventArgs e)
        {
            string createdBy = lblUsername.Text;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;

            // Get the values from the textboxes and dropdown list
            string tarikh = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string namaKategori = ddlKategori.SelectedItem.Text;
            int idKategori = int.Parse(txtIdKategori.Text);
            string namaItem = txtItemBaru.Text;
            string spesifikasi = txtSpesifikasi.Text;
            int jumlahStock = int.Parse(txtJumlahStock.Text);
            string unit = txtUnit.Text;
            int stokMinima = int.Parse(txtStokMinima.Text);
            string isyaratStok = (jumlahStock > stokMinima) ? "Stok Ok" : "Stok Perlu Ditambah";

            string insertQuery = "INSERT INTO [Sou_StockItem] " +
                "(CreatedDate, Kategori, Nama_Item, Spesifikasi, Jumlah_Stock, Unit, Stok_Minima, Isyarat_Stok, Id_Kategori, CreatedBy) " +
                "VALUES (@Tarikh, @Kategori, @NamaItem, @Spesifikasi, @JumlahStock, @Unit, @StokMinima, @IsyaratStok, @IdKategori, @CreatedBy)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@Tarikh", tarikh);
                    command.Parameters.AddWithValue("@Kategori", namaKategori);
                    command.Parameters.AddWithValue("@NamaItem", namaItem);
                    command.Parameters.AddWithValue("@Spesifikasi", spesifikasi);
                    command.Parameters.AddWithValue("@JumlahStock", jumlahStock);
                    command.Parameters.AddWithValue("@Unit", unit);
                    command.Parameters.AddWithValue("@StokMinima", stokMinima);
                    command.Parameters.AddWithValue("@IsyaratStok", isyaratStok);
                    command.Parameters.AddWithValue("@IdKategori", idKategori);
                    command.Parameters.AddWithValue("@CreatedBy", createdBy);

                    connection.Open();
                    command.ExecuteNonQuery();

                    // Get the generated Id_Item from the inserted item
                    int itemId = GetInsertedItemId();

                    // Insert photos into the Photo_Item table using the itemId
                    if (PhotoUpload1.HasFiles)
                    {
                        foreach (HttpPostedFile file in PhotoUpload1.PostedFiles)
                        {
                            // Check file size and type
                            if (file.ContentLength > 52428800) // 50MB (in bytes)
                            {
                                lblMessage.Text = "File size limit exceeded (50MB). Please select a smaller file.";
                                return;
                            }

                            // Process each uploaded file
                            string fileName = Path.GetFileName(file.FileName);
                            byte[] fileData = new byte[file.ContentLength];
                            file.InputStream.Read(fileData, 0, file.ContentLength);
                            int fileSize = fileData.Length;
                            string fileType = Path.GetExtension(file.FileName).Replace(".", "").ToUpper();

                            string constr = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                            using (SqlConnection conn = new SqlConnection(constr))
                            {
                                SqlCommand cmd = new SqlCommand("SP_Sou_InsertPhotoItem", conn)
                                {
                                    CommandType = CommandType.StoredProcedure
                                };
                                cmd.Parameters.AddWithValue("@Id_Item", itemId);
                                cmd.Parameters.AddWithValue("@FileName", fileName);
                                cmd.Parameters.AddWithValue("@ContentType", file.ContentType);
                                cmd.Parameters.AddWithValue("@FileData", fileData);
                                cmd.Parameters.AddWithValue("@FileSize", fileSize);
                                cmd.Parameters.AddWithValue("@FileType", fileType);
                                cmd.Parameters.AddWithValue("@UploadedBy", "Sistem");

                                try
                                {
                                    conn.Open();
                                    cmd.ExecuteNonQuery();
                                }
                                catch (SqlException ex)
                                {
                                    // handle the exception here
                                }
                                finally
                                {
                                    conn.Close();
                                }
                            }
                        }
                        lblMessage.Text = "Files uploaded successfully.";
                    }
                    else
                    {
                        lblMessage.Text = "Please select at least one file to upload.";
                    }

                    // Rebind the GridView1 to reflect the newly added item
                    GridView1.DataBind();

                    // Clear the input fields
                    txtTarikh.Text = string.Empty;
                    ddlKategori.SelectedIndex = 0;
                    txtIdKategori.Text = string.Empty;
                    txtItemBaru.Text = string.Empty;
                    txtSpesifikasi.Text = string.Empty;
                    txtJumlahStock.Text = string.Empty;
                    txtUnit.Text = string.Empty;
                    txtStokMinima.Text = string.Empty;

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }
        private int GetInsertedItemId()
        {
            int itemId = 0;

            string query = "SELECT IDENT_CURRENT('Sou_StockItem') AS LastInsertedId";
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        itemId = Convert.ToInt32(result);
                    }
                }
            }

            return itemId;
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblIsyaratStok = (Label)e.Row.FindControl("lblIsyaratStok");
                TextBox txtCreatedDateEdit = (TextBox)e.Row.FindControl("txtCreatedDateEdit");

                if (lblIsyaratStok != null)
                {
                    object jumlahStockObj = DataBinder.Eval(e.Row.DataItem, "Jumlah_Stock");
                    object stokMinimaObj = DataBinder.Eval(e.Row.DataItem, "Stok_Minima");

                    int Jumlah_Stock = jumlahStockObj != DBNull.Value ? Convert.ToInt32(jumlahStockObj) : 0;
                    int stokMinima = stokMinimaObj != DBNull.Value ? Convert.ToInt32(stokMinimaObj) : 0;

                    if (Jumlah_Stock >= stokMinima)
                    {
                        lblIsyaratStok.Text = "Stok Ok";
                    }
                    else
                    {
                        lblIsyaratStok.Text = "Stok Perlu Ditambah";

                        // Apply blue background color to the "Status" column cell
                        foreach (DataControlField column in GridView1.Columns)
                        {
                            if (column.HeaderText == "Status")
                            {
                                int columnIndex = GridView1.Columns.IndexOf(column);
                                e.Row.Cells[columnIndex].BackColor = System.Drawing.Color.HotPink; // Change to Hpt Pink 
                                break;
                            }
                        }
                    }

                    // Update the Isyarat_Stok value in the database
                    string itemId = GridView1.DataKeys[e.Row.RowIndex].Value.ToString();
                    string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE [Sou_StockItem] SET [Isyarat_Stok] = @IsyaratStok WHERE [Id_Item] = @IdItem";
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@IsyaratStok", lblIsyaratStok.Text);
                            command.Parameters.AddWithValue("@IdItem", itemId);
                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                    }
                }
                if (GridView1.EditIndex != -1 && GridView1.EditIndex == e.Row.RowIndex && txtCreatedDateEdit != null)
                {
                    txtCreatedDateEdit.Enabled = false;
                    txtCreatedDateEdit.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                }

                // Check if the row is in edit mode and set the background color accordingly
                if (GridView1.EditIndex == e.Row.RowIndex)
                {
                    e.Row.BackColor = System.Drawing.Color.Yellow; // Change the background color to yellow or any desired color
                }
            }
        }
        protected void txtTarikh_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtIdKategori_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtItemBaru_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtSpesifikasi_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtKuantiti_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtUnit_TextChanged(object sender, EventArgs e)
        {

        }
        protected void txtStokMinima_TextChanged(object sender, EventArgs e)
        {

        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            GridViewRow row = GridView1.Rows[e.RowIndex];
            string idItem = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Retrieve the updated values from the GridView controls
            string namaItem = (row.FindControl("txtNamaItemEdit") as TextBox).Text;
            string spesifikasi = (row.FindControl("txtSpesifikasiEdit") as TextBox).Text;
            string jumlahStok = (row.FindControl("txtJumlahStockEdit") as TextBox).Text;
            string unit = (row.FindControl("txtUnitEdit") as TextBox).Text;
            string stokMinima = (row.FindControl("txtStokMinimaEdit") as TextBox).Text;
            string isyaratStok = (row.FindControl("txtIsyaratStokEdit") as TextBox).Text;

            // Get the current date and time
            DateTime currentDate = DateTime.Now;

            // Get the username of the currently logged-in user
            string username = lblUsername.Text; // Assuming lblUsername is the ASP.NET Label control ID

            // Update the record in the database
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE [Sou_StockItem] SET [Nama_Item] = @NamaItem, [Spesifikasi] = @Spesifikasi, [Unit] = @Unit, [Jumlah_Stock] = @Jumlah_Stock, [Stok_Minima] = @StokMinima, [Isyarat_Stok] = @IsyaratStok, [ModifiedDate] = @ModifiedDate, [ModifiedBy] = @ModifiedBy WHERE [Id_Item] = @IdItem";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NamaItem", namaItem);
                    command.Parameters.AddWithValue("@Spesifikasi", spesifikasi);
                    command.Parameters.AddWithValue("@Unit", unit);
                    command.Parameters.AddWithValue("@Jumlah_Stock", jumlahStok); // The issue is here
                    command.Parameters.AddWithValue("@StokMinima", stokMinima);
                    command.Parameters.AddWithValue("@IsyaratStok", isyaratStok);
                    command.Parameters.AddWithValue("@ModifiedDate", currentDate);
                    command.Parameters.AddWithValue("@ModifiedBy", username);
                    command.Parameters.AddWithValue("@IdItem", idItem);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string itemId = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Delete the record from the database
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM [Sou_StockItem] WHERE [Id_Item] = @IdItem";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@IdItem", itemId);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;

        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void txtJumlahStock_TextChanged(object sender, EventArgs e)
        {

        }
        private void PopulateContactPhotos(int contactId)
        {
            List<PhotoInfo> photos = GetPhotosFromDatabase(contactId);
            if (photos.Count > 0)
            {
                // Display images and delete buttons
                foreach (PhotoInfo photo in photos)
                {
                    string imageFormat = GetImageFormat(photo.ContentType);
                    if (!string.IsNullOrEmpty(imageFormat))
                    {
                        // Convert the byte array into an image
                        System.Drawing.Image image = byteArrayToImage(photo.FileData);
                        // Create an image control
                        System.Web.UI.WebControls.Image imgControl = new System.Web.UI.WebControls.Image();
                        imgControl.ImageUrl = "data:image/" + imageFormat + ";base64," + Convert.ToBase64String(photo.FileData);
                        imgControl.AlternateText = "Image " + photo.Photo_Id;
                        // Create a delete button
                        Button deleteButton = new Button();
                        deleteButton.Text = "Delete";
                        deleteButton.PostBackUrl = "Sou_ConfirmDelete.aspx?Photo_Id=" + photo.Photo_Id;

                        Panel imagePanel = new Panel();
                        imagePanel.Controls.Add(imgControl);
                        imagePanel.Controls.Add(deleteButton);
                        imageContainer.Controls.Add(imagePanel);
                    }
                }
            }
        }
        private List<PhotoInfo> GetPhotosFromDatabase(int contactId)
        {
            List<PhotoInfo> photos = new List<PhotoInfo>();
            // Connect to the database and execute SQL query
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
        public class PhotoInfo
        {
            public int Photo_Id { get; set; }
            public byte[] FileData { get; set; }
            public string ContentType { get; set; }
        }
        private System.Drawing.Image byteArrayToImage(byte[] byteArray)
        {
            using (MemoryStream stream = new MemoryStream(byteArray))
            {
                return System.Drawing.Image.FromStream(stream);
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit2")
            {
                // Get the row index where the "Edit2" button was clicked
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                // You can now perform custom logic for the "Edit2" action
                // For example, you might want to redirect to a different page for editing.
                // Replace "YourEdit2Page.aspx" with the actual page URL.
                Response.Redirect("Admin_Pendaftaran_Item.aspx?id=" + GridView1.DataKeys[rowIndex]["Id_Item"]);
            }
        }
        protected void btnCustomize_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string[] args = btn.CommandArgument.ToString().Split(',');

            string redirectUrl = "Admin_Editing_All.aspx" +
                "?Id_Kategori=" + HttpUtility.UrlEncode(args[0]) +
                "&Kategori=" + HttpUtility.UrlEncode(args[1]) +
                "&Id_Item=" + HttpUtility.UrlEncode(args[2]) +
                "&Nama_Item=" + HttpUtility.UrlEncode(args[3]) +
                "&Spesifikasi=" + HttpUtility.UrlEncode(args[4]) +
                "&Unit=" + HttpUtility.UrlEncode(args[5]) +
                "&Jumlah_Stock=" + HttpUtility.UrlEncode(args[6]) +
                "&Stok_Minima=" + HttpUtility.UrlEncode(args[7]);
            Response.Redirect(redirectUrl);
        }
    }
}