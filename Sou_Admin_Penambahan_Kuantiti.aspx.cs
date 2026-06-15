using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Admin_Penambahan_Kuantiti : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ID = Convert.ToInt32(Request.QueryString["Id_Item"]);
            if (!IsPostBack)
            {
                if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
                {
                    lblUsername.Text = Session["Username"].ToString();
                    welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
                    BindKategoriDropdown();
                    // Add a default item to the categories dropdown list
                    ddlKategori.Items.Insert(0, new ListItem("Click Here", ""));
                    if (!string.IsNullOrEmpty(txtIdKategori.Text))
                    {
                        BindItemDropdown(txtIdKategori.Text);
                        DropDownList2.Items.Insert(0, new ListItem("Click Here", ""));
                    }
                    string kuantitiValue = txtKuantiti.Text;
                    string unitValue = txtUnit.Text;
                    // Store the Kuantiti and Unit values in the ViewState
                    ViewState["KuantitiValue"] = kuantitiValue;
                    ViewState["UnitValue"] = unitValue;
                    LoadData(ID);   /*kna letak ni untk panggil data di coding load */
                    if (Request.QueryString["Id_Item"] != null)
                    {
                        // string idItem = Request.QueryString["Id_Item"];
                        // Check if the txtPerubahanKuantiti textbox is empty and show the modal
                        if (string.IsNullOrEmpty(txtPerubahanKuantiti.Text.Trim()))
                        {
                            txtPerubahanKuantiti.BackColor = System.Drawing.Color.Orange; // Change the background color
                            hdnShowModal.Value = "true"; // Set the value to show the modal
                        }
                        txtPerubahanKuantiti.BackColor = System.Drawing.Color.LightBlue;
                        txtdescription.BackColor = System.Drawing.Color.LightBlue;
                    }
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                }
               
            }
        }
        private void BindKategoriDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT [Id_Kategori], [Nama_Kategori] FROM [Sou_Category]";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Bind the data to the DropDownList
                    ddlKategori.DataSource = reader;
                    ddlKategori.DataTextField = "Nama_Kategori";
                    ddlKategori.DataValueField = "Id_Kategori";
                    ddlKategori.DataBind();
                    reader.Close();
                }
            }
        }
        protected void TxtTarikhTopup_TextChanged(object sender, EventArgs e)
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
                    command.Parameters.AddWithValue("@CategoryId", selectedCategoryId);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Create a list to store the items
                    List<ListItem> items = new List<ListItem>
                    {
                        // Add the default item to the DropDownList2
                        new ListItem("Click Here", "")
                    };
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
        protected void TxtIdKategori_TextChanged(object sender, EventArgs e)
        {
        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedItemId = DropDownList2.SelectedValue;
            txtIdItem.Text = selectedItemId;
            string kuantitiValue = GetKuantitiFromDatabase(selectedItemId);
            txtKuantiti.Text = kuantitiValue;
            string unitValue = GetUnitFromDatabase(selectedItemId);
            txtUnit.Text = unitValue;
            string spesifikasiValue = GetSpesifikasiFromDatabase(selectedItemId);
            txtSpesifikasi.Text = spesifikasiValue;
        }
        private string GetSpesifikasiFromDatabase(string itemId)
        {
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
        private string GetKuantitiFromDatabase(string itemId)
        {
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
                    if (result != null && result != DBNull.Value)
                    {
                        kuantitiValue = result.ToString();
                    }
                }
            }
            return kuantitiValue;
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
        protected void TxtIdItem_TextChanged(object sender, EventArgs e)
        {
        }
        protected void TxtKuantiti_TextChanged(object sender, EventArgs e)
        {
        }
        protected void TxtPerubahanKuantiti_TextChanged(object sender, EventArgs e)
        {
            // int quantity;
            if (int.TryParse(txtPerubahanKuantiti.Text, out _))
            {
                // Numeric input, set the value
                txtPerubahanKuantiti.BackColor = System.Drawing.Color.White; // Reset background color
            }
            else
            {
                // Non-numeric input, show error
                txtPerubahanKuantiti.BackColor = System.Drawing.Color.Red; // Change background color to indicate error
                txtPerubahanKuantiti.Text = "0"; // Reset to a default value
            }
        }
        protected void BtnTambah_Click(object sender, EventArgs e)
        {
            // int quantity = 0;
            int.TryParse(txtPerubahanKuantiti.Text, out int quantity);
            
            int.TryParse(txtKuantiti.Text, out int value1);
            int result = value1 + quantity;
            txtJumlahStock.Text = result.ToString();
            // Show the descriptionContainer
            descriptionContainer.Style["display"] = "block";
            // Show the txtdescription textbox
            txtdescription.Visible = true;
        }
        protected void BtnTolak_Click(object sender, EventArgs e)
        {
            int.TryParse(txtPerubahanKuantiti.Text, out int quantity);

            int.TryParse(txtKuantiti.Text, out int value1);
            int result = value1 - quantity;
            txtJumlahStock.Text = result.ToString();
            // Automatically add the negative symbol to the txtPerubahanKuantiti TextBox value
            txtPerubahanKuantiti.Text = "-" + txtPerubahanKuantiti.Text;
            // Show the descriptionContainer
            descriptionContainer.Style["display"] = "block";
            // Show the txtdescription textbox
            txtdescription.Visible = true;
        }
        protected void TxtJumlahStock_TextChanged(object sender, EventArgs e)
        {
        }
        protected void BtnSimpan_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString;
            // string modifiedBy = lblUsername.Text;
            int.TryParse(txtIdItem.Text, out int idItem);
            int.TryParse(txtPerubahanKuantiti.Text, out int kuantitiTambahan);
            // Corrected variable name to jumlahStock
            int.TryParse(txtJumlahStock.Text, out int jumlahStock);
            if (jumlahStock < 0)
            {
                // The value is negative, disable the button and show a message
                btnSimpan.Enabled = false;
                lblErrorMessage.Text = "New Quantity cannot be <span style='background-color: yellow;'>negative</span>. Please adjust the QUANTITY (STOCK IN/OUT) value by ";
                lblErrorMessage.Visible = true; // Ensure the visibility is set to true
                imgClickHere.Visible = true; // Show the imgClickHere image
                return;
            }
            // Retrieve the Stok_Minima value for the specific item from the database
            int stokMinima = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT Stok_Minima FROM Sou_StockItem WHERE Id_Item = @Id_Item", connection))
                {
                    cmd.Parameters.AddWithValue("@Id_Item", idItem);
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        stokMinima = Convert.ToInt32(result);
                    }
                }
            }
            // Determine the value for Isyarat_Stok based on Jumlah_Stock and Stok_Minima
            string isyaratStok;
            if (jumlahStock >= stokMinima) // Corrected variable name to jumlahStock
            {
                isyaratStok = "Stok Ok";
            }
            else
            {
                isyaratStok = "Stok Perlu Ditambah";
            }
            // DateTime currentDate = DateTime.Now;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand updateCmd = new SqlCommand("UPDATE Sou_StockItem SET KuantitiTambahan = @KuantitiTambahan, Jumlah_Stock = @Jumlah_Stock, Isyarat_Stok = @Isyarat_Stok WHERE Id_Item = @Id_Item", connection))
                {
                    updateCmd.Parameters.AddWithValue("@KuantitiTambahan", kuantitiTambahan);
                    updateCmd.Parameters.AddWithValue("@Jumlah_Stock", jumlahStock);
                    updateCmd.Parameters.AddWithValue("@Isyarat_Stok", isyaratStok);
                    updateCmd.Parameters.AddWithValue("@Id_Item", idItem);
                    updateCmd.ExecuteNonQuery();
                }
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Sou_StockInOut (Id_Kategori, Nama_Kategori, Id_Item, Nama_Item, KuantitiTambahan, ModifiedDate, Jumlah_Stock, Description, Previous_Stock, Unit, CreatedBy, ModifiedBy) VALUES (@Id_Kategori, @Nama_Kategori, @Id_Item, @Nama_Item, @KuantitiTambahan, @ModifiedDate, @Jumlah_Stock, @Description, @Previous_Stock, @Unit,@CreatedBy, @ModifiedBy)", connection))
                {
                    cmd.Parameters.AddWithValue("@Id_Kategori", txtIdKategori.Text);
                    cmd.Parameters.AddWithValue("@Nama_Kategori", ddlKategori.SelectedItem.Text); // Use the selected text from ddlKategori
                    cmd.Parameters.AddWithValue("@Id_Item", int.Parse(txtIdItem.Text)); // Parse the value as an integer
                    cmd.Parameters.AddWithValue("@Nama_Item", DropDownList2.SelectedItem.Text); // Use the selected text from DropDownList2
                    cmd.Parameters.AddWithValue("@KuantitiTambahan", int.Parse(txtPerubahanKuantiti.Text)); // Parse the value as an integer
                    cmd.Parameters.AddWithValue("@ModifiedDate", DateTime.Now); // Insert the current date and time
                    cmd.Parameters.AddWithValue("@Jumlah_Stock", int.Parse(txtJumlahStock.Text)); // Parse the value as an integer
                    cmd.Parameters.AddWithValue("@Description", txtdescription.Text);
                    cmd.Parameters.AddWithValue("@Previous_Stock", int.Parse(txtKuantiti.Text)); // Parse the value as an integer
                    cmd.Parameters.AddWithValue("@Unit", txtUnit.Text);
                    cmd.Parameters.AddWithValue("@CreatedBy", Session["Username"].ToString()); // Use the value from lblUsername
                    cmd.Parameters.AddWithValue("@ModifiedBy", Session["Username"].ToString()); // Use the value from lblUsername

                    cmd.ExecuteNonQuery();
                }
            }
            imgClickHere.Visible = false; // Hide the imgClickHere image
            // Redirect the user back to the same page (refresh the page)
            Response.Redirect(Request.Url.AbsoluteUri);
            GridView1.DataBind();
            // Clear the form fields if needed
            ClearFormFields();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        // Utility function to clear the form fields
        private void ClearFormFields()
        {
            txtIdKategori.Text = "";
            ddlKategori.SelectedIndex = 0; // Reset the selected index of ddlKategori to the default item
            txtIdItem.Text = "";
            DropDownList2.SelectedIndex = 0; // Reset the selected index of DropDownList2 to the default item
            txtPerubahanKuantiti.Text = "";
            txtTarikhTopup.Text = DateTime.Now.ToString("yyyy-MM-dd"); // Set the date to today
            txtJumlahStock.Text = "";
            txtdescription.Text = "";
            txtKuantiti.Text = "";
            txtUnit.Text = "";
        }
        protected void TxtUnit_TextChanged(object sender, EventArgs e)
        {
        }
        protected void TxtSpesifikasi_TextChanged(object sender, EventArgs e)
        {
        }
        protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // You can customize the appearance or behavior of individual rows here if needed
                // For example, change cell colors, add tooltips, etc.
            }
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
        protected void BtnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // Get the values from the GridView row
            string idItem = GridView2.DataKeys[row.RowIndex]["Id_Item"].ToString();
            // string namaItem = row.Cells[3].Text; // Assuming Nama_Item is in the third column
            // string idKategori = GridView2.DataKeys[row.RowIndex]["Id_Kategori"].ToString();
            // string kategori = row.Cells[0].Text; // Assuming Kategori is in the first column
            // string unit = row.Cells[5].Text; // Assuming Unit is in the fifth column
            // string jumlahStock = row.Cells[8].Text; // Assuming Jumlah_Stock is in the eighth column
            // string spesifikasi = row.Cells[4].Text; // Assuming Spesifikasi is in the fourth column
            //string redirectUrl = "Sou_Admin_Penambahan_Kuantiti.aspx?Id_Item=" + Server.UrlEncode(idItem);
            string redirectUrl = "Sou_Admin_Penambahan_Kuantiti.aspx?Id_Item=" + HttpUtility.UrlEncode(idItem);
            Response.Redirect(redirectUrl);
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the index of the column containing the Isyarat_Stok value
                int isyaratStokColumnIndex = GetColumnIndexByName(GridView2, "Isyarat_Stok");
                if (isyaratStokColumnIndex >= 0)
                {
                    string isyaratStokValue = e.Row.Cells[isyaratStokColumnIndex].Text;
                    // Check if the Isyarat_Stok value is "Stok Perlu Ditambah"
                    if (isyaratStokValue == "Stok Perlu Ditambah")
                    {
                        // Set the background color to pink
                        e.Row.Cells[isyaratStokColumnIndex].BackColor = System.Drawing.Color.HotPink;
                        // Set the text color to black
                        e.Row.Cells[isyaratStokColumnIndex].ForeColor = System.Drawing.Color.Black;
                    }
                }
            }
        }
        // Helper method to get the column index by header text
        private int GetColumnIndexByName(GridView gridView, string columnName)
        {
            for (int i = 0; i < gridView.Columns.Count; i++)
            {
                if (gridView.Columns[i] is BoundField && ((BoundField)gridView.Columns[i]).DataField.Equals(columnName))
                {
                    return i;
                }
            }
            return -1;
        }
        private void LoadData(int id)    /*untk panggil data dri gridview2 ke textbox*/
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["eSouvenirConnectionString"].ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM Sou_StockItem WHERE Id_Item = @Id", connection);
                command.Parameters.AddWithValue("@Id", id);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    txtTarikhTopup.Text = reader["CreatedDate"].ToString();
                    txtIdItem.Text = reader["Id_Item"].ToString();
                    ddlKategori.Items.Add(reader["Kategori"].ToString());
                    ddlKategori.SelectedValue = reader["Kategori"].ToString();
                    DropDownList2.Items.Add(new ListItem(reader["Nama_Item"].ToString()));
                    txtIdKategori.Text = reader["Id_Kategori"].ToString();
                    txtSpesifikasi.Text = reader["Spesifikasi"].ToString();
                    txtIdItem.Text = reader["Id_Item"].ToString();
                    txtUnit.Text = reader["Unit"].ToString();
                    txtKuantiti.Text = reader["Jumlah_Stock"].ToString();
                }
                reader.Close();
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
        }
        protected void BtnExcel2_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewData.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";
            // Create a StringBuilder to hold the CSV content
            StringBuilder sb = new StringBuilder();
            // Append header row
            for (int i = 0; i < GridView2.Columns.Count; i++)
            {
                sb.Append(GridView2.Columns[i].HeaderText);
                if (i < GridView2.Columns.Count - 1)
                {
                    sb.Append(",");
                }
            }
            sb.AppendLine();
            // Append data rows
            foreach (GridViewRow row in GridView2.Rows)
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
    }
}