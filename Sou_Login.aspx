<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Login.aspx.cs" Inherits="eSouvenir.Sou_Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title> Kulim Technology Park Corporation</title>
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
</head>
<body translate="no">
    <form id="loginform" class="login" role="form" runat="server">
        <img src="images/KTPC_transparent.png" width="330" height="100" />
        <b>Sistem eSouviner KTPC</b><br />
        <br />
        <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="username" class="form-control"></asp:TextBox>
        </div>
        <br />
        <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-key"></i></span>
            <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="password" TextMode="Password"></asp:TextBox>
        </div>
        <br />
        Sila masukkan Username dan Password Anda.
        <div class="form-group">
            <asp:Button ID="btnLogin" runat="server" Text="LOG MASUK" class="btn float-right login_btn" OnClick="BtnLogin_Click" />
        </div>
        <asp:Label ID="Label3" runat="server" Text="Label" Visible="true"></asp:Label>
        <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label><br />
        <asp:Label ID="lblCount" runat="server" Visible="true"></asp:Label>
        <asp:Label ID="Label2" runat="server"></asp:Label>
        <asp:Label ID="Label4" runat="server"></asp:Label>
        <asp:Label ID="Label5" runat="server"></asp:Label>
    </form>
</body>
</html>
