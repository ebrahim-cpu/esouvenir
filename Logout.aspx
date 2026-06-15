<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="eSouvenir.Logout" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>eStationary Kulim Technology Park Corporation</title>
    <link
        rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
        crossorigin="anonymous" />
    <!--Fontawesome CDN-->
    <link
        rel="stylesheet"
        href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
        integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
        crossorigin="anonymous" />
    <link rel="stylesheet" type="text/css" href="/css/stylesElegant.css" />
    <link href="Css/Chief1.css" rel="stylesheet" />
    <script>
        window.console = window.console || function (t) { };
    </script>
    <script>
        if (document.location.search.match(/type=embed/gi)) {
            window.parent.postMessage("resize", "*");
        }
    </script>
    <style>
        body {
            background-image: url('Images/background-16.jpg');
        }
    </style>
    <script type="text/javascript">
        window.onload = function () {
            var randomIndex = Math.floor(Math.random() * 21) + 1; // generate random number between 1 and 22
            var imagePath = 'Images/background-' + randomIndex + '.jpg';
            document.body.style.backgroundImage = 'url(' + imagePath + ')';
        };
    </script>
</head>
<body translate="no">
    <form id="loginform" class="login" role="form" runat="server">
        <img src="images/KTPC_transparent.png" width="330" height="100" />
        <b>Apps eStationary KTPC</b><br />
        <br />
        <div class="input-group-prepend">
            You have logout.<br />
            Thank You.
            <br />
            <a href="Login.aspx">Return To App.</a>
        </div>
        <br />
    </form>
</body>
</html>
