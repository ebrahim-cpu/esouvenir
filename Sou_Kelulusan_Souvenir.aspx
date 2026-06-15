<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Kelulusan_Souvenir.aspx.cs" Inherits="eSouvenir.Sou_Kelulusan_Souvenir" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>System eSouvenir KTPC</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url('Images_Black/28909.jpg');
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
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/Default_Celestial.jpg'); background-size: cover; background-repeat: repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>

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
                        <h1>1. List Of User Request
                            <img src="./Images/kelulusan.png" width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <br />
                <div class="container" style="background-image: url('/Images/.jpg');">
                    <%-- Background 1 atas --%>
                    <div class="row">
                        <div class="col-md-4">
                            <!-- btn excel n btn print -->
                            <div class="search-container">
                                <asp:Button ID="Button1" runat="server" Text="Export to Excel" OnClick="BtnExcel_Click" CssClass="btn btn-success" Style="width: 130px; height: 40px;" />
                                &nbsp;
                                    <button class="auto-style2" onclick="printGridView()">
                                        <img src="./Images/print.png" alt="Print Icon" width="30" height="30" />
                                    </button>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="d-flex align-items-center justify-content-center">
                                <span style="color: white; margin-right: 10px; white-space: nowrap;">Page Size:</span>
                                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="form-control thick-border" Style="width: 100px;">
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                    <asp:ListItem Value="100">100</asp:ListItem>
                                    <asp:ListItem Value="150">150</asp:ListItem>
                                    <asp:ListItem Value="200">200</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- Search Textbox -->
                            <div class="search-container">
                                <input type="text" id="txtSearch" class="form-control thick-border" placeholder="Search Here" onkeyup="searchGridView()" />
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                             <asp:GridView ID="GridView1" runat="server" CssClass="table table-3d table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CellPadding="3" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" BackColor="White" BorderColor="#999999" BorderWidth="1px" GridLines="Vertical" AllowPaging="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" BorderStyle="None" OnRowCommand="GridView1_RowCommand">
                                <AlternatingRowStyle BackColor="#DCDCDC" />
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="No" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                    <asp:BoundField DataField="Id_Pengguna" HeaderText="User Id" SortExpression="Id_Pengguna" Visible="false" />
                                    <asp:BoundField DataField="Pemohon" HeaderText="User" SortExpression="Pemohon" />
                                    <asp:BoundField DataField="Nama_Item" HeaderText="Item" SortExpression="Nama_Item" />
                                    <asp:BoundField DataField="Description" HeaderText="Remarks" SortExpression="Description" Visible="false" />
                                    <asp:BoundField DataField="Previous_Stock" HeaderText="Previous Quantity" SortExpression="Previous_Stock" />
                                    <asp:BoundField DataField="Quantity_Request" HeaderText="Quantity Request" SortExpression="Quantity_Request" />
                                    <asp:BoundField DataField="Jumlah_Stock" HeaderText="Available Quantity" SortExpression="Jumlah_Stock" />
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:dd/MMM/yyyy}" SortExpression="CreatedDate" />
                                    <asp:TemplateField HeaderText="Accept Date">
                                        <ItemTemplate>
                                            <asp:Label ID="Modified_DateLabel" runat="server" Text='<%# Bind("ModifiedDate", "{0:dd/MMM/yyyy}") %>' Visible='<%# ShowAcceptDate(Eval("Status")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <a href='<%# GetCancelDescriptionLink(Eval("Status"), Eval("Id"), Eval("Pemohon")) %>'
                                                <%# ShowHyperlink(Eval("Status")) ? "" : "style='pointer-events: none; cursor: default; text-decoration: none; color: inherit;'" %>>
                                                <%# Eval("Status") %>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="btn-container">                                                
                                                <asp:Button ID="UpdateButton" runat="server" Text="Action" CssClass="btn btn-warning btn-sm"
                                                    CommandName="UpdateCommand" CommandArgument='<%# Eval("Id") %>' OnClick="UpdateButton_Click"
                                                    Visible='<%# ShowUpdateButton(Eval("Status")) %>' />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="Black" />
                                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                <SelectedRowStyle BackColor="#008A8C" ForeColor="White" Font-Bold="True" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#000065" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>"
                    SelectCommand="SELECT [Id], [Id_Pengguna], [Pemohon], [Kategori], [Nama_Item], [Description], [Previous_Stock], [Quantity_Request], [Jumlah_Stock], [CreatedDate], [ModifiedDate], [Status]
                                 FROM [Sou_UserRequest] Order By [CreatedDate] DESC"></asp:SqlDataSource>
            </form>
        </div>
    </div>
    <!--START MODAL UPDATE -->
    <div class="modal fade" id="UpdateModal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Modal Title</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>This is a simple modal example.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!--END MODAL UPDATE -->
    <script>
        $(document).ready(function () {
            $('#UpdateButton').click(function () {
                console.log('UpdateButton clicked');
                $('#UpdateModal').modal('show');
            });
        });
    </script>
</body>
</html>
