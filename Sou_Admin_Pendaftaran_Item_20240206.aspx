<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_Pendaftaran_Item_20240206.aspx.cs" Inherits="eSouvenir.Sou_Admin_Pendaftaran_Item" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eStationary</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <%--Background--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <%--Background--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url('Images/grey11.jpg');
            background-repeat: no-repeat;
            justify-content: center;
            background-size: 1500px 600px;
            background-attachment: fixed;
            background-position: center center; /* Add this line to center the background image */
        }
        /* Custom CSS to resize the w3-container */
        .w3-container {
            height: 1px; /* Set the desired height */
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

        .delete-button {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .image-container {
            display: inline-block;
            margin: 10px;
            text-align: center;
        }

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
                border-radius: 5px; /* Add rounded corners *
            }
    </style>
    <%--SEMUA BACKGROUND--%>
    <%-- script sidebar --%>
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

        document.getElementById('<%= PhotoUpload1.ClientID %>').addEventListener('change', function () {
            var selectedFiles = this.files;
            var selectedImagesContainer = document.getElementById('selectedImagesContainer');
            selectedImagesContainer.innerHTML = '';

            for (var i = 0; i < selectedFiles.length; i++) {
                var fileName = selectedFiles[i].name;

                var imgContainer = document.createElement('div');
                imgContainer.className = 'image-container';

                var img = document.createElement('img');
                img.src = URL.createObjectURL(selectedFiles[i]);
                img.alt = 'Selected Image';
                img.style.maxWidth = '150px';
                img.style.margin = '10px';

                var deleteButton = document.createElement('button');
                deleteButton.textContent = 'Delete';
                deleteButton.className = 'delete-button';
                deleteButton.addEventListener('click', function () {
                    imgContainer.remove(); // Remove the whole container when delete button is clicked
                });

                imgContainer.appendChild(img);
                imgContainer.appendChild(deleteButton);
                selectedImagesContainer.appendChild(imgContainer);
            }
        });
    </script>
</head>
<body>
    <%--sidebar editor--%>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px; background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
        <img src="path_to_your_image.jpg" alt="" style="width: 100%; max-height: 200px;" />
        <a href="Sou_Kelulusan_Souvenir.aspx" class="w3-bar-item w3-button">1. User Request List </a>
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
                        <h1>C. New Item Registration
                            <img src="/Images/new.png" width="50" height="50" /></h1>
                    </div>
                </div>
            </div>
        </div>
        <%--  Content--%>
        <div class="w3-container">
            <form id="form1" runat="server" method="post" enctype="multipart/form-data">
                <br />
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-5">
                        <div class="form-group">
                            <label for="lblTarikhItem" associatedcontrolid="txtTarikhItem"><b>1. Date</b></label>
                            <asp:TextBox ID="txtTarikh" type="date" runat="server" Width="400px" CssClass="form-control" TextMode="Date" OnTextChanged="txtTarikh_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
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
                                document.getElementById('<%= txtTarikh.ClientID %>').value = formattedDate;
                            </script>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblDdlKategori"><b>2. Category</b> </label>
                            <div class="a">
                                <asp:DropDownList ID="ddlKategori" runat="server" Width="400px" OnSelectedIndexChanged="ddlKategori_SelectedIndexChanged1" CssClass="form-control " AutoPostBack="true" Style="border-color: black; border-width: 1px;"></asp:DropDownList>
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lblIdKategori"><b>3. Id Category </b></label>
                            <asp:TextBox ID="txtIdKategori" runat="server" CssClass="form-control " Width="400px" OnTextChanged="txtIdKategori_TextChanged" ReadOnly="true" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblItem"><b>4. Item</b>  </label>
                            <asp:TextBox ID="txtItemBaru" CssClass="form-control" Width="400px" runat="server" placeholder="Register the New Item" OnTextChanged="txtItemBaru_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblSpesifikasi"><b>5. Specification</b> </label>
                            <asp:TextBox ID="txtSpesifikasi" CssClass="form-control" Width="400px" TextMode="MultiLine" Rows="3" runat="server" OnTextChanged="txtSpesifikasi_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <div class="col-5">
                        <div class="form-group">
                            <label for="lblKuantiti"><b>6. Quantity</b> </label>
                            <asp:TextBox ID="txtJumlahStock" CssClass="form-control" Width="400px" placeholder="Please insert the amount" runat="server" OnTextChanged="txtJumlahStock_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblUnit"><b>7. Unit</b>  </label>
                            <asp:TextBox ID="txtUnit" CssClass="form-control" Width="400px" runat="server" OnTextChanged="txtUnit_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            <asp:Label ID="Label1" runat="server" Text="<b>( Eg: Rim , Set , Kotak , Batang , Unit & Helai )</b>" Style="color: blue;"></asp:Label>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="txtStokMinima"><b>8. Min Stock</b>  </label>
                            <asp:TextBox ID="txtStokMinima" CssClass="form-control" Width="400px" placeholder="Please enter the amount" runat="server" OnTextChanged="txtStokMinima_TextChanged" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <asp:FileUpload ID="PhotoUpload1" runat="server" multiple="multiple" />
                            <div id="selectedFileContainer"></div>
                            <div id="selectedImagesContainer" style="display: flex; flex-wrap: wrap;">
                            </div>
                            <script>
                                document.getElementById('<%= PhotoUpload1.ClientID %>').addEventListener('change', function () {
                                    var selectedFiles = this.files;
                                    var selectedFileContainer = document.getElementById('selectedFileContainer');
                                    selectedFileContainer.innerHTML = 'Selected Files:';

                                    var selectedImagesContainer = document.getElementById('selectedImagesContainer');
                                    selectedImagesContainer.innerHTML = '';

                                    for (var i = 0; i < selectedFiles.length; i++) {
                                        var fileName = selectedFiles[i].name;
                                        selectedFileContainer.innerHTML += ' ' + fileName;

                                        var imgContainer = document.createElement('div');
                                        imgContainer.className = 'image-container';

                                        var img = document.createElement('img');
                                        img.src = URL.createObjectURL(selectedFiles[i]);
                                        img.alt = 'Selected Image';
                                        img.style.maxWidth = '150px';
                                        img.style.margin = '10px';

                                        var deleteButton = document.createElement('button');
                                        deleteButton.textContent = 'Delete';
                                        deleteButton.className = 'delete-button';
                                        deleteButton.addEventListener('click', function () {
                                            // Get the parent container of the delete button (the image container)
                                            var parentContainer = this.parentNode;
                                            parentContainer.remove(); // Remove the image container when delete button is clicked
                                        });

                                        imgContainer.appendChild(img);
                                        imgContainer.appendChild(deleteButton);
                                        selectedImagesContainer.appendChild(imgContainer);
                                    }
                                });
                            </script>
                            <asp:Label ID="lblMessage" runat="server" Text="."></asp:Label>
                        </div>
                        <div class="form-group">
                            <div id="imageContainer" runat="server"></div>
                        </div>
                        <br />
                        <div class="text-right">
                            <asp:Button ID="btnDaftarItem" runat="server" CssClass="btn btn-primary" Text="Register" OnClick="btnDaftarItem_Click" Width="140px" Style="height: 45px" /><br />
                        </div>
                    </div>
                </div>
                <br />
                <hr class="rounded" />
                <div class="h4 pb-2 mb-4 text-danger border-bottom border-danger">
                    <h1 style="color: black;">&nbsp;&nbsp;&nbsp;Item Editor</h1>
                </div>
                <div class="container">
                    <div class="col-md-12">
                        <!-- Search Textbox -->
                        <div class="search-container">
                            <input type="text" id="txtSearch" class="form-control" placeholder="Search Here" onkeyup="searchGridView()" />
                        </div>
                    </div>
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" DataKeyNames="Id_Item" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True" AllowSorting="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" PageSize="200" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id_Kategori" HeaderText="Id" ReadOnly="True" SortExpression="Id_Kategori" Visible="true" />
                        <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" ReadOnly="true" />
                        <asp:BoundField DataField="Id_Item" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id_Item" Visible="false" />
                        <asp:TemplateField HeaderText="Item" SortExpression="Item">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNamaItemEdit" runat="server" Text='<%# Bind("Nama_Item") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblNamaItem" runat="server" Text='<%# Bind("Nama_Item") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Specification" SortExpression="Spesifikasi">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSpesifikasiEdit" runat="server" Text='<%# Bind("Spesifikasi") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSpesifikasi" runat="server" Text='<%# Bind("Spesifikasi") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit" SortExpression="Unit">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitEdit" runat="server" Text='<%# Bind("Unit") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblUnit" runat="server" Text='<%# Bind("Unit") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" SortExpression="Jumlah_Stock">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtJumlahStockEdit" runat="server" Text='<%# Bind("Jumlah_Stock") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblJumlahStock" runat="server" Text='<%# Bind("Jumlah_Stock") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Min Stock" SortExpression="Stok_Minima">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStokMinimaEdit" runat="server" Text='<%# Bind("Stok_Minima") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStokMinima" runat="server" Text='<%# Bind("Stok_Minima") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" SortExpression="Isyarat_Stok">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtIsyaratStokEdit" runat="server" ReadOnly="true" Text='<%# Bind("Isyarat_Stok") %>' CssClass="gridview-textbox"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblIsyaratStok" runat="server" Text='<%# Bind("Isyarat_Stok") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CreatedDate" HeaderText="Register Date" SortExpression="CreatedDate" Visible="false" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnCustomize" runat="server" CssClass="btn btn-primary" Text="Edit" OnClick="btnCustomize_Click" CommandArgument='<%# Eval("Id_Kategori") + "," + Eval("Kategori") + "," + Eval("Id_Item") + "," + Eval("Nama_Item") + "," + Eval("Spesifikasi") + "," + Eval("Unit") + "," + Eval("Jumlah_Stock") + "," + Eval("Stok_Minima") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                                    OnClientClick="return confirmDelete();"
                                    Text="Delete" CssClass="btn btn-danger" />
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
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString%>"
                    SelectCommand="SELECT TOP (1000) [Id_Item], [Guid], [Kategori], [Nama_Item], [Spesifikasi], [Jumlah_Stock], [Unit], [Isyarat_Stok], [Stok_Minima], [Tarikh_Pendaftaran_Item], [ModifiedDate], [Id_Kategori] FROM [Sou_StockItem] ORDER BY [Id_Item] DESC"
                    UpdateCommand="UPDATE [Sou_StockItem] SET [Nama_Item] = @NamaItem, [Spesifikasi] = @Spesifikasi,[Jumlah_Stock] = @JumlahStock, [Unit] = @Unit, [Isyarat_Stok] = @IsyaratStok, [Stok_Minima] = @StokMinima, [Tarikh_Pendaftaran_Item] = @TarikhPendaftaranItem, [ModifiedDate] = GETDATE(), [Id_Kategori] = @IdKategori, [ModifiedBy] = @ModifiedBy WHERE [Id_Item] = @IdItem"
                    DeleteCommand="DELETE FROM [Sou_StockItem] WHERE [Id_Item] = @IdItem">
                    <UpdateParameters>
                        <asp:Parameter Name="NamaItem" Type="String" />
                        <asp:Parameter Name="Spesifikasi" Type="String" />
                        <asp:Parameter Name="Unit" Type="String" />
                        <asp:Parameter Name="JumlahStock" Type="String" />
                        <asp:Parameter Name="StokMinima" Type="String" />
                        <asp:Parameter Name="IsyaratStok" Type="String" />
                        <asp:Parameter Name="TarikhPendaftaranItem" Type="String" />
                        <asp:Parameter Name="IdKategori" Type="String" />
                        <asp:Parameter Name="IdItem" Type="String" />
                        <asp:Parameter Name="ModifiedBy" Type="String" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="IdItem" Type="String" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <script type="text/javascript">
                    function confirmDelete() {
                        return confirm("Are you sure you want to delete this item?");
                    }
                </script>
            </form>
        </div>
    </div>
</body>
</html>