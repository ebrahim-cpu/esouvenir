<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Senarai_Item_Admin_Request.aspx.cs" Inherits="eSouvenir.Sou_Senarai_Item_Admin_Request" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>System eSouvenir KTPC</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <%--Background--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <%--Background--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url('Images_Black/28943.jpg');
            background-repeat: repeat;
            justify-content: center;
            background-size: 1500px 600px;
            background-attachment: fixed;
            background-position: center center; /* Add this line to center the background image */
        }
        /* Custom CSS to resize the w3-container */
        .w3-container {
            height: 2px; /* Set the desired height */
            /* width: 300px; */ /* You can also set a fixed width if needed */
            /* Add any other styles as per your design requirements */
        }

        h1 {
            text-align: center;
        }

        h2 {
            display: inline-block;
            margin: 0;
            text-align: center; /* Center the heading horizontally */
            width: 100%; /* Ensure the heading takes up the full width of its container */
        }

        .navbar-nav {
            margin-left: auto;
            padding-right: 10px;
            display: flex;
            align-items: center;
        }

        .auto-style1 {
            display: block;
            font-size: var(--bs-nav-link-font-size);
            font-weight: var(--bs-nav-link-font-weight);
            color: var(--bs-nav-link-color);
            text-decoration: none;
            transition: none;
            height: 25px;
        }

        .search-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            margin-bottom: 10px;
            align-items: center; /* Add this to vertically align the search box */
        }
            .search-container input {
                width: 300px; /* Adjust the width as per your requirement */
                margin-left: 10px;
            }

        .w3-sidebar a:hover {
            background-color: #444;
        }
        /* Part Logout Icon*/
        .nav-item {
            display: flex;
            align-items: center;
        }
            .nav-item a {
                display: flex;
                align-items: center;
            }

            .nav-item img {
                width: 50px; /* Adjust the width as needed */
                height: 50px; /* Adjust the height as needed */
                margin-left: 5px; /* Add some space between the icon and the username */
            }

        /* Finish Part Logout Icon*/
        /*3D Part*/
        /* Custom 3D-styling for the GridView */
        .table-3d {
            border-collapse: collapse;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        }

            .table-3d th, .table-3d td {
                padding: 8px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .table-3d th {
                background-color: #f2f2f2;
            }

            .table-3d tr:hover {
                background-color: #f5f5f5;
            }
            /* Apply 3D-style to the header row */
            .table-3d th {
                background-color: #ff1818;
                box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.1);
            }
            /* Apply 3D-style to the body rows */
            .table-3d tr:not(:first-child):hover {
                box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.2);
            }
        /* WOW: Animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }
        /* WOW: Hover Effect */
        .table-3d tbody tr:hover {
            background-color: #ffebcd; /* Light-colored background on hover */
            transform: scale(1.02); /* Slightly enlarge the row on hover */
            transition: background-color 0.2s, transform 0.2s;
        }
        /* WOW: Box Shadow Effect */
        .table-3d {
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s;
        }
    </style>
    <%--SEMUA BACKGROUND--%>
    <script>   /* script sidebar */
        function w3_open() {
            document.getElementById("main").style.marginLeft = "25%";
            document.getElementById("mySidebar").style.width = "25%";
            document.getElementById("mySidebar").style.display = "block";
            document.getElementById("openNav").style.display = 'none';
        }
        function w3_close() {
            document.getElementById("main").style.marginLeft = "0%";
            document.getElementById("mySidebar").style.display = "none";
            document.getElementById("openNav").style.display = "inline-block";
        }
        // Initialize the search text from ViewState when the page loads
        window.onload = function () {
            var searchText = '<%= ViewState["SearchText"] %>';
            document.getElementById("txtSearch").value = searchText;
            searchGridView();
        };
        // Initialize the search text from the hidden field when the page loads
        window.onload = function () {
            var searchText = document.getElementById("<%= hdnSearchText.ClientID %>").value;
            document.getElementById("txtSearch").value = searchText;
            searchGridView();
        };
        function searchGridView() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("txtSearch");
            filter = input.value.toUpperCase();
            table = document.getElementById("GridView1");
            tr = table.getElementsByTagName("tr");
            // Save the search text in the hidden field
            document.getElementById("<%= hdnSearchText.ClientID %>").value = input.value;
            for (i = 1; i < tr.length; i++) { // Start from 1 to skip header row
                td = tr[i].getElementsByTagName("td");
                var rowMatch = false;
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            rowMatch = true;
                            break;
                        }
                    }
                }
                tr[i].style.display = rowMatch ? "" : "none";
            }
        }
        /* For Print Code*/
        function printGridView() {
            var printContents = document.getElementById('GridView1').outerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/buffalumps_smoke_and_mirrors_ac9b654f.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
<%--        <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />--%>
        <a href="Sou_Kelulusan_Souvenir.aspx" class="w3-bar-item w3-button">1. User Request List </a>
        <a href="Sou_Admin_Daftar_Kategori.aspx" class="w3-bar-item w3-button">2. Category Registration</a>
        <a href="Sou_Admin_Pendaftaran_Item.aspx" class="w3-bar-item w3-button">3. New Item Registration</a>
        <a href="Sou_Admin_Penambahan_Kuantiti.aspx" class="w3-bar-item w3-button">4. Manage Stock </a>
        <a href="Sou_Admin_Request.aspx" class="w3-bar-item w3-button">5. Admin Request </a>
<%--        <a href="Sou_Senarai_Item_Admin_Request.aspx" class="w3-bar-item w3-button">6. Item List (Admin Request)</a>--%>
        <a href="Sou_StockInOutHistory.aspx" class="w3-bar-item w3-button">6. Stock Movement History</a>
        <div style="margin-top: 30px;">
            <p style="font-size: 16px; font-weight: bold; color: deepskyblue;">
                <asp:Literal ID="welcomeMessage" runat="server"></asp:Literal>
            </p>
        </div>
    </div>
    <div id="main">
        <%--warna hijau tu--%>
        <div class="w3-teal">
            <nav class="navbar navbar-expand-lg navbar-inverse" style="background-color: #696969;">
                <%-- Set Colour part atas--%>
                <div class="navbar-nav ml-auto">
                    <li class="nav-item navbar-text" style="height: 35px">
                        <asp:Label ID="lblUsername" runat="server" ForeColor="White"></asp:Label><br />
                        <br />
                        <i class="glyphicon glyphicon-user" style="color: #2196F3"></i>
                    </li>
                    <li class="nav-item">
                        <a class="auto-style1" href="Login.aspx">
                            <img src="./Images/logout.png" alt="Logout Icon" />
                        </a>
                    </li>
                </div>
            </nav>
            <div style="background-color: #696969;">
                <%--Set colour part tengah --%>
                <div class="row">
                    <div class="col-1">
                        <button id="openNav" class="w3-button w3-teal w3-xlarge" onclick="w3_open()">&#9776;</button>
                        <div style="background-color: #696969;"></div>
                        <%--Set colour part bawah --%>
                    </div>
                    <div class="col-10">
                        <h1>6. Item List (Admin Request)</h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <asp:HiddenField ID="hdnSearchText" runat="server" ClientIDMode="Static" />
                <br />
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-md-2">
                            <!-- btn excel n btn print -->
                            <div class="search-container">
                                <asp:Button ID="Button1" runat="server" Text="Export to Excel" OnClick="btnExcel_Click" CssClass="btn btn-success" Style="width: 130px; height: 40px;" />
                                &nbsp;
                               <button class="auto-style2" onclick="printGridView()">
                                   <img src="./Images/print.png" alt="Print Icon" width="30" height="30" />
                               </button>
                            </div>
                        </div>
                        <div class="col-md-10">
                            <!-- Search Textbox -->
                            <div class="search-container">
                                <input type="text" id="txtSearch" class="form-control" placeholder="Search Here" onkeyup="searchGridView()" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <!-- GridView and other content -->
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id_Item,Id_Kategori" CssClass="table table-3d table-striped table-bordered" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound" PageSize="300" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerSettings PageButtonCount="5" />
                        <Columns>
                            <asp:BoundField DataField="Id_Kategori" HeaderText="Id Category" SortExpression="Id_Kategori" Visible="false" />
                            <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                            <asp:BoundField DataField="Id_Item" HeaderText="Id Item" InsertVisible="False" ReadOnly="True" SortExpression="Id_Item" Visible="false" />
                            <asp:BoundField DataField="Nama_Item" HeaderText="Item" SortExpression="Nama_Item" />
                            <asp:BoundField DataField="Spesifikasi" HeaderText="Specification" SortExpression="Spesifikasi" />
                            <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                            <asp:BoundField DataField="KuantitiTambahan" HeaderText="Stock In/Out" SortExpression="KuantitiTambahan" />
                            <asp:BoundField DataField="Stok_Minima" HeaderText="Min Stock" SortExpression="Stok_Minima" />
                            <asp:BoundField DataField="Jumlah_Stock" HeaderText="Available Quantity" SortExpression="Jumlah_Stock" />
                            <asp:BoundField DataField="Isyarat_Stok" HeaderText="Status" SortExpression="Isyarat_Stok" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnAction" runat="server" Text="Add" OnClick="btnAction_Click" CssClass="btn btn-primary" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>"
                        SelectCommand="SELECT [Id_Item], [Id_Kategori], [Kategori], [Nama_Item], [Spesifikasi], [Unit],[KuantitiTambahan], [Stok_Minima], [Jumlah_Stock], [Isyarat_Stok] FROM [Sou_StockItem] ORDER BY CASE WHEN [Isyarat_Stok] = 'Stok Perlu Ditambah' THEN 0 ELSE 1 END, [Isyarat_Stok]"></asp:SqlDataSource>
                </div>
            </form>
        </div>
    </div>
</body>
</html>