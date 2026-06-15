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
    public partial class Sou_Admin_Editing_All : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["Id_Item"]))
                {
                    int IdItem;

                    if (int.TryParse(Request.QueryString["Id_Item"], out IdItem))
                    {
                        BindPhotos(IdItem);
                        if (Request.QueryString["Id_Kategori"] != null)
                        {
                            txtIdKategori.Text = Request.QueryString["Id_Kategori"];
                            txtKategori.Text = Request.QueryString["Kategori"];
                            txtIdItem.Text = Request.QueryString["Id_Item"];
                            txtItemBaru.Text = Request.QueryString["Nama_Item"];
                            txtSpesifikasi.Text = Request.QueryString["Spesifikasi"];
                            txtUnit.Text = Request.QueryString["Unit"];
                            txtJumlahStock.Text = Request.QueryString["Jumlah_Stock"];
                            txtStokMinima.Text = Request.QueryString["Stok_Minima"];
                        }

                        if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                        {
                            lblUsername.Text = Session["Username"].ToString();
                            string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                            // Update the welcome message with the value from the label lblUsername
                            welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                        }
                    }
                    else
                    {
                        // "Id_Item" could not be parsed as an integer, handle this case
                        // For example, you can display an error message or redirect to an error page.
                    }
                }
                else
                {
                    // "Id_Item" query string parameter is not present, handle this case
                    // For example, you can display an error message or redirect to an error page.
                }
            }
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
        private System.Drawing.Image byteArrayToImage(byte[] byteArray)
        {
            using (MemoryStream stream = new MemoryStream(byteArray))
            {
                return System.Drawing.Image.FromStream(stream);
            }
        }
        protected void txtIdItem_TextChanged(object sender, EventArgs e)
        {
        }
        protected void btnUpdateIte_Click(object sender, EventArgs e)
        {
            // Get the values from the input fields
            string updatedNamaItem = txtItemBaru.Text;
            string updatedSpesifikasi = txtSpesifikasi.Text;
            int updatedJumlahStock;
            int updatedStokMinima;
            if (int.TryParse(txtJumlahStock.Text, out updatedJumlahStock) && int.TryParse(txtStokMinima.Text, out updatedStokMinima))
            {
                // Define your connection string
                string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                // Create a SQL connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Create a SQL command to update the database
                    string updateQuery = "UPDATE Sou_StockItem SET Nama_Item = @Nama_Item, Spesifikasi = @Spesifikasi, Jumlah_Stock = @Jumlah_Stock, Unit = @Unit, Stok_Minima = @Stok_Minima,  ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE() WHERE Id_Item = @Id_Item";
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        // Add parameters for the query
                        command.Parameters.AddWithValue("@Nama_Item", updatedNamaItem);
                        command.Parameters.AddWithValue("@Spesifikasi", updatedSpesifikasi);
                        command.Parameters.AddWithValue("@Jumlah_Stock", updatedJumlahStock);
                        command.Parameters.AddWithValue("@Unit", txtUnit.Text); // Assuming txtUnit doesn't change
                        command.Parameters.AddWithValue("@Stok_Minima", updatedStokMinima);
                        command.Parameters.AddWithValue("@Id_Item", int.Parse(Request.QueryString["Id_Item"])); // Assuming Id_Item is in the query string
                                                                                                                // Set the @Modified_By parameter to the value stored in Session["Username"]
                        command.Parameters.AddWithValue("@ModifiedBy", Session["Username"].ToString());
                        // Open the connection and execute the update query
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Update successful!";
                            // Add JavaScript to redirect to 'Admin_Pendaftaran_Item.aspx' after 2 seconds
                            string redirectScript = "<script type='text/javascript'>"
                                + "setTimeout(function () { window.location.href = 'Sou_Admin_Pendaftaran_Item.aspx'; }, 2000);"
                                + "</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "RedirectScript", redirectScript);
                        }
                        else
                        {
                            lblMessage.Text = "Update failed. Please check your input.";
                        }
                    }
                    // Check if there are uploaded images and insert them into the database
                    if (PhotoUpload1.HasFiles)
                    {
                        int itemId = int.Parse(Request.QueryString["Id_Item"]); // Get the item ID

                        foreach (HttpPostedFile uploadedFile in PhotoUpload1.PostedFiles)
                        {
                            // Get the file data, content type, file size, file type, and file name
                            byte[] fileData = new byte[uploadedFile.ContentLength];
                            uploadedFile.InputStream.Read(fileData, 0, uploadedFile.ContentLength);
                            string contentType = uploadedFile.ContentType;
                            int fileSize = uploadedFile.ContentLength;
                            string fileType = Path.GetExtension(uploadedFile.FileName);
                            string fileName = uploadedFile.FileName;

                            // Insert the image data into the database
                            InsertImageIntoDatabase(itemId, fileData, contentType, fileSize, fileType, fileName);
                        }
                        // Refresh the list of images after insertion
                        BindPhotos(itemId);
                    }
                }
            }
            else
            {
                lblMessage.Text = "Invalid input ";
            }
        }
        private void InsertImageIntoDatabase(int itemId, byte[] fileData, string contentType, int fileSize, string fileType, string fileName)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Define the SQL query to insert the image data
                    string insertQuery = "INSERT INTO Sou_Photo_Item (Id_Item, FileData, ContentType, FileSize, FileType, FileName,UploadedBy) VALUES (@Id_Item, @FileData, @ContentType, @FileSize, @FileType, @FileName,@UploadedBy)";
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Id_Item", itemId);
                        command.Parameters.AddWithValue("@FileData", fileData);
                        command.Parameters.AddWithValue("@ContentType", contentType);
                        command.Parameters.AddWithValue("@FileSize", fileSize);
                        command.Parameters.AddWithValue("@FileType", fileType);
                        command.Parameters.AddWithValue("@FileName", fileName);
                        command.Parameters.AddWithValue("@UploadedBy", "Sistem");
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "An error occurred while uploading images: " + ex.Message;
            }
        }
        private void BindPhotos(int Id)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT Photo_Id, FileName, ContentType, FileData FROM Sou_Photo_Item WHERE Id_Item =" + Id;
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable dtPhotos = new DataTable();
                            adapter.Fill(dtPhotos);
                            repeaterPhotos.DataSource = dtPhotos;
                            repeaterPhotos.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "An error occurred: " + ex.Message;
            }
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            // Attach the event handler for the delete buttons
            foreach (RepeaterItem item in repeaterPhotos.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    Button deleteButton = (Button)item.FindControl("deleteButton");
                    //deleteButton.Click += DeleteButton_Click;
                }
            }
        }
        protected void hapusButton_Click(object sender, EventArgs e)
        {
            // Get the Photo_Id from the CommandArgument of the button
            Button deleteButton = (Button)sender;
            int photoIdToDelete = Convert.ToInt32(deleteButton.CommandArgument);
            // Delete the image from the database and update the web page
            DeletePhotoFromDatabase(photoIdToDelete);
            // Refresh the list of images after deletion
            int itemId = int.Parse(Request.QueryString["Id_Item"]);
            BindPhotos(itemId);
            // Redirect back to the same page after deletion
            Response.Redirect(Request.RawUrl);
        }
        // Method to delete the photo from the database
        private void DeletePhotoFromDatabase(int photoId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // First, retrieve the filename and Id_Item associated with the photo
                    string selectQuery = "SELECT FileName, Id_Item FROM Sou_Photo_Item WHERE Photo_Id = @Photo_Id";
                    using (SqlCommand selectCommand = new SqlCommand(selectQuery, connection))
                    {
                        selectCommand.Parameters.AddWithValue("@Photo_Id", photoId);
                        using (SqlDataReader reader = selectCommand.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string fileName = reader["FileName"].ToString();
                                int itemId = Convert.ToInt32(reader["Id_Item"]);

                                // Delete the image from the database
                                string deleteQuery = "DELETE FROM Photo_Item WHERE Photo_Id = @Photo_Id";
                                using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
                                {
                                    deleteCommand.Parameters.AddWithValue("@Photo_Id", photoId);
                                    deleteCommand.ExecuteNonQuery();
                                }
                                // If you want to also delete the image file from the server's storage, you can do so here.
                                // For example, you can use System.IO.File.Delete to remove the file from the server.

                                // You might want to consider adding error handling for the file deletion process.

                                // Optionally, you can log this action or display a success message.
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "An error occurred while deleting the photo: " + ex.Message;
            }
        }
        public class PhotoInfo
        {
            public int Photo_Id { get; set; }
            public byte[] FileData { get; set; }
            public string ContentType { get; set; }
        }
    }
}