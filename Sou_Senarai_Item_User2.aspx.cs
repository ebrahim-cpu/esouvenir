using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Senarai_Item_User2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                lblUsername.Text = Session["Username"].ToString();
                string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
            }
            else
            {
                Response.Redirect("~/SessionTimeOut.aspx");
            }
        }
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string idItem = GridView2.DataKeys[row.RowIndex]["Id_Item"].ToString();
            string namaItem = row.Cells[1].Text; // Assuming Nama_Item is in the 
            string idKategori = GridView2.DataKeys[row.RowIndex]["Id_Kategori"].ToString();
            string kategori = row.Cells[3].Text; // Assuming Kategori is in the third column
            string unit = row.Cells[5].Text; // Assuming Unit is in the sixth column
            string jumlahStock = row.Cells[7].Text; // Assuming Jumlah_Stock is in the eighth column
            string spesifikasi = row.Cells[4].Text; // Assuming Spesifikasi is in the fifth column
            string redirectUrl = "Sou_Permohonan_Item_User.aspx?Id_Item=" + Server.UrlEncode(idItem);
            Response.Redirect(redirectUrl);
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
    }
}