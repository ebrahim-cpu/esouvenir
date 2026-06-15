<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Senarai_Item_User_rubish_20240213d.aspx.cs" Inherits="eSouvenir.Sou_Senarai_Item_User" %>

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
            background-image: url('Images/A16.jpg');
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
                background-color: #e43e3e;
                box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.1);
            }
            /* Apply 3D-style to the body rows */
            .table-3d tr:not(:first-child):hover {
                box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.2);
            }

            .table-3d tbody tr:hover {
                background-color: #d4e6f1;
                transition: background-color 0.3s;
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
        /* Finish Part3D*/
        .search-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            margin-bottom: 10px;
            align-items: center; /* Add this to vertically align the search box */
        }

            .search-container input {
                margin-left: 10px;
                width: 300px;
                margin-left: 10px;
                border: 3px solid #696969; /* Add border style */
                padding: 5px; /* Add some padding for better visual appearance */
                border-radius: 5px; /* Add rounded corners */
            }
    </style>
    <%--SEMUA BACKGROUND--%>
    <%--/* script sidebar */--%>
    
    
    <script>
        $(document).ready(function () {
            $('.open-popup').click(function (event) {
                event.preventDefault(); // Prevent the default behavior (postback)
                var id = $(this).data('id');
                var url = 'Sou_Souvenir_Image_User.aspx?Id_Item=' + id;
                $.get(url, function (data) {
                    $('#imageContent').html(data);
                    $('#imageModal').modal('show');
                });
            });
        });
    </script>
    
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
                var isVisible = true;
                if (chkIsInvestorFilter && !rows[i].cells[10].querySelector("#chkIsInvestor").checked)
                    isVisible = false;
                if (chkIsVisitorFilter && !rows[i].cells[11].querySelector("#chkIsVisitor").checked)
                    isVisible = false;
                if (chkIsStudentFilter && !rows[i].cells[12].querySelector("#chkIsStudent").checked)
                    isVisible = false;
                if (chkIsStaffRetiredFilter && !rows[i].cells[13].querySelector("#chkIsStaffRetired").checked)
                    isVisible = false;
                if (chkIsStaffNoticedFilter && !rows[i].cells[14].querySelector("#chkIsStaffNoticed").checked)
                    isVisible = false;
                if (chkIsVIPFilter && !rows[i].cells[15].querySelector("#chkIsVIP").checked)
                    isVisible = false;
                rows[i].style.display = isVisible ? "" : "none";
            }
        }
</script>


</head>
<body>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px; background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
        <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />
        <a href="Sou_Senarai_Item_User.aspx" class="w3-bar-item w3-button">1. List Item </a>
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
                            <a class="auto-style1" href="Logout.aspx">
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
                    <div class="col-11">
                        <h1>1. List Item
                            <img src="./Images/stock.png" width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>

        <%--  Content--%>
        <div class="w3-container">
            <!-- Add new checkboxes for filtering -->
            <div>
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
                <div class="container">
                    <div class="row">
                        <div class="search-container">
                            <!-- Place the search textbox here -->
                            <input type="text" id="txtSearch" class="form-control" placeholder="Search Here " onkeyup="searchGridView2()" />
                        </div>
                    </div>
                    <label id="totalCountLabel"></label>
                    <label id="filteredCountLabel"></label>
                    <div class="col-md-12">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id_Item,Id_Kategori" DataSourceID="SqlDataSource2" AllowPaging="True" CssClass="table table-3d table-striped table-bordered" AllowSorting="True" PageSize="300" OnRowCommand="GridView2_RowCommand" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
                            <Columns>
                                <asp:BoundField DataField="Id_Item" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id_Item" Visible="true" />
                                <asp:BoundField DataField="Nama_Item" HeaderText="Item" SortExpression="Nama_Item" />
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Button ID="btnImage" runat="server" Text="Image" CssClass="btn btn-success open-popup" data-id='<%# Eval("Id_Item") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Id_Kategori" HeaderText="ID Category" SortExpression="Id_Kategori" Visible="false" />
                                <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                                <asp:BoundField DataField="Spesifikasi" HeaderText="Specification" SortExpression="Spesifikasi" />
                                <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                <asp:BoundField DataField="Stok_Minima" HeaderText="Min Stock" SortExpression="Stok_Minima" />
                                <asp:BoundField DataField="Jumlah_Stock" HeaderText="Available Stock" SortExpression="Jumlah_Stock" />
                                <asp:BoundField DataField="Isyarat_Stok" HeaderText="Status" SortExpression="Isyarat_Stok" />

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsInvestor" runat="server" Checked='<%# Eval("IsInvestor") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsVisitor" runat="server" Checked='<%# Eval("IsVisitor") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsStudent" runat="server" Checked='<%# Eval("IsStudent") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsStaffRetired" runat="server" Checked='<%# Eval("IsStaffRetired") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsStaffNoticed" runat="server" Checked='<%# Eval("IsStaffNoticed") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsVIP" runat="server" Checked='<%# Eval("IsVIP") %>' Enabled="false" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:Button ID="btnAction" runat="server" Text="Request" OnClick="btnAction_Click" CssClass="btn btn-primary" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <HeaderStyle CssClass="thead-dark" BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FFF1D4" />
                            <SortedAscendingHeaderStyle BackColor="#B95C30" />
                            <SortedDescendingCellStyle BackColor="#F1E5CE" />
                            <SortedDescendingHeaderStyle BackColor="#93451F" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>" SelectCommand="SELECT [Id_Item], [Nama_Item], [Id_Kategori], [Kategori], [Spesifikasi], [Unit], [Stok_Minima], [Jumlah_Stock], [Isyarat_Stok], [IsInvestor], [IsVisitor], [IsStudent], [IsStaffRetired], [IsStaffNoticed], [IsVIP] FROM [Sou_StockItem]"></asp:SqlDataSource>
                    </div>
                </div>
                <hr />
                <div class="col-sm-12 text-center">
                    <p>&copy; <%: DateTime.Now.Year %> - KTPC Sdn. Bhd. eSouvenir v1.0 | Last Update: 7 February 2024</p>
                </div>
                <br />
            </form>
        </div>
    </div>
   
    <!-- Modal Popup -->
    <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageModalLabel">Image Details</h5>
                    <%--                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>--%>
                </div>
                <div class="modal-body">
                    <!-- Image content will appear here -->
                    <div id="imageContent"></div>
                </div>
                <div class="modal-footer">
                    <%-- <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> --%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
