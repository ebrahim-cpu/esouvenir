using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Senarai_Item_User4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind the GridView on the initial page load
                BindGridView();
            }
        }
        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Re-bind the GridView when the DropDownList selection changes
            BindGridView();
        }
        private void BindGridView()
        {
            // Get the selected filter value from the DropDownList
            string selectedFilter = ddlFilter.SelectedValue;

            // Construct the SQL query based on the selected filter
            string selectCommand = "SELECT * FROM [Sou_StockItem]";
            if (!string.IsNullOrEmpty(selectedFilter))
            {
                selectCommand += " WHERE [" + selectedFilter + "] = 1";
            }

            // Set the SelectCommand of the SqlDataSource to the constructed query
            SqlDataSource1.SelectCommand = selectCommand;

            // Re-bind the GridView
            GridView1.DataBind();
        }
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string idItem = GridView1.DataKeys[row.RowIndex]["Id_Item"].ToString();
            string namaItem = row.Cells[1].Text; // Assuming Nama_Item is in the 
            string idKategori = GridView1.DataKeys[row.RowIndex]["Id_Kategori"].ToString();
            string kategori = row.Cells[3].Text; // Assuming Kategori is in the third column
            string unit = row.Cells[5].Text; // Assuming Unit is in the sixth column
            string jumlahStock = row.Cells[7].Text; // Assuming Jumlah_Stock is in the eighth column
            string spesifikasi = row.Cells[4].Text; // Assuming Spesifikasi is in the fifth column
            string redirectUrl = "Sou_Permohonan_Item_User.aspx?Id_Item=" + Server.UrlEncode(idItem);
            Response.Redirect(redirectUrl);
        }
    }
}