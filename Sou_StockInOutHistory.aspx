<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_StockInOutHistory.aspx.cs" Inherits="eSouvenir.StockInOutHistory" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <%--Background--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <%--Background--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url('Images_Black/29020.jpg');
            background-repeat: no-repeat;
            justify-content: center;
            background-size: 1500px 600px;
            background-attachment: fixed;
            background-position: center center; /* Add this line to center the background image */
        }
        /* Custom CSS to resize the w3-container */
        .w3-container {
            height: 2px; /* Set the desired height */
            /* width: 300px; */ /* You can also set a fixed width if needed */
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
        .auto-style2 {
            display: block;
            font-size: var(--bs-nav-link-font-size);
            font-weight: var(--bs-nav-link-font-weight);
            color: var(--bs-nav-link-color);
            text-decoration: none;
            transition: none;
            height: 36px;
        }
        .search-container {
            display: flex;
            justify-content: flex-start;
            margin-top: 10px;
            margin-bottom: 10px;
            align-items: center; /* Add this to vertically align the search box */
        }
            .search-container input {
                width: 300px; /* Adjust the width as per your requirement */
                margin-left: 10px;
            }

                /* Add this CSS rule to change the placeholder text color to blue */
                .search-container input::placeholder {
                    color: blue;
                }
        .thick-border { /*searchtextbox*/
            border: 2px solid #000; /* Change the color as needed */
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
                background-color: #e68b47;
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
        .actions-column { /* adjust width column yg ada btn accept & Reject*/
            width: 2000px; /* Adjust the width as needed */
        }
        .btn-container {
            display: flex;
            gap: 10px; /* Adjust the gap size as needed */
        }
    </style>
    <%--SEMUA BACKGROUND--%>
    <%--/* script sidebar * /--%>
    <script>
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
        function searchGridView() {     /* For search textbox*/
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("txtSearch");
            filter = input.value.toUpperCase();
            table = document.getElementById("GridView1");
            tr = table.getElementsByTagName("tr");
            for (i = 1; i < tr.length; i++) { // Start from 1 to skip header row
                td = tr[i].getElementsByTagName("td");
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                            break;
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script>
        function exportToPdf() {
            var element = document.getElementById('GridView1');
            var opt = {
                margin:       0.3,
                filename:     'StockMovementHistory.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2, useCORS: true },
                jsPDF:        { unit: 'in', format: 'legal', orientation: 'landscape' }
            };
            html2pdf().set(opt).from(element).save();
        }
    </script>
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/visual_nexus_hypermaximalist.png'); background-size: cover; background-repeat: repeat;" id="mySidebar">
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
                        <h1>7. Stock Movement History
                            <img src="./Images/stockInOut.png" width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--  Content--%>
    <div class="w3-container">
        <form id="form1" runat="server" method="post" enctype="multipart/form-data">
            <br />
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="search-container">
                            <asp:Button ID="Button1" runat="server" Text="Export to Excel" OnClick="BtnExcel_Click" CssClass="btn btn-primary" Style="width: 130px; height: 40px;" />
                            &nbsp;
                            <button id="btnPdf" class="btn btn-danger" onclick="exportToPdf(); return false;" style="width: 130px; height: 40px;">Export to PDF</button>
                            &nbsp;
                            <button class="auto-style2" onclick="printGridView()">
                                <img src="./Images/print.png" alt="Print Icon" width="30" height="30" />
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="search-container justify-content-center">
                            <span style="color: white; margin-right: 10px; white-space: nowrap;">Page Size:</span>
                            <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="form-control thick-border" Style="width: 100px;">
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="100">100</asp:ListItem>
                                <asp:ListItem Value="150">150</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="search-container">
                            <input type="text" id="txtSearch" class="form-control" placeholder="Search Here" onkeyup="searchGridView()" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="background-image: url('/Images/.jpg');">
                <%-- Background 1 atas --%>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-3d table-striped table-bordered" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" GridLines="None" PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging" ForeColor="Black">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:BoundField DataField="Id_Ledger" HeaderText="Id" SortExpression="Id_Ledger" Visible="false" />
                        <asp:BoundField DataField="CreatedDate" DataFormatString="{0:dd/MMM/yyyy}" HeaderText="Created Date" SortExpression="CreatedDate" />
                        <asp:BoundField DataField="CreatedBy" HeaderText="Created By" SortExpression="CreatedBy" />
                        <asp:BoundField DataField="Modification_Date" DataFormatString="{0:dd/MMM/yyyy}" HeaderText="Modification Date" SortExpression="Modification_Date" />
                        <asp:BoundField DataField="ModifiedBy" HeaderText="Modified By" SortExpression="ModifiedBy" />
                        <asp:BoundField DataField="User" HeaderText="User" Visible="false" SortExpression="User" />
                        <asp:BoundField DataField="User_ID" HeaderText="User ID" Visible="false" SortExpression="User_ID" />
                        <asp:BoundField DataField="Category_ID" HeaderText="Category_ID" Visible="false" SortExpression="Category_ID" />
                        <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                        <asp:BoundField DataField="Item_ID" HeaderText="Item_ID" Visible="false" SortExpression="Item_ID" />
                        <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                        <asp:BoundField DataField="Previous_Stock" HeaderText="Previous Stock" SortExpression="Previous_Stock" />
                        <asp:BoundField DataField="InOutStock" HeaderText="Stock In/Out" SortExpression="InOutStock" />
                        <asp:BoundField DataField="Total_Stock" HeaderText="Total Stock" SortExpression="Total_Stock" />
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        <asp:BoundField DataField="Stok_Minima" HeaderText="Min Stock" SortExpression="Stok_Minima" />
                        <asp:BoundField DataField="Isyarat_Stok" HeaderText="Stock Condition" SortExpression="Isyarat_Stok" />
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <SortedAscendingCellStyle BackColor="#FAFAE7" />
                    <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                    <SortedDescendingCellStyle BackColor="#E1DB9C" />
                    <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>" SelectCommand="SELECT [Id_Ledger], [CreatedDate], [CreatedBy], [Modification_Date], [ModifiedBy], [User], [User_ID], [Category_ID], [Category], [Item_ID], [Item], [Unit], [Previous_Stock], [InOutStock], [Total_Stock], [Status], [Stok_Minima], [Isyarat_Stok] FROM [Sou_Ledger] ORDER BY [Modification_Date] DESC"></asp:SqlDataSource>
            </div>
        </form>
    </div>
</body>
</html>