using System;
using System.Collections.Generic;
using System.IO;
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
            if (!IsPostBack)
            {
                GridView1.PageSize = 25;
            }
        }
        protected void BtnExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=StockMovementHistory.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    GridView1.AllowPaging = false;
                    GridView1.DataBind();
                    
                    GridView1.RenderControl(hw);
                    
                    string style = @"<style> td { mso-number-format:\@; } </style>";
                    Response.Write(style);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Verifies that the control is rendered in a form tag
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            GridView1.PageIndex = 0;
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
        }
    }
}