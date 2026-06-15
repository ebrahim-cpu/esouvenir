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
    }
}