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
    public partial class Sou_Admin_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    int ID = Convert.ToInt32(Request.QueryString["Id_Item"]);
                    lblUsername.Text = Session["Username"].ToString();
                    string pemohonName = Session["Username"].ToString();
                    SqlDataSource2.SelectParameters["PemohonName"].DefaultValue = pemohonName;
                    welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                    // Attach the RowDataBound event hndler for GridView2
                    GridView2.RowDataBound += GridView2_RowDataBound;
                    BindKategoriDropdown();
                    ddlKategori.Items.Insert(0, new ListItem("Click Here", ""));
                    if (!string.IsNullOrEmpty(txtIdKategori.Text))
                    {
                        BindItemDropdown(txtIdKategori.Text);
                        DropDownList2.Items.Insert(0, new ListItem("Click Here", ""));
                    }
                    txtNamaPengguna.Text = Session["Username"].ToString();
                    lblUsername.Text = Session["Username"].ToString();
                    // Retrieve the Unit value from the TextBox
                    string unitValue = txtUnit.Text;
                    ViewState["UnitValue"] = unitValue;
                    LoadData(ID);
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
            }
            // Check if the page is loading for the first time (not postback)
            if (!IsPostBack)
            {
                // Check if a query string parameter "id" is present in the URL
                if (Request.QueryString["id"] != null)
                {
                    string requestId = Request.QueryString["id"];
                }
            }
        }
        //Mula part textbox
        private void BindKategoriDropdown()
        {
            // Retrieve the data from the database
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Kategori], [Nama_Kategori] FROM [Sou_Category]";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    ddlKategori.DataSource = reader;
                    ddlKategori.DataTextField = "Nama_Kategori";
                    ddlKategori.DataValueField = "Id_Kategori";
                    //ddlKategori.DataValueField = "Nama_Kategori";
                    ddlKategori.DataBind();
                    reader.Close();
                }
            }
        }
        protected void txtNamaPengguna_TextChanged(object sender, EventArgs e)
        {
        }
        protected void txtTarikhTopup_TextChanged(object sender, EventArgs e)
        {
        }
        protected void btnSimpan_Click(object sender, EventArgs e)
        {
        }
        protected void DdlKategori_SelectedIndexChanged1(object sender, EventArgs e)
        {
            {
                string selectedItem = ddlKategori.SelectedValue;
                txtIdKategori.Text = selectedItem;
                // Populate the DropDownList2 based on the selected item
                BindItemDropdown(selectedItem);
            }
        }
        private void BindItemDropdown(string selectedCategoryId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Item], [Nama_Item] FROM [Sou_StockItem] WHERE [Id_Kategori] = @CategoryId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Set the parameter value
                    command.Parameters.AddWithValue("@CategoryId", selectedCategoryId);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Create a list to store the items
                    List<ListItem> items = new List<ListItem>();
                    // Add the default item to the DropDownList2
                    items.Add(new ListItem("Click Here", ""));
                    // Iterate through the data reader and add items to the list
                    while (reader.Read())
                    {
                        string itemId = reader["Id_Item"].ToString();
                        string itemName = reader["Nama_Item"].ToString();
                        items.Add(new ListItem(itemName, itemId));
                    }
                    reader.Close();
                    // Bind the items to the DropDownList2
                    DropDownList2.DataSource = items;
                    DropDownList2.DataTextField = "Text";
                    DropDownList2.DataValueField = "Value";
                    DropDownList2.DataBind();
                }
            }
        }
        protected void DropDownList2_SelectedIndexChanged1(object sender, EventArgs e)
        {
            string selectedItemId = DropDownList2.SelectedValue;
            // Set the value of txtIdItem to the selected item value
            txtIdItem.Text = selectedItemId;
            // Retrieve the Kuantiti value from the database based on the selected item
            string kuantitiValue = GetKuantitiFromDatabase(selectedItemId);
            // Set the value of txtKuantiti to the retrieved Kuantiti value
            txtKuantiti.Text = kuantitiValue;
            // Retrieve the Unit value from the database based on the selected item
            string unitValue = GetUnitFromDatabase(selectedItemId);
            // Set the value of txtUnit to the retrieved Unit value
            txtUnit.Text = unitValue;
            // Retrieve the Spesifikasi value from the database based on the selected item
            string spesifikasiValue = GetSpesifikasiFromDatabase(selectedItemId);
            // Set the value of txtSpecification to the retrieved Spesifikasi value
            txtSpecification.Text = spesifikasiValue;
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
            // Retrieve the Unit value from the database based on the itemId
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
        protected void txtIdKategori_TextChanged(object sender, EventArgs e)
        {
        }
        protected void txtIdItem_TextChanged(object sender, EventArgs e)
        {
        }
        protected void txtKuantiti_TextChanged(object sender, EventArgs e)
        {
        }
        protected void BtnHantar_Click(object sender, EventArgs e)
        {
            // Get the values from the textboxes and dropdown lists
            string requestDate = txtTarikhPermohonan.Text;
            string pemohon = txtNamaPengguna.Text;
            string kategori = ddlKategori.SelectedItem.Text;
            string idKategori = txtIdKategori.Text;
            string namaItem = DropDownList2.SelectedItem.Text;
            string idItem = txtIdItem.Text;
            string previousStock = txtKuantiti.Text;
            string bilanganUnitDimahukan = txtBilKuantitiYgDimahukan.Text;
            string description = txtDescription.Text;
            string status = "New"; // Set the value of status directly
            string unit = txtUnit.Text;
            // Convert the quantity values to integers
            int jumlahStock = int.Parse(previousStock);
            int jumlahKuantitiDimahukan = int.Parse(bilanganUnitDimahukan);
            // Calculate the new Jumlah_Stock value (txtKuantiti.Text +(- txtBilKuantitiYgDimahukan.Text))
            //pengiraan untuk simpan dlm stok asal tpi ni part yg belum tekan cancel. 
            int newjumlahStock = jumlahStock + (-jumlahKuantitiDimahukan);
            // Check if the requested quantity is greater than the available quantity
            if (newjumlahStock < 0)
            {
                lblErrorMesage.Text = "Cannot request more than the available stock.";
                lblErrorMesage.Visible = true;
                return; // Exit the method if there's an error
            }
            // Check if the requested quantity is greater than the available quantity
            if (jumlahKuantitiDimahukan > jumlahStock)
            {
                lblErrorMesage.Text = "Cannot request more than the available quantity.";
                lblErrorMesage.Visible = true;
                return; // Exit the method if there's an error
            }
            // Set jumlahKuantitiDimahukan to its negative value
            jumlahKuantitiDimahukan = -jumlahKuantitiDimahukan;
            // Insert the values into the database table using an SQL INSERT statement
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;

            // Reduce the quantity in the StockItem table
            int quantityToReduce = jumlahKuantitiDimahukan; // Use the requested quantity
            int itemId = int.Parse(idItem);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Update the Jumlah_Stock column in the Stok_Item table
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
                using (SqlCommand Comm1 = new SqlCommand(updateIsyaratStokQuery, connection))
                {
                    Comm1.Parameters.AddWithValue("@IsyaratStok", isyaratStok);
                    Comm1.Parameters.AddWithValue("@ItemId", itemId);
                    Comm1.ExecuteNonQuery();
                }
            }
            // Retrieve the ID_Pengguna from the [Daftar_Pengguna] table based on the pemohon
            // string idPengguna = GetIdPenggunaFromDatabase(pemohon);
            string idPengguna = Session["IdUser"].ToString();
            // Insert the values into the Permohonan_Pengguna2 table
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Sou_UserRequest (RequestDate, CreatedDate, Id_Pengguna, Pemohon, Kategori, Id_Kategori, " +
                               "Nama_Item, Id_item, Unit, Previous_Stock, Description, Status, CreatedBy, ModifiedBy, Quantity_Request, Jumlah_Stock) " +
                               "VALUES (@RequestDate, @CreatedDate, @IdPengguna, @Pemohon, @Kategori, @IdKategori, " +
                               "@NamaItem, @IdItem, @Unit, @PreviousStock, @Description, @Status, @CreatedBy, @ModifiedBy, @QuantityRequest, @JumlahStock)";

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
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@CreatedBy", pemohon);
                    command.Parameters.AddWithValue("@ModifiedBy", pemohon);
                    command.Parameters.AddWithValue("@QuantityRequest", jumlahKuantitiDimahukan);
                    command.Parameters.AddWithValue("@JumlahStock", newjumlahStock); // Corrected variable name to newjumlahStock
                    connection.Open();
                    command.ExecuteNonQuery();
                    // Pass the value of txtNamaPengguna to Keputusan_Permohonan_User.aspx page
                    // Response.Redirect("Sou_Admin_Request.aspx?namaPengguna=" + Server.UrlEncode(pemohon));
                    Response.Redirect("Sou_Kelulusan_Souvenir.aspx");
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblIsyaratStok = (Label)e.Row.FindControl("lblIsyaratStok");
                TextBox txtTarikhPendaftaranItemEdit = (TextBox)e.Row.FindControl("txtTarikhPendaftaranItemEdit");

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
        protected void hdnStatus_ValueChanged(object sender, EventArgs e)
        {
            hdnStatus.Value = "New";
        }
        private void LoadData(int id)
        {
            // Open a connection to the database.
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
            {
                connection.Open();
                // Load the data from the database.
                SqlCommand command = new SqlCommand("SELECT * FROM Sou_StockItem WHERE Id_Item = @Id", connection);
                command.Parameters.AddWithValue("@Id", id);
                SqlDataReader reader = command.ExecuteReader();
                // Fill the form with the data.
                if (reader.Read())
                {
                    txtTarikhPermohonan.Text = reader["CreatedDate"].ToString();
                    txtId.Text = reader["Id_Item"].ToString();
                    txtNamaPengguna.Text = Session["Username"].ToString();

                    ddlKategori.Items.Add(reader["Kategori"].ToString());
                    ddlKategori.SelectedValue = reader["Kategori"].ToString();
                    DropDownList2.Items.Add(new ListItem(reader["Nama_Item"].ToString()));

                    txtIdKategori.Text = reader["Id_Kategori"].ToString();
                    txtSpecification.Text = reader["Spesifikasi"].ToString();
                    txtIdItem.Text = reader["Id_Item"].ToString();
                    txtUnit.Text = reader["Unit"].ToString();
                    txtKuantiti.Text = reader["Jumlah_Stock"].ToString();
                }
                reader.Close();
            }
        }
        /*akhir part textbox*/

        //mula part gridview
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
                string pemohon = pemohonLabel != null ? pemohonLabel.Text : string.Empty;

                // Call the PopulateTextFieldsFromDatabase method
                PopulateTextFieldsFromDatabase(id, pemohon);

                // Redirect to the CancelDescription.aspx page with query string parameters
                Response.Redirect(Request.RawUrl);
            }
        }
        private void PopulateTextFieldsFromDatabase(string id, string pemohon)
        {
            // ... (your implementation here)
        }
        private void UpdateStockQuantity(string id, int quantityRequest)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Get the current Jumlah_Stock value from StockItem table
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

                            // Update the Jumlah_Stock column in StockItem by adding the Quantity_Request value (quantity request sebenarnya ada negatif kt depan)
                            query = "UPDATE Sou_StockItem SET Jumlah_Stock = Jumlah_Stock - @QuantityRequest WHERE Id_Item IN (SELECT Id_Item FROM UserRequest WHERE Id = @Id)";
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
            string query = "SELECT  Previous_Stock FROM Sou_UserRequest WHERE Id = @Id";
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
        protected void btnConfirmCancel_Click(object sender, EventArgs e)
        {
            GridView2.DataBind();
            // Hide the modal after successful cancellation.
            ScriptManager.RegisterStartupScript(this, this.GetType(), "cancelModalHideScript", "$('#cancelModal').modal('hide');", true);
        }
    }
}