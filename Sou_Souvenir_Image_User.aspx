<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Souvenir_Image_User.aspx.cs" Inherits="eSouvenir.Sou_Souvenir_Image_User" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir: Gambar Item</title>
    <style>
        /* CSS class for centering images */
        .center-image {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-group">
            <!-- "Back" button placed inside the container -->
            <button id="backButton" type="button" class="btn btn-primary" onclick="goToSenaraiItemAdminRequest()" style="width: 100px; height: 50px;">Back</button>
            <br />
            <br />
            <br />
            <br />
            <div id="imageContainer" runat="server">
                <!-- Your content here -->
            </div>
        </div>
    </form>
    <script>
        function goToSenaraiItemAdminRequest() {
            window.location.href = 'Sou_Senarai_Item_User.aspx';
        }
    </script>
</body>
</html>