using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class StockInOutHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
            {
                lblUsername.Text = Session["Username"].ToString();
                // string pemohonName = Session["Username"].ToString(); // or Session["Pemohon"].ToString();
                welcomeMessage.Text = "Welcome, " + lblUsername.Text + "!";
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
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
    }
}