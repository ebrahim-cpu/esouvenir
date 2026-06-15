<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_UpdateOrder_20230218.aspx.cs" Inherits="eSouvenir.Sou_Admin_UpdateOrder" %>

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
            background-image: url('Images/grey3.jpg');
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
    </script>
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px; background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
        <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />
        <a href="Sou_Senarai_Item_User.aspx" class="w3-bar-item w3-button">1. List Item</a>
        <a href="Sou_Keputusan_Permohonan_User.aspx" class="w3-bar-item w3-button">2. Order Status</a>
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
                    <ul class="navbar-nav ml-auto">
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
                    </ul>
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
                        <h1>A. Change Order
                            <img src="./Images/permohonan.png" width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <div class="container">
                    <%-- Background 1 atas --%>
                    <br />
                    <div class="row">
                        <div class="col-1"></div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="txtTarikhPermohonan" associatedcontrolid="txtTarikhPermohonan" style="font-size: 18px;"><b><span style="color: deepskyblue;" />1. Date</b> </label>
                                <asp:TextBox ID="txtTarikhPermohonan" type="date" runat="server" CssClass="form-control" TextMode="Date" Width="442px"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtidOrder" style="font-size: 18px;"><b><span style="color: deepskyblue;" />1. Order Id </b></label>
                                <asp:TextBox ID="txtidOrder" CssClass="form-control" Width="438px" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtidPengguna"><b></b></label>
                                <asp:TextBox ID="txtId" CssClass="form-control" Width="438px" runat="server" Visible="false"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtNamaPengguna" style="font-size: 18px;"><b><span style="color: deepskyblue;" />2. Name </b></label>
                                <br />
                                <asp:TextBox ID="txtNamaPengguna" CssClass="form-control" Width="438px" ReadOnly="true" runat="server"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="txtKategori" style="font-size: 18px;"><b><span style="color: deepskyblue;" />3. Category</b> </label>
                                <div class="auto-style4">
                                    <asp:TextBox ID="txtKategori" runat="server"  CssClass="form-control " Width="438px" AutoPostBack="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group" style="display: none;">
                                <label for="txtIdKategori" style="font-size: 18px;"><b><span style="color: deepskyblue;" />4. Id Kategori</b>  </label>
                                <asp:TextBox ID="txtIdKategori" runat="server" CssClass="form-control " ReadOnly="true" AutoPostBack="true" Width="438px"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="txtItem" style="font-size: 18px;"><b><span style="color: deepskyblue;" />4. Item</b> </label>
                                <div class="auto-style4">
                                    <asp:DropDownList ID="txtItem" runat="server" CssClass="form-control " Width="438px" AutoPostBack="true" Height="40px"></asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="lblSpecification" style="font-size: 18px;"><b><span style="color: deepskyblue;" />5. Specification</b> </label>
                                <asp:TextBox ID="txtSpecification" CssClass="form-control" runat="server" ReadOnly="true" Width="438px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group" style="display: none;">
                                <label for="txtIdItem" style="font-size: 18px;"><b><span style="color: deepskyblue;" />6. Id Item</b> </label>
                                <asp:TextBox ID="txtIdItem" CssClass="form-control" runat="server" Width="438px"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="lblUnit" style="font-size: 18px;"><b><span style="color: deepskyblue;" />6. Unit</b> </label>
                                <asp:TextBox ID="txtUnit" CssClass="form-control" ReadOnly="true" runat="server" Width="438px"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="txtKuantiti" style="font-size: 18px;"><b><span style="color: deepskyblue;" />7. Quantity ( Available Stock )</b> </label>
                                <asp:TextBox ID="txtKuantiti" CssClass="form-control" Width="438px" ReadOnly="true" runat="server"></asp:TextBox>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="txtBilKuantitiYgDimahukan" style="font-size: 18px;"><b><span style="color: deepskyblue;" />8. Quantity Request</b> </label>
                                <asp:TextBox ID="txtBilKuantitiYgDimahukan" CssClass="form-control" placeholder="Enter the desired amount" Style="width: 438px;" runat="server" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                <script>
                                    function isNumberKey(evt) {
                                        var charCode = (evt.which) ? evt.which : evt.keyCode;
                                        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                            return false;
                                        }
                                        return true;
                                    }
                                </script>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="txtDescription" style="font-size: 18px;"><b><span style="color: deepskyblue;" />9. Remarks</b></label>
                                <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="3" CssClass="form-control" runat="server" Width="438px"></asp:TextBox>
                                &nbsp; &nbsp;                       
                            </div>
                            
                            <div class="form-group">
                                <label for="chkListOptions" style="font-size: 18px;"><b><span style="color: deepskyblue;" />10. Package</b>  </label>
                                <asp:CheckBoxList ID="chkListOptions" runat="server" CssClass="form-control" AutoPostBack="true" Width="438px" ReadOnly="true">
                                    <asp:ListItem Text=" Investor" Value="IsInvestor" />
                                    <asp:ListItem Text=" Visitor" Value="IsVisitor" />
                                    <asp:ListItem Text=" Student" Value="IsStudent" />
                                    <asp:ListItem Text=" Staff (Retired)" Value="IsStaffRetired" />
                                    <asp:ListItem Text=" Staff (Noticed)" Value="IsStaffNoticed" />
                                    <asp:ListItem Text=" VIP" Value="IsVIP" />
                                </asp:CheckBoxList>
                            </div>
                            <br />
                            <asp:HiddenField ID="hdnStatus" runat="server" OnValueChanged="HdnStatus_ValueChanged" />
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:Button ID="btnHantar" runat="server" Text="Send" OnClick="BtnHantar_Click" CssClass="btn btn-primary " Height="38px" Width="170px" />
                        <br />
                        <asp:Label ID="lblErrorMesage" runat="server" Style="color: white;" Visible="false"></asp:Label>
                    </div>
                </div>
                <br />
                <div id="imageContainer" runat="server" class="text-center">
                    <!-- Your content here -->
                </div>
                <div class="col-sm-12 text-center">
                    <%--<asp:Label ID="LblItemPicture" runat="server" Text=""></asp:Label>--%>
                    <p>&copy; <%: DateTime.Now.Year %> - KTPC Sdn. Bhd. eStationary v1.0 | Last Update: 22 November 2023</p>
                </div>
            </form>
            <%-- End content --%>
        </div>
    </div>
</body>
</html>
