using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Senarai_Item_User3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        protected void BindGridView()
        {
            GridView2.DataBind();
        }
        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            ApplyFilters();
        }
        protected void ApplyFilters()
        {
            foreach (GridViewRow row in GridView2.Rows)
            {
                bool isVisible = false;
                CheckBox chkIsInvestorRow = (CheckBox)row.FindControl("chkIsInvestorRow");
                CheckBox chkIsVisitorRow = (CheckBox)row.FindControl("chkIsVisitorRow");
                CheckBox chkIsStudentRow = (CheckBox)row.FindControl("chkIsStudentRow");
                CheckBox chkIsStaffRetiredRow = (CheckBox)row.FindControl("chkIsStaffRetiredRow");
                CheckBox chkIsStaffNoticedRow = (CheckBox)row.FindControl("chkIsStaffNoticedRow");
                CheckBox chkIsVIPRow = (CheckBox)row.FindControl("chkIsVIPRow");
                bool chkIsInvestorFilter = chkIsInvestor.Checked;
                bool chkIsVisitorFilter = chkIsVisitor.Checked;
                bool chkIsStudentFilter = chkIsStudent.Checked;
                bool chkIsStaffRetiredFilter = chkIsStaffRetired.Checked;
                bool chkIsStaffNoticedFilter = chkIsStaffNoticed.Checked;
                bool chkIsVIPFilter = chkIsVIP.Checked;
                if ((chkIsInvestorFilter && chkIsInvestorRow.Checked) ||
                    (chkIsVisitorFilter && chkIsVisitorRow.Checked) ||
                    (chkIsStudentFilter && chkIsStudentRow.Checked) ||
                    (chkIsStaffRetiredFilter && chkIsStaffRetiredRow.Checked) ||
                    (chkIsStaffNoticedFilter && chkIsStaffNoticedRow.Checked) ||
                    (chkIsVIPFilter && chkIsVIPRow.Checked))
                {
                    isVisible = true;
                }
                row.Visible = isVisible;
            }
        }
        protected void FilterCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            ApplyFilters();
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
    }
}