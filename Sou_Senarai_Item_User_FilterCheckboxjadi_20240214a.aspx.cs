using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eSouvenir
{
    public partial class Sou_Senarai_Item_User : System.Web.UI.Page
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
            // Add your button action code here
        }
    }
}
