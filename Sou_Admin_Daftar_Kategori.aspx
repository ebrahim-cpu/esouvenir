<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_Daftar_Kategori.aspx.cs" Inherits="eSouvenir.Sou_Admin_Daftar_Kategori" %>

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
            background-image: url('Images/A51.jpg');
            background-repeat: no-repeat;
            justify-content: center;
            background-size: 1600px 700px;
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
                background-color: #ff6a00;
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
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px;  background-image: url('./Images_Black/buffalumps_swirling_citadel_ninja_fortress.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
    <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
<%--         <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />--%>
        <a href="Sou_Kelulusan_Souvenir.aspx" class="w3-bar-item w3-button">1. User Request List </a>
        <a href="Sou_Admin_Daftar_Kategori.aspx" class="w3-bar-item w3-button">2. Category Registration</a>
        <a href="Sou_Admin_Pendaftaran_Item.aspx" class="w3-bar-item w3-button">3. New Item Registration</a>
        <a href="Sou_Admin_Penambahan_Kuantiti.aspx" class="w3-bar-item w3-button">4. Manage Stock </a>
        <a href="Sou_Admin_Request.aspx" class="w3-bar-item w3-button">5. Admin Request </a>
<%--        <a href="Sou_Senarai_Item_Admin_Request.aspx" class="w3-bar-item w3-button">6. Item List (Admin Request)</a>--%>
         <a href="Sou_StockInOutHistory.aspx" class="w3-bar-item w3-button">6. Stock Movement History</a>
          <a href="Sou_Report.aspx" class="w3-bar-item w3-button">7. Reports</a>
        <div style="margin-top: 30px;">
    <p style="font-size: 16px; font-weight: bold; color: deepskyblue ;">
        <asp:Literal ID="welcomeMessage" runat="server" ></asp:Literal>
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
                        <h1>2. Category Registration&nbsp; <img src="./Images/123.png"  width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <br />
                <div class="row">
                    <div class="col-3"></div>
                    <div class="col-9">
                        <div style="justify-content: center;">
                            <div class="form-group">
                                <asp:Label ID="lblTarikh" AssociatedControlID="txtTarikh" Text="<b>1. Date</b>" runat="server" Style="color: white;"></asp:Label>
                                <br />
                                <asp:TextBox ID="txtTarikh" type="date" runat="server" CssClass="form-control" placeholder="New Category" TextMode="Date"  Width="680px"></asp:TextBox>
                                <script>
                                    // get the current date
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
                                    // set the value of the date input field to today's date
                                    document.getElementById('txtTarikh').value = formattedDate;
                                </script>
                            </div>
                            <br />
                            <div class="form-group">
                                <label for="Nama_Kategory" style="color: white;"><b>2. Add Category</b>
                                    <br />
                                </label>
                                <asp:TextBox ID="txtNama_Kategori" CssClass="form-control " runat="server" OnTextChanged="TxtNama_Kategori_TextChanged" Width="680px"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div>
                            <asp:Button ID="btnDaftar_Kategori" runat="server" Text="Register" ControlStyle-CssClass="btn btn-success " ItemStyle-HorizontalAlign="Center" OnClick="BtnDaftar_Kategori_Click" Width="95px" />
                            <br />
                            <asp:Label ID="forbtnDaftar_Kategori" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
                <br />
                <div style="text-align: center;">
                    <h3><b>List Of Category</b></h3>
                </div>
                <div style="display: flex; justify-content: center;">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-3d table-striped table-bordered" CellPadding="3" DataKeyNames="Id_Kategori" DataSourceID="SqlDataSource1"
                        OnRowUpdating="GridView1_RowUpdating" Width="835px" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" AllowSorting="True" AllowPaging="True" ForeColor="Black" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="Id_Kategori" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id_Kategori" DataFormatString="{0}" />
                            <asp:TemplateField HeaderText="Category" SortExpression="Nama_Kategori">
                                <ItemTemplate>
                                    <div style="display: flex; justify-content: center;">
                                        <%# Eval("Nama_Kategori") %>
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="display: flex; justify-content: center;">
                                        <asp:TextBox ID="txtNamaKategoriEdit" runat="server" Text='<%# Bind("Nama_Kategori") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="tarikh_daftar" HeaderText="Registration Date" DataFormatString="{0:dd/MMM/yyyy}" SortExpression="tarikh_daftar" ReadOnly="true" />
                            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" ControlStyle-CssClass="btn btn-outline-success" ItemStyle-HorizontalAlign="Center" ButtonType="Button">
                                <ControlStyle CssClass="btn btn-outline-success"></ControlStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </asp:CommandField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>"
                        SelectCommand="SELECT [Id_Kategori], [Nama_Kategori], [tarikh_daftar] FROM [Sou_Category] Order By [Id_Kategori] ASC"
                        DeleteCommand="DELETE FROM [Sou_Category] WHERE [Id_Kategori] = @Id_Kategori"
                        UpdateCommand="UPDATE [Sou_Category] SET [Nama_Kategori] = @Nama_Kategori WHERE [Id_Kategori] = @Id_Kategori">
                        <DeleteParameters>
                            <asp:Parameter Name="Id_Kategori" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Nama_Kategori" Type="String" />
                            <asp:Parameter Name="Id_Kategori" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </div>
            </form>
        </div>
    </div>
</body>
</html>