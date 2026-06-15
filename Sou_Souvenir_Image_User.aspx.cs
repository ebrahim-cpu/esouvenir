using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Souvenir_Image_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Id_Item"] != null)
                {
                    
                    int idItem = int.Parse(Request.QueryString["Id_Item"]);
                    // Call PopulateContactPhotos with the specified width and height
                    PopulateContactPhotos(idItem);
                }
                else
                {
                    // Handle the case when Id_Item is not provided.
                }
            }
        }
        // Implement this method to retrieve the image path from your database.
        private string GetImagePathFromDatabase(string idItem)
        {
            // Replace this with your actual logic to fetch the image path based on Id_Item.
            // You can query your database to retrieve the image path or content.
            // Return the path to the image file.
            // Example:
            // var imagePath = SomeDatabaseQuery(idItem);
            // return imagePath;
            // For now, we'll return a placeholder image path.
            return "Images/default-image.jpg";
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
                        System.Drawing.Image image = byteArrayToImage(photo.FileData);
                        // Create an image control
                        System.Web.UI.WebControls.Image imgControl = new System.Web.UI.WebControls.Image();
                        imgControl.ImageUrl = "data:image/" + imageFormat + ";base64," + Convert.ToBase64String(photo.FileData);
                        imgControl.AlternateText = "Image " + photo.Photo_Id;
                        // Set the width and height attributes
                        imgControl.Width = 400;
                        imgControl.Height = 500;
                        // Apply the centerImageClass to the image control
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
        private System.Drawing.Image byteArrayToImage(byte[] byteArray)
        {
            using (MemoryStream stream = new MemoryStream(byteArray))
            {
                return System.Drawing.Image.FromStream(stream);
            }
        }
    }
}