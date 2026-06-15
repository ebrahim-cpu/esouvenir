<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Admin_Editing_All_20240229.aspx.cs" Inherits="eSouvenir.Sou_Admin_Editing_All" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--Background--%>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <%--Background--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="lightbox/lightbox.css" rel="stylesheet" />
    <style>
        .photo-container {
            display: inline-block;
            width: 150px;
            margin: 10px;
            text-align: center;
        }

        .photo-img {
            max-width: 150px; /* Set the maximum width as needed */
            max-height: 150px; /* Set the maximum height as needed */
            width: auto;
            height: auto;
        }
    </style>
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
                border-radius: 5px; /* Add rounded corners */
            }

        .auto-style2 {
            display: block;
            width: 100%;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            background-clip: padding-box;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            border-radius: .375rem;
            transition: none;
            border: 1px solid #ced4da;
            background-color: #fff;
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
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/buffalumps_smoke_and_mirrors.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>

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
                        <h1>Editing Item </h1>
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
                            <label for="lblTarikhItem" associatedcontrolid="txtTarikhItem"><b><span style="color: deepskyblue;" />1. Date</b></label>
                            <asp:TextBox ID="txtTarikh" type="date" runat="server" Width="400px" CssClass="form-control" TextMode="Date" Style="border-color: black; border-width: 1px;"></asp:TextBox>

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
                            <label for="lblKategori"><b><span style="color: deepskyblue;" />2. Category</b> </label>
                            <div class="a">
                                <asp:TextBox ID="txtKategori" runat="server" CssClass="form-control " Width="400px" ReadOnly="true" Style="border-color: black; border-width: 1px;"></asp:TextBox>

                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lblIdKategori"><b><span style="color: deepskyblue;" />3. Id Category </b></label>
                            <asp:TextBox ID="txtIdKategori" runat="server" CssClass="form-control " Width="400px" ReadOnly="true" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblItem"><b><span style="color: deepskyblue;" />4. Item</b>  </label>
                            <asp:TextBox ID="txtItemBaru" CssClass="form-control" Width="400px" runat="server" placeholder="Register the New Item" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblIdItem"><b><span style="color: deepskyblue;" />4.  Id Item </b></label>
                            <asp:TextBox ID="txtIdItem" runat="server" ReadOnly="true" CssClass="form-control" Width="400px" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblSpesifikasi"><b><span style="color: deepskyblue;" />5. Specification</b> </label>
                            <asp:TextBox ID="txtSpesifikasi" CssClass="form-control" Width="400px" TextMode="MultiLine" Rows="3" runat="server" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <div class="col-5">
                        <div class="form-group">
                            <label for="lblKuantiti"><b><span style="color: deepskyblue;" />6. Quantity</b> </label>
                            <asp:TextBox ID="txtJumlahStock" CssClass="form-control" Width="400px" placeholder="Please insert the amount" runat="server" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblUnit"><b><span style="color: deepskyblue;" />7. Unit</b>  </label>
                            <asp:TextBox ID="txtUnit" CssClass="form-control" Width="400px" runat="server" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                            <asp:Label ID="Label1" runat="server" Text="<b>( Eg: Rim , Set , Kotak , Batang , Unit & Helai )</b>" Style="color: blue;"></asp:Label>
                        </div>
                        <br />
                        <div class="form-group">
                            <label for="lblStokMinima"><b><span style="color: deepskyblue;" />8. Min Stock</b>  </label>
                            <asp:TextBox ID="txtStokMinima" CssClass="form-control" Width="400px" placeholder="Please enter the amount" runat="server" Style="border-color: black; border-width: 1px;"></asp:TextBox>
                        </div>
                        <br />
                        <div class="form-group">
                                <label for="chkListOptions"><b><span style="color: deepskyblue;" />9. Package</b>  </label>
                                <asp:CheckBoxList ID="chkListOptions" runat="server" CssClass="form-control"  AutoPostBack="true">
                                    <asp:ListItem Text=" Investor" Value="IsInvestor" />
                                    <asp:ListItem Text=" Visitor" Value="IsVisitor" />
                                    <asp:ListItem Text=" Student" Value="IsStudent" />
                                    <asp:ListItem Text=" Staff (Retired)" Value="IsStaffRetired" />
                                    <asp:ListItem Text=" Staff (Noticed)" Value="IsStaffNoticed" />
                                    <asp:ListItem Text=" VIP" Value="IsVIP" />
                                </asp:CheckBoxList>
                            </div>
                            <br />  
                        <label for="lblStokMinima"><b><span style="color: deepskyblue;" />10. Image (Please DELETE first before Add image  </b></label>
                        <div class="photo-grid">
                            <asp:Repeater ID="repeaterPhotos" runat="server">
                                <ItemTemplate>
                                    <div class="photo-container">
                                        <a href='<%# "data:" + Eval("ContentType") + ";base64," + Convert.ToBase64String((byte[])Eval("FileData")) %>' data-lightbox="photos">
                                            <img class="photo-img" src='<%# "data:" + Eval("ContentType") + ";base64," + Convert.ToBase64String((byte[])Eval("FileData")) %>' alt="Uploaded Photo" />
                                        </a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:FileUpload ID="PhotoUpload1" runat="server" multiple="multiple" />
                            <div id="selectedFileContainer"></div>
                            <div id="selectedImagesContainer" style="display: flex; flex-wrap: wrap;"></div>
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
                            <script src="lightbox/lightbox-plus-jquery.js"></script>
                            <asp:Label ID="lblMessage" runat="server" Text="."></asp:Label>
                        </div>
                        <div class="form-group">
                            <div id="imageContainer" runat="server"></div>
                        </div>
                        <br />
                        <div class="text-right">
                            <asp:Button ID="btnUpdateItem" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdateIte_Click" Width="140px" Style="height: 45px" />
                            <br />
                        </div>
                    </div>
                </div>
                <br />
            </form>
        </div>
    </div>
</body>
</html>
