<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_Penambahan_Kuantiti.aspx.cs" Inherits="eSouvenir.Sou_Admin_Penambahan_Kuantiti" %>

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
            background-image: url('Images_Black/29008.jpg');
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
                background-color: #000000;
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
        hr.rounded {
            border-color: #000000; /* Use a slightly darker shade of yellow */
            border-width: 5px; /* Change the thickness */
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
        /* Start for gridview1 and search textbox1*/
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
        /* End for gridview1 and search textbox1*/
        /* Start for gridview2 and search textbox2*/
        function searchGridView2() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("txtSearch2");
            filter = input.value.toUpperCase();
            table = document.getElementById("GridView2");
            tr = table.getElementsByTagName("tr");
            for (i = 1; i < tr.length; i++) {
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
        function printGridView2() {
            var printContents = document.getElementById('GridView2').outerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
        /* End for gridview2 and search textbox2*/

        //code ni untk setkan txtPerubahanKuantiti hnya boleh insert num
        function validateNumericInput(input) {
            input.value = input.value.replace(/[^0-9]/g, ''); // Remove non-numeric characters
        }
        function redirectToPage() {
            // Redirect to the desired page
            window.location.href = 'Admin_Penambahan_Kuantiti.aspx';
        }
    </script>
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/aiart5836_dark_classic_landscape.png'); background-size: cover; background-repeat: repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
<%--        <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />--%>
        <a href="Sou_Kelulusan_Souvenir.aspx" class="w3-bar-item w3-button">1. User Request List </a>
        <a href="Sou_Admin_Daftar_Kategori.aspx" class="w3-bar-item w3-button">2. Category Registration</a>
        <a href="Sou_Admin_Pendaftaran_Item.aspx" class="w3-bar-item w3-button">3. New Item Registration</a>
        <a href="Sou_Admin_Penambahan_Kuantiti.aspx" class="w3-bar-item w3-button">4. Manage Stock </a>
        <a href="Sou_Admin_Request.aspx" class="w3-bar-item w3-button">5. Admin Request </a>
<%--        <a href="Sou_Senarai_Item_Admin_Request.aspx" class="w3-bar-item w3-button">6. Item List (Admin Request)</a>--%>
        <a href="Sou_StockInOutHistory.aspx" class="w3-bar-item w3-button">6. Stock Movement History</a>
        <a href="Sou_Report.aspx" class="w3-bar-item w3-button">7. Reports</a>
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
                        <h1>4. Manage Stock
                            <img src="./Images/stock.png" width="50" height="50" /></h1>
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
                        <div class="col-6">
                            <div class="form-group">
                                <label for="lblTarikhTopup" associatedcontrolid="txtTarikhTopup"><b><span style="color: deepskyblue;" />1. Date</b></label>
                                <asp:TextBox ID="txtTarikhTopup" type="date" runat="server" CssClass="form-control" TextMode="Date" OnTextChanged="TxtTarikhTopup_TextChanged" Width="420px" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                                <script>
                                    /* // get the current date*/
                                    var today = new Date();
                                    // format the date as yyyy-mm-dd
                                    var yyyy = today.getFullYear();
                                    var mm = today.getMonth() + 1; // months are zero-based
                                    var dd = today.getDate();
                                    if (mm < 10) {
                                        mm = '0' + mm;
                                    }
                                    if (dd < 10) {
                                        dd = '0' + dd;
                                    }
                                    var formattedDate = yyyy + '-' + mm + '-' + dd;
                                    /*  set the value of the date input field to today's date*/
                                    document.getElementById('<%= txtTarikhTopup.ClientID %>').value = formattedDate;
                                </script>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="lblDdlKategori"><b><span style="color: deepskyblue;" />2.Category</b> </label>
                                <div class="auto-style4">
                                    <asp:DropDownList ID="ddlKategori" runat="server" OnSelectedIndexChanged="DdlKategori_SelectedIndexChanged1" CssClass="form-control " Width="420px" AutoPostBack="true" Height="40px" Style="border-color: black; border-width: 1px;"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lblIdKategori"></label>
                                <asp:TextBox ID="txtIdKategori" runat="server" CssClass="form-control " Visible="false"  ReadOnly="true" AutoPostBack="true" Width="420px" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="lblItem"><b><span style="color: deepskyblue;" />3.Item</b>  </label>
                                <div class="auto-style4">
                                    <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" CssClass="form-control" Width="420px" AutoPostBack="true" Style="border-color: black; border-width: 1px;"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group ">
                                <label for="lblIdItem"></label>
                                <asp:TextBox ID="txtIdItem" CssClass="form-control" runat="server" Visible="false" Width="420px" ReadOnly="true"  Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="lblSpesifikasi"><b><span style="color: deepskyblue;" />4. Specification</b>  </label>
                                <asp:TextBox ID="txtSpesifikasi" CssClass="form-control" Width="420px" ReadOnly="true" runat="server"  Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="lblUnit"><b><span style="color: deepskyblue;" />5. Unit</b>  </label>
                                <asp:TextBox ID="txtUnit" CssClass="form-control" ReadOnly="true" Width="420px" runat="server"  Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            </div>
                            <br />
                        </div>
                        <div class="col-6">
                            <div class="auto-style7">
                                <label for="lblKuantiti"><b><span style="color: deepskyblue;" />6. Available Quantity</b>  </label>
                                <asp:TextBox ID="txtKuantiti" CssClass="form-control" Width="420px" runat="server" ReadOnly="true"  Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            </div>
                            <br />
                            <asp:HiddenField ID="hdnShowModal" runat="server" Value="false" />
                            <div style="display: flex; align-items: center;">
                                <div class="form-group">
                                    <label for="lblPerubahanKuantiti"><b><span style="color: deepskyblue;" />7. Quantity (Stock In/Out)</b> </label>
                                    <asp:TextBox ID="txtPerubahanKuantiti" CssClass="form-control" Width="420px" runat="server" OnTextChanged="TxtPerubahanKuantiti_TextChanged"
                                        oninput="validateNumericInput(this);" Style="border-color: black; border-width: 1px;"></asp:TextBox>

                                    <br />
                                    <asp:Button ID="BtnTambah" runat="server" Width="110px" Text="Stock in(+)" CssClass="btn btn-success" OnClick="BtnTambah_Click" />
                                    &nbsp;
                               <asp:Button ID="BtnTolak" runat="server" Width="110px" Text="Stock out(-)" CssClass="btn btn-danger" OnClick="BtnTolak_Click" />
                                </div>
                                <br />
                            </div>
                            <asp:Label ID="LblAturan1" runat="server" Text="<b>Please insert the value FIRST & choose symbol</b>" Style="color: red;"></asp:Label>
                            <br />
                            <div class="form-group" id="descriptionContainer" runat="server" style="display: none;">
                                <br />
                                <label for="lblDescription"><b>7.1. Description</b>  <span style="color: red;">(Required)</span></label>
                                <asp:TextBox ID="txtdescription" CssClass="form-control" Width="420px" runat="server" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                                <div id="myModal" class="modal fade" role="dialog">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Notification</h4>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>
                                            <div class="modal-body">
                                                Please fill up the blue textbox.
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="form-group">
                                    <label for="lblJumlahStock"><b>8. New Quantity</b> </label>
                                    <asp:TextBox ID="txtJumlahStock" CssClass="form-control" Width="420px" runat="server" ReadOnly="true"  Style="border-color: black; border-width: 1px;"></asp:TextBox>
                                </div>
                            </div>
                            <br />
                            <div class="text-left">
                                <asp:Button ID="btnSimpan" runat="server" Text="Save" OnClick="BtnSimpan_Click" CssClass="btn btn-primary" Width="120px" Height="35px" />
                                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="true"></asp:Label>

                                <img id="imgClickHere" src="./Images/ClickHere.png" alt="click Icon" style="width: 50px; height: auto;" runat="server" visible="false" onclick="redirectToPage()" />
                            </div>
                            <br />
                            <br />
                            <br />
                        </div>
                    </div>
                    <br />
                    <br />
                    <%-- Start Gridview --%>
                    <hr class="rounded" />
                    <div class="h4 pb-2 mb-4 text-danger border-bottom border-danger">
                        <h3 style="color: black;">Table Manage Stock</h3>

                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2">
                                <!-- btn excel n btn print -->
                                <div class="search-container">
                                    <asp:Button ID="BtnExcel2" runat="server" Text="Export to Excel" OnClick="BtnExcel2_Click" CssClass="btn btn-success" Style="width: 130px; height: 40px;" />
                                    &nbsp;
                               <button class="auto-style2" onclick="printGridView2()">
                                   <img src="./Images/print.png" alt="Print Icon" width="30" height="30" />
                               </button>
                                </div>
                            </div>
                            <div class="col-md-10">
                                <!-- Search Textbox -->
                                <div class="search-container">
                                    <input type="text" id="txtSearch2" class="form-control" placeholder="Search Here" onkeyup="searchGridView2()" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="container">
                        <!-- GridView and other content -->
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id_Item,Id_Kategori" CssClass="table table-3d table-striped table-bordered" DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True" OnRowDataBound="GridView2_RowDataBound" PageSize="300" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" GridLines="Vertical" ForeColor="Black">
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="Yellow" />
                            <PagerSettings PageButtonCount="5" />
                            <AlternatingRowStyle BackColor="#CCCCCC" />
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
                                        <asp:Button ID="btnAction" runat="server" Text="Add" OnClick="BtnAction_Click" CssClass="btn btn-primary" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>"
                            SelectCommand="SELECT [Id_Item], [Id_Kategori], [Kategori], [Nama_Item], [Spesifikasi], [Unit],[KuantitiTambahan], [Stok_Minima], [Jumlah_Stock], [Isyarat_Stok] FROM [Sou_StockItem] ORDER BY CASE WHEN [Isyarat_Stok] = 'Stok Perlu Ditambah' THEN 0 ELSE 1 END, [Isyarat_Stok]"></asp:SqlDataSource>
                    </div>
                    <br />
                    <br />
                    <%--End gridview--%>
                    <hr class="rounded" />
                    <div class="h4 pb-2 mb-4 text-danger border-bottom border-danger">
                        <h3 style="color: black;">History Manage Stock</h3>
                    </div>
                    <br />
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2">
                                <%--     btn excel n btn print--%>
                                <div class="search-container">
                                    <asp:Button ID="Button1" runat="server" Text="Export to Excel" OnClick="BtnExcel_Click" CssClass="btn btn-success" Style="width: 130px; height: 40px;" />
                                    &nbsp;
                               <button class="auto-style2" onclick="printGridView()">
                                   <img src="./Images/print.png" alt="Print Icon" width="30" height="30" />
                               </button>
                                </div>
                            </div>
                            <div class="col-md-10">
                                <%--   Search Textbox --%>
                                <div class="search-container">
                                    <input type="text" id="txtSearch" class="form-control" placeholder="Search Here" onkeyup="searchGridView()" />
                                </div>
                            </div>

                        </div>
                    </div>
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-3d table-striped table-bordered" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound1" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None" AllowPaging="True" AllowSorting="True" PageSize="300">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="Orange" />
                        <Columns>
                            <asp:BoundField DataField="Id_KuantitiTambahan" HeaderText="No" InsertVisible="True" ReadOnly="True" SortExpression="Id_KuantitiTambahan" />
                            <asp:BoundField DataField="ModifiedDate" HeaderText="Date" DataFormatString="{0:dd/MMM/yyyy}" SortExpression="ModifiedDate" />
                            <asp:BoundField DataField="Id_Kategori" HeaderText="Id Category" SortExpression="Id_Kategori" />
                            <asp:BoundField DataField="Nama_Kategori" HeaderText="Category" SortExpression="Nama_Kategori" />
                            <asp:BoundField DataField="Id_Item" HeaderText="Id Item" SortExpression="Id_Item" />
                            <asp:BoundField DataField="Nama_Item" HeaderText="Item" SortExpression="Nama_Item" />
                            <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                            <asp:BoundField DataField="Previous_Stock" HeaderText="Previous Quantity" SortExpression="Previous_Stock" />
                            <asp:BoundField DataField="KuantitiTambahan" HeaderText="Stock In/Out" SortExpression="KuantitiTambahan" />
                            <asp:BoundField DataField="Jumlah_Stock" HeaderText="Quantity" SortExpression="Jumlah_Stock" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>" SelectCommand="SELECT [Id_KuantitiTambahan], [CreatedDate], [ModifiedDate], [Id_Kategori], [Nama_Kategori], [Id_Item], [Nama_Item], [Unit], [Previous_Stock], [KuantitiTambahan], [Jumlah_Stock], [Description] FROM [Sou_StockInOut]  ORDER BY [Id_KuantitiTambahan] DESC"></asp:SqlDataSource>
                </div>
            </form>
        </div>
        <br />
        <br />
    </div>
</body>
</html>