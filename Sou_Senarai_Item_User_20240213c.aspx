<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Senarai_Item_User.aspx.cs" Inherits="eSouvenir.Sou_Senarai_Item_User" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Background -->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <!-- Bootstrap CSS -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        /* Add your custom styles here */
    </style>
    
    <script type="text/javascript">
        function applyFilters() {
            var chkIsInvestorFilter = document.getElementById('<%= chkIsInvestorFilter.ClientID %>').checked;
        var chkIsVisitorFilter = document.getElementById('<%= chkIsVisitorFilter.ClientID %>').checked;
        var chkIsStudentFilter = document.getElementById('<%= chkIsStudentFilter.ClientID %>').checked;
        var chkIsStaffRetiredFilter = document.getElementById('<%= chkIsStaffRetiredFilter.ClientID %>').checked;
        var chkIsStaffNoticedFilter = document.getElementById('<%= chkIsStaffNoticedFilter.ClientID %>').checked;
        var chkIsVIPFilter = document.getElementById('<%= chkIsVIPFilter.ClientID %>').checked;

        var rows = document.getElementById('<%= GridView2.ClientID %>').getElementsByTagName("tr");
            for (var i = 1; i < rows.length; i++) { // Start from 1 to skip header row
                var isVisible = false;
                var row = rows[i];
                var checkboxes = row.getElementsByTagName("input");
                for (var j = 0; j < checkboxes.length; j++) {
                    if (checkboxes[j].type === "checkbox") {
                        var isChecked = checkboxes[j].checked;
                        var columnValue = checkboxes[j].value;
                        if ((chkIsInvestorFilter && columnValue === "IsInvestor") ||
                            (chkIsVisitorFilter && columnValue === "IsVisitor") ||
                            (chkIsStudentFilter && columnValue === "IsStudent") ||
                            (chkIsStaffRetiredFilter && columnValue === "IsStaffRetired") ||
                            (chkIsStaffNoticedFilter && columnValue === "IsStaffNoticed") ||
                            (chkIsVIPFilter && columnValue === "IsVIP")) {
                            isVisible = true;
                            break; // No need to check further once any match is found
                        }
                    }
                }
                row.style.display = isVisible ? "" : "none";
            }
        }
</script>


</head>
<body>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px; background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <!-- Sidebar content here -->
    </div>
    <div id="main">
        <div class="w3-teal">
            <!-- Navbar content here -->
        </div>
        <div class="w3-container">
            <div>
                <!-- Checkboxes for filtering -->
                <input type="checkbox" id="chkIsInvestorFilter" runat="server" />
                <label for="chkIsInvestorFilter">Is Investor</label>
                <input type="checkbox" id="chkIsVisitorFilter" runat="server" />
                <label for="chkIsVisitorFilter">Is Visitor</label>
                <input type="checkbox" id="chkIsStudentFilter" runat="server" />
                <label for="chkIsStudentFilter">Is Student</label>
                <input type="checkbox" id="chkIsStaffRetiredFilter" runat="server" />
                <label for="chkIsStaffRetiredFilter">Is Staff Retired</label>
                <input type="checkbox" id="chkIsStaffNoticedFilter" runat="server" />
                <label for="chkIsStaffNoticedFilter">Is Staff Noticed</label>
                <input type="checkbox" id="chkIsVIPFilter" runat="server" />
                <label for="chkIsVIPFilter">Is VIP</label>
                <input type="button" id="btnApplyFilters" runat="server" value="Apply Filters" onclick="applyFilters();" />
            </div>
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <!-- GridView here -->
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id_Item,Id_Kategori" DataSourceID="SqlDataSource2" AllowPaging="True" CssClass="table table-3d table-striped table-bordered" AllowSorting="True" PageSize="300" OnRowCommand="GridView2_RowCommand" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
                    <!-- GridView columns here -->
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>" SelectCommand="SELECT [Id_Item], [Nama_Item], [Id_Kategori], [Kategori], [Spesifikasi], [Unit], [Stok_Minima], [Jumlah_Stock], [Isyarat_Stok], [IsInvestor], [IsVisitor], [IsStudent], [IsStaffRetired], [IsStaffNoticed], [IsVIP] FROM [Sou_StockItem]"></asp:SqlDataSource>
            </form>
        </div>
    </div>
</body>
</html>
