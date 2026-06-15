using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Senarai_Item_Admin_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the session variable exists and has a value
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                // Set the value of the label to the session variable value
                lblUsername.Text = Session["Username"].ToString();
                string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                // Update the welcome message with the value from the label lblUsername
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
            }
            else
            {
                Response.Redirect("~/Sou_SessionTimeOut.aspx");
            }
        }
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Get the values from the GridView row
            string idItem = GridView1.DataKeys[row.RowIndex]["Id_Item"].ToString();
            string namaItem = row.Cells[3].Text; // Assuming Nama_Item is in the third column
            string idKategori = GridView1.DataKeys[row.RowIndex]["Id_Kategori"].ToString();
            string kategori = row.Cells[0].Text; // Assuming Kategori is in the first column
            string unit = row.Cells[5].Text; // Assuming Unit is in the fifth column
            string jumlahStock = row.Cells[8].Text; // Assuming Jumlah_Stock is in the eighth column
            string spesifikasi = row.Cells[4].Text; // Assuming Spesifikasi is in the fourth column

            // Set the query string parameters and redirect to the Admin_Penambahan_Kuantiti.aspx page
            string redirectUrl = "Sou_Admin_Penambahan_Kuantiti.aspx?Id_Item=" + Server.UrlEncode(idItem) +
                                 "&Nama_Item=" + Server.UrlEncode(namaItem) +
                                 "&Id_Kategori=" + Server.UrlEncode(idKategori) +
                                 "&Kategori=" + Server.UrlEncode(kategori) +
                                 "&Unit=" + Server.UrlEncode(unit) +
                                 "&Jumlah_Stock=" + Server.UrlEncode(jumlahStock) +
                                 "&SpesifikasiValue=" + Server.UrlEncode(spesifikasi);

            Response.Redirect(redirectUrl);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string isyaratStokValue = DataBinder.Eval(e.Row.DataItem, "Isyarat_Stok").ToString();

                if (isyaratStokValue == "Stok Perlu Ditambah")
                {
                    // Apply pink background color to the cell in the "Isyarat_Stok" column
                    int columnIndex = GetColumnIndexByName(GridView1, "Isyarat_Stok");
                    e.Row.Cells[columnIndex].BackColor = System.Drawing.Color.HotPink;
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

        protected void btnExcel_Click(object sender, EventArgs e)
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
                for (int i = 0; i < 10; i++)
                {
                    string data = row.Cells.Count + "," + "data1,data2,data3,data4,data5,data6,data7,data8,data9,data10";
                    sb.Append(data);
                    // sb.Append(row.Cells[i].Text.Replace(",", ""));
                    // if (i < row.Cells.Count - 1)
                    // {
                    //     sb.Append(",");
                    // }
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