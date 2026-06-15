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
            int OrderId = Convert.ToInt32(Request.QueryString["OrderId"]);
            txtidOrder.Text = OrderId.ToString();
            if (!IsPostBack)
            {
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    if (Request.QueryString["OrderId"] != null)
                    {
                        txtNamaPengguna.Text = Session["Username"].ToString();
                        lblUsername.Text = Session["Username"].ToString();
                        foreach (ListItem item in chkListOptions.Items)
                        {
                            item.Enabled = false;
                        }
                        // Retrieve the Unit value from the TextBox
                        string unitValue = txtUnit.Text;
                        ViewState["UnitValue"] = unitValue;
                        LoadData(OrderId);
                        PopulateContactPhotos(OrderId);
                        txtBilKuantitiYgDimahukan.Focus();
                    }
                }
                else
                {
                    Response.Redirect("~/Logout.aspx");
                }
            }
            else
            {
                // Restore the Unit value from ViewState during postbacks
                string unitValueFromViewState = ViewState["UnitValue"] as string;
                if (!string.IsNullOrEmpty(unitValueFromViewState))
                {
                    txtUnit.Text = unitValueFromViewState;
                }
            }
            welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
        }
        private string GetSpesifikasiFromDatabase(string itemId)
        {
            // Retrieve the Spesifikasi value from the database based on the itemId
            string spesifikasiValue = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Spesifikasi] FROM [Sou_StockItem] WHERE [Id_Item] = @ItemId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ItemId", itemId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        spesifikasiValue = result.ToString();
                    }
                }
            }
            return spesifikasiValue;
        }
        private string GetUnitFromDatabase(string itemId)
        {
            string unitValue = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Unit] FROM [Sou_StockItem] WHERE [Id_Item] = @ItemId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ItemId", itemId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        unitValue = result.ToString();
                    }
                }
            }
            return unitValue;
        }
        private string GetKuantitiFromDatabase(string itemId)
        {
            // Retrieve the Kuantiti value from the database based on the itemId
            string kuantitiValue = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Jumlah_Stock] FROM [Sou_StockItem] WHERE [Id_Item] = @ItemId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ItemId", itemId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        kuantitiValue = result.ToString();
                    }
                }
            }
            return kuantitiValue;
        }
        protected void BtnHantar_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null && string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                Response.Redirect("Logout.aspx");
            }
            string requestDate = txtTarikhPermohonan.Text;
            string pemohon = txtNamaPengguna.Text;
            string kategori = txtKategori.Text;
            string idKategori = txtIdKategori.Text;
            string namaItem = txtItem.Text;
            string idItem = txtIdItem.Text;
            string previousStock = txtKuantiti.Text;
            string bilanganUnitDimahukan = txtBilKuantitiYgDimahukan.Text;
            string description = txtDescription.Text;
            string unit = txtUnit.Text;

            int jumlahStock = int.Parse(previousStock);
            int jumlahKuantitiDimahukan = int.Parse(bilanganUnitDimahukan);
            int newjumlahStock = jumlahStock + (-jumlahKuantitiDimahukan);
            if (newjumlahStock < 0)
            {
                lblErrorMesage.Text = "Cannot request more than the available stock.";
                lblErrorMesage.Visible = true;
                return; // Exit the method if there's an error
            }
            if (jumlahKuantitiDimahukan > jumlahStock)
            {
                lblErrorMesage.Text = "Cannot request more than the available quantity.";
                lblErrorMesage.Visible = true;
                return;
            }
            // Set jumlahKuantitiDimahukan to its negative value
            jumlahKuantitiDimahukan = -jumlahKuantitiDimahukan;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            // Reduce the quantity in the StockItem table
            int quantityToReduce = jumlahKuantitiDimahukan; // Use the requested quantity
            int itemId = int.Parse(idItem);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string updateQuery = "UPDATE Sou_StockItem SET Jumlah_Stock = Jumlah_Stock + @QuantityToReduce WHERE Id_Item = @ItemId";
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@QuantityToReduce", quantityToReduce);
                    command.Parameters.AddWithValue("@ItemId", itemId);
                    command.ExecuteNonQuery();
                }
                // Retrieve the updated value of Jumlah_Stock and Stok_Minima from the Stok_Item2 table
                int updatedJumlahStock = 0;
                int stokMinima = 0;
                string selectQuery = "SELECT Jumlah_Stock, Stok_Minima FROM Sou_StockItem WHERE Id_Item = @ItemId";
                using (SqlCommand selectCommand = new SqlCommand(selectQuery, connection))
                {
                    selectCommand.Parameters.AddWithValue("@ItemId", itemId);
                    SqlDataReader reader = selectCommand.ExecuteReader();
                    if (reader.Read())
                    {
                        updatedJumlahStock = reader.GetInt32(0);
                        stokMinima = reader.GetInt32(1);
                    }
                    reader.Close();
                }
                // Update the value of Isyarat_Stok based on the updatedJumlahStock and stokMinima
                string isyaratStok = (updatedJumlahStock >= stokMinima) ? "Stok Ok" : "Stok Perlu Ditambah";
                string updateIsyaratStokQuery = "UPDATE Sou_StockItem SET Isyarat_Stok = @IsyaratStok WHERE Id_Item = @ItemId";
                using (SqlCommand updateIsyaratStokCommand = new SqlCommand(updateIsyaratStokQuery, connection))
                {
                    updateIsyaratStokCommand.Parameters.AddWithValue("@IsyaratStok", isyaratStok);
                    updateIsyaratStokCommand.Parameters.AddWithValue("@ItemId", itemId);
                    updateIsyaratStokCommand.ExecuteNonQuery();
                }
            }
            // Retrieve the ID_Pengguna from the [Daftar_Pengguna] table based on the pemohon
            //string idPengguna = GetIdPenggunaFromDatabase(pemohon);
            string idPengguna = Session["IdUser"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Sou_UserRequest (RequestDate, CreatedDate, Id_Pengguna, Pemohon, Kategori, Id_Kategori, " +
                               "Nama_Item, Id_item, Unit, Previous_Stock, Description, Status, CreatedBy, Quantity_Request, Jumlah_Stock) " +
                               "VALUES (@RequestDate, @CreatedDate, @IdPengguna, @Pemohon, @Kategori, @IdKategori, " +
                               "@NamaItem, @IdItem, @Unit, @PreviousStock, @Description, @Status, @CreatedBy, @QuantityRequest, @JumlahStock)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RequestDate", requestDate);
                    command.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                    command.Parameters.AddWithValue("@IdPengguna", idPengguna);
                    command.Parameters.AddWithValue("@Pemohon", pemohon);
                    command.Parameters.AddWithValue("@Kategori", kategori);
                    command.Parameters.AddWithValue("@IdKategori", idKategori);
                    command.Parameters.AddWithValue("@NamaItem", namaItem);
                    command.Parameters.AddWithValue("@IdItem", idItem);
                    command.Parameters.AddWithValue("@Unit", unit); // Insert the value of "unit" into the parameter
                    command.Parameters.AddWithValue("@PreviousStock", previousStock);
                    command.Parameters.AddWithValue("@Description", description);
                    command.Parameters.AddWithValue("@CreatedBy", pemohon);
                    command.Parameters.AddWithValue("@QuantityRequest", jumlahKuantitiDimahukan);
                    command.Parameters.AddWithValue("@JumlahStock", newjumlahStock); // Corrected variable name to newjumlahStock
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
            // EMAIL SECTION START ----------------------
            string str0 = "Salam, <br /><br />Berikut adalah maklumat tempahan Alat Tulis: <br /><br /> ";
            string str1 = "Tarikh Permohonan: " + requestDate + "<br />";
            string str2 = "Pemohon: " + pemohon + "<br />";
            string str3 = "Kategori: " + kategori + "<br />";
            string str4 = "Item: " + namaItem + "<br />";
            string str5 = "Stok Sebelum: " + previousStock + "<br />";
            string str6 = "Stok Selepas: " + newjumlahStock + "<br />";
            string str7 = "Kuantiti Mohon: " + bilanganUnitDimahukan + "<br />";
            string str8 = "Keterangan: " + description + "<br />";
            string str10 = "Terima Kasih. <br /><br /> Sistem eStationary Admin.";
            string badanEmail = str0 + str1 + str2 + str3 + str4 + str5 + str6 + str7 + str8 + str9 + str10;
            string emailSubjek = "Sistem eStationary, Permohonan Alat Tulis: " + pemohon + " " + requestDate;
            string emailGeng = Session["email"].ToString() + "; ibrahim@khtp.com.my;";
            try
            {
                MailMessage mail = new MailMessage
                {
                    From = new MailAddress("notification@khtp.com.my"),
                    Subject = emailSubjek,
                    IsBodyHtml = true,
                    Body = badanEmail
                };
                mail.To.Add(FormatMultipleEmailAddresses(emailGeng));
                // mail.CC.Add(new MailAddress("ibrahim@khtp.com.my"));
                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.office365.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential("notification@khtp.com.my", "n0+1fy@k+pc1")
                };
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            // EMAIL SECTION END ----------------------
            // Pass the value of txtNamaPengguna to Keputusan_Permohonan_User.aspx page
            Response.Redirect("Sou_Keputusan_Permohonan_User.aspx?namaPengguna=" + Server.UrlEncode(pemohon));
        }
        private string FormatMultipleEmailAddresses(string emailAddresses)
        { // 238
            var delimiters = new[] { ',', ';' };
            var addresses = emailAddresses.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);
            return string.Join(",", addresses);
        }
        private string GetIdPenggunaFromDatabase(string pemohon)
        {
            string idPengguna = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Pengguna] FROM [User] WHERE [Nama_Pengguna] = @Pemohon";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Pemohon", pemohon);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        idPengguna = result.ToString();
                    }
                }
            }
            return idPengguna;
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
        protected void HdnStatus_ValueChanged(object sender, EventArgs e)
        {
            hdnStatus.Value = "New";
        }
        private void LoadData(int OrderId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM Sou_UserRequest WHERE Id = @Id", connection);
                command.Parameters.AddWithValue("@Id", OrderId);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    //txtTarikhPermohonan.Text = reader["RequestDate"].ToString();
                    txtTarikhPermohonan.Text = ((DateTime)reader["RequestDate"]).ToString("yyyy-MM-dd");
                    txtNamaPengguna.Text = reader["Pemohon"].ToString();
                    txtItem.Text = reader["Nama_Item"].ToString();

                    txtId.Text = reader["Id_Item"].ToString();
                    txtIdKategori.Text = reader["Id_Kategori"].ToString();
                    txtKategori.Text = reader["Kategori"].ToString();
                    txtSpecification.Text = reader["Description"].ToString();
                    txtIdItem.Text = reader["Id_Item"].ToString();
                    txtUnit.Text = reader["Unit"].ToString();
                    txtKuantiti.Text = reader["Jumlah_Stock"].ToString();
                    
                    //chkListOptions.Items[0].Selected = Convert.ToBoolean(reader["IsInvestor"]);
                    //chkListOptions.Items[1].Selected = Convert.ToBoolean(reader["IsVisitor"]);
                    //chkListOptions.Items[2].Selected = Convert.ToBoolean(reader["IsStudent"]);
                    //chkListOptions.Items[3].Selected = Convert.ToBoolean(reader["IsStaffRetired"]);
                    //chkListOptions.Items[4].Selected = Convert.ToBoolean(reader["IsStaffNoticed"]);
                    //chkListOptions.Items[5].Selected = Convert.ToBoolean(reader["IsVIP"]);
                }
                reader.Close();
            }
            // Set only checkboxes with TRUE value appear.
            foreach (ListItem item in chkListOptions.Items)
            {
                if (!item.Selected)
                {
                    item.Attributes.Add("style", "display:none");
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