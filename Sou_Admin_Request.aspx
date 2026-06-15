<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_Request.aspx.cs" Inherits="eSouvenir.Sou_Admin_Request" %>

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

        .grid-header {
            color: white;
        }

        .arrow {
            border: solid black;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
        }

        .down {
            transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
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
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/buffalumps_swirling_citadel_ninja_fortress_with_redwoods.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
        <%-- <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />--%>
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
                        <h1>
                        5. Admin Request Stationary                   
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--  Content--%>
         <<div class="w3-container">
             <form id="form2" runat="server" method="post" enctype="multipart/form-data">
                 <div class="container">
                     <%-- Background 1 atas --%>
                     <div class="row">
                         <div class="col-1"></div>
                         <div class="col-6">
                             <div class="form-group">
                                 <label for="txtTarikhPermohonan" associatedcontrolid="txtTarikhPermohonan" style="font-size: 18px;"><b><span style="color: deepskyblue;" />1. Date</b> </label>
                                 <asp:TextBox ID="txtTarikhPermohonan" type="date" runat="server" CssClass="form-control" TextMode="Date" Width="442px"></asp:TextBox>
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
                                     document.getElementById('<%=txtTarikhPermohonan.ClientID %>').value = formattedDate;
                                 </script>
                             </div>
                             <div class="form-group">
                                 <label for="txtidPengguna"><b></b></label>
                                 <asp:TextBox ID="txtId" CssClass="form-control" Width="438px" runat="server" Visible="false"></asp:TextBox>
                             </div>
                             <div class="form-group">
                                 <label for="txtNamaPengguna" style="font-size: 18px;"><b><span style="color: deepskyblue;" />2. Requestor </b></label>
                                 <br />
                                 <asp:TextBox ID="txtNamaPengguna" CssClass="form-control" Width="438px" ReadOnly="true" runat="server"></asp:TextBox>
                             </div>
                             <br />
                             <div class="form-group">
                                 <label for="ddlKategori" style="font-size: 18px;"><b><span style="color: deepskyblue;" />3. Items Category</b> </label>
                                 <div class="auto-style4">
                                     <asp:DropDownList ID="ddlKategori" runat="server" OnSelectedIndexChanged="DdlKategori_SelectedIndexChanged1" CssClass="form-control " Width="438px" AutoPostBack="true"></asp:DropDownList>
                                 </div>
                             </div>
                             <div class="form-group" style="display: none;">
                                 <label for="txtIdKategori" style="font-size: 18px;"><b><span style="color: deepskyblue;" />4. Id Kategori</b>  </label>
                                 <asp:TextBox ID="txtIdKategori" runat="server" CssClass="form-control " ReadOnly="true" AutoPostBack="true" Width="438px"></asp:TextBox>
                             </div>
                             <br />
                             <div class="form-group">
                                 <label for="DropDownList2" style="font-size: 18px;"><b><span style="color: deepskyblue;" />4. Item</b> </label>
                                 <div class="auto-style4">
                                     <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged1" CssClass="form-control " Width="438px" AutoPostBack="true" Height="40px"></asp:DropDownList>
                                 </div>
                             </div>
                             <br />
                             <div class="form-group">
                                 <label for="lblSpecification" style="font-size: 18px;"><b><span style="color: deepskyblue;" />5. Items Specification</b> </label>
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
                                 <label for="lblUnit" style="font-size: 18px;"><b><span style="color: deepskyblue;" />6. Unit Measurement</b> </label>
                                 <asp:TextBox ID="txtUnit" CssClass="form-control" ReadOnly="true" runat="server" Width="438px"></asp:TextBox>
                             </div>
                             <br />
                             <div class="form-group">
                                 <label for="txtKuantiti" style="font-size: 18px;"><b><span style="color: deepskyblue;" />7. Items Quantity ( Available Stock )</b> </label>
                                 <asp:TextBox ID="txtKuantiti" CssClass="form-control" Width="438px" ReadOnly="true" runat="server"></asp:TextBox>
                             </div>
                             <br />
                             <div class="form-group">
                                 <label for="txtBilKuantitiYgDimahukan" style="font-size: 18px;"><b><span style="color: deepskyblue;" />8. Items Quantity Request</b> </label>
                                 <asp:TextBox ID="txtBilKuantitiYgDimahukan" CssClass="form-control" placeholder="Enter the desired amount" Style="width: 438px;" runat="server" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                 <script>
                                     function isNumberKey(evt) {
                                         var charCode = (evt.which) ? evt.which : event.keyCode;
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
                             <br />
                             <asp:HiddenField ID="hdnStatus" runat="server" OnValueChanged="hdnStatus_ValueChanged" />
                         </div>
                     </div>
                     <div class="text-center">
                         <asp:Button ID="btnHantar" runat="server" Text="Send" OnClick="BtnHantar_Click" CssClass="btn btn-primary " Height="38px" Width="170px" />
                         <a class="auto-style4">
                             <img id="scrollDownImage" src="/Images/down.png" alt="Scroll Down" width="50" height="50" />
                         </a>
                         <asp:Label ID="lblErrorMesage" runat="server" Style="color: white;" Visible="false"></asp:Label>
                     </div>
                     <%--Start Part gridview--%>
                     <hr class="rounded" />
                     <div class="h4 pb-2 mb-4 text-danger border-bottom border-danger">
                     </div>
                     <div class="w3-container">
                         <div class="c" style="text-align: center;">
                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" ReadOnly="true" Text="Admin Order Status" Style="color: white; background-color: transparent; font-size: 40px; border: none; display: inline;" Width="388px"></asp:TextBox>
                         </div>
                     </div>
                     <br />
                     <br />
                     <br />
                     <div class="container d-flex justify-content-center">
                         <%-- Added d-flex and justify-content-center classes --%>
                         <div class="row">
                             <div class="col-md-12">
                                 <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" OnRowCommand="GridView2_RowCommand" CssClass="table table-3d table-striped table-bordered" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                                     <FooterStyle BackColor="Tan" />
                                     <HeaderStyle CssClass="thead-dark" BackColor="Tan" Font-Bold="True" />
                                     <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                     <Columns>
                                         <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                         <asp:BoundField DataField="Id_Pengguna" HeaderText="Id_Pengguna" SortExpression="Id_Pengguna" Visible="false" />
                                         <asp:BoundField DataField="Pemohon" HeaderText="User" SortExpression="Pemohon" />
                                         <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                                         <asp:BoundField DataField="Id_Item" HeaderText="Id_Item" SortExpression="Id_Item" Visible="false" />
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
                                                 <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                             </ItemTemplate>
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Action">
                                             <ItemTemplate>
                                                 <asp:Button ID="CancelButton" runat="server" CssClass="btn btn-primary"
                                                     Text="Cancel Request" CommandName="CancelRequest" CommandArgument='<%# Container.DataItemIndex %>'
                                                     OnClientClick="return showConfirmationDialog();" />
                                                 <asp:Label ID="PemohonLabel" runat="server" Text='<%# Eval("Pemohon") %>' Visible="false"></asp:Label>
                                             </ItemTemplate>
                                         </asp:TemplateField>
                                     </Columns>
                                     <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                     <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                     <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                     <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                     <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                     <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                                 </asp:GridView>
                             </div>
                         </div>
                     </div>
                     <br />
                     <br />
                     <br />
                     <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>"
                         SelectCommand="SELECT [Id], [Id_Pengguna], [Pemohon], [Kategori], [Id_Item], [Nama_Item], [Description], [Previous_Stock], [Quantity_Request], [Jumlah_Stock], [CreatedDate], [ModifiedDate], [Status]
                    FROM [Sou_UserRequest]
                    WHERE [Pemohon] = @PemohonName
                    ORDER BY [Id] DESC">
                         <SelectParameters>
                             <asp:Parameter Name="PemohonName" Type="String" />
                         </SelectParameters>
                     </asp:SqlDataSource>
                     <script type="text/javascript">
                         function showConfirmationDialog() {
                             return confirm("Are you sure you want to cancel this request?");
                         }
                         // Function to scroll the page down when the image is clicked
                         function scrollPageDown() {
                             // You can adjust the value (e.g., 500) to control how much the page scrolls down.
                             window.scrollBy(0, 500); // Scroll down by 500 pixels
                         }
                         // Attach the click event handler to the image
                         document.getElementById("scrollDownImage").addEventListener("click", scrollPageDown);
                     </script>
                 </div>
                 <br />
                 <br />
                 <br />
             </form>
         </div>
</body>
</html>
