<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Check_Cancel_Description.aspx.cs" Inherits="eSouvenir.Sou_Check_Cancel_Description" %>

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
            background-image: url('Images/grey2.jpg');
            background-repeat: no-repeat;
            justify-content: center;
            background-size: 1400px 600px;
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
                background-color: #f2f2f2;
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
        /* Apply a WOW 3D effect to textboxes */
        .form-control {
            border: 2px solid #ccc;
            border-radius: 10px;
            padding: 12px;
            background: linear-gradient(to bottom, #f5f5f5, #e0e0e0);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            transition: border-color 0.2s, box-shadow 0.2s, transform 0.2s;
        }
            .form-control:focus {
                border-color: #66afe9;
                outline: none;
                box-shadow: 0px 6px 16px rgba(0, 0, 0, 0.4);
                transform: scale(1.02);
            }
            .form-control::placeholder {
                color: #aaa;
            }
            .form-control:hover {
                box-shadow: 0px 6px 14px rgba(0, 0, 0, 0.35);
            }
    </style>
    <%--SEMUA BACKGROUND--%>
    <%-- /* script sidebar * /--%>
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
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px;  background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
    <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
         <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />
        <a href="Sou_Kelulusan_Alat_Tulis.aspx" class="w3-bar-item w3-button">1. User Request List </a>
        <a href="Sou_Admin_Daftar_Kategori.aspx" class="w3-bar-item w3-button">2. Category Registration</a>
        <a href="Sou_Admin_Pendaftaran_Item.aspx" class="w3-bar-item w3-button">3. New Item Registration</a>
        <a href="Sou_Admin_Penambahan_Kuantiti.aspx" class="w3-bar-item w3-button">4. Manage Stock </a>
        <a href="Sou_Admin_Request.aspx" class="w3-bar-item w3-button">5. Admin Request </a>
        <a href="Sou_Senarai_Item_Admin_Request.aspx" class="w3-bar-item w3-button">6. Item List (Admin Request)</a>
         <a href="Sou_StockInOutHistory.aspx" class="w3-bar-item w3-button">7. Stock In/Out History</a>

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
                            <img src="/Images/logout.png" alt="Logout Icon" />
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
                        <h1>User Cancel Description 
                            <img src="/Images/gambar1.jpg" alt="Icon" width="130" height="60"/></h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-5">
                        <div class="form-group">
                            <label for="txtId"><b></b></label>
                            <asp:TextBox ID="txtId" CssClass="form-control" Width="438px" runat="server" Visible="false" ></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="lblDate"><b><span style="color: yellow;" />1. Date</b> </label>
                            <asp:TextBox ID="txtDate" CssClass="form-control" runat="server" ReadOnly="true" Width="400px" ></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="txtNamaPengguna"><b><span style="color: yellow;" />2. Name </b></label>
                            <asp:TextBox ID="txtNamaPengguna" CssClass="form-control" ReadOnly="true" Width="400px" runat="server" ></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblCategory"><b><span style="color: yellow;" />3. Category</b> </label>
                            <asp:TextBox ID="txtCategory" CssClass="form-control" runat="server" ReadOnly="true" Width="400px" ></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblItem"><b><span style="color: yellow;" />4. Item</b> </label>
                            <asp:TextBox ID="txtItem" CssClass="form-control" runat="server" ReadOnly="true" Width="400px"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblDescription"><b><span style="color: yellow;" />5. Remarks</b> </label>
                            <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" ReadOnly="true" Width="400px"></asp:TextBox>
                        </div>
                        <br />
                    </div>
                    <div class="col-3">
                        <br />
                        <div class="form-group">
                            <label for="lblQuantity_Request"><b><span style="color: yellow;" />6. Quantity Request</b> </label>
                            <asp:TextBox ID="txtQuantity_Request" CssClass="form-control" runat="server" ReadOnly="true" Width="400px" ></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="txtCancelDescription"><b><span style="color: yellow;" />7. The user's request was canceled on the following date and time </b></label>
                            <br />
                            <br />
                            <asp:TextBox ID="txtCancelDescription" TextMode="MultiLine" ReadOnly="true" Rows="3" CssClass="form-control" runat="server" Width="400px" onkeyup="validateCancelDescription();" ></asp:TextBox>
                        </div>
                        <br />
                        <div class="text-left">
                            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" CssClass="btn btn-primary" Height="38px" Width="130px" />
                            <asp:Label ID="lblFillUp" runat="server" Text="Please fill up the textbox" ForeColor="red" Visible="false"></asp:Label>
                        </div>
                        <br />
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>