<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Senarai_Item_User_FilterCheckboxjadi_20240214a.aspx.cs" Inherits="eSouvenir.Sou_Senarai_Item_User" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Background -->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <!-- Bootstrap CSS -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Add your custom styles here */
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #CD5C5C; color: #fff; width: 250px; background-image: url('/Images/A5.png'); background-size: cover; background-repeat: no-repeat;" id="mySidebar">
            <!-- Sidebar content here -->
        </div>
        <div id="main">
            <div class="w3-teal">
                <!-- Navbar content here -->
            </div>
            <div class="w3-container">
                <div>
                    <asp:CheckBox ID="chkIsInvestor" runat="server" Text="Is Investor" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:CheckBox ID="chkIsVisitor" runat="server" Text="Is Visitor" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:CheckBox ID="chkIsStudent" runat="server" Text="Is Student" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:CheckBox ID="chkIsStaffRetired" runat="server" Text="Is Staff Retired" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:CheckBox ID="chkIsStaffNoticed" runat="server" Text="Is Staff Noticed" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:CheckBox ID="chkIsVIP" runat="server" Text="Is VIP" AutoPostBack="true" OnCheckedChanged="FilterCheckBox_CheckedChanged" />
                    <asp:Button ID="btnApplyFilters" runat="server" Text="Apply Filters" OnClick="btnApplyFilters_Click" />
                </div>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Id_Item,Id_Kategori" DataSourceID="SqlDataSource2" AllowPaging="True" CssClass="table table-3d table-striped table-bordered" AllowSorting="True" PageSize="300" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
                    <Columns>
                        <asp:BoundField DataField="Id_Item" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id_Item" Visible="true" />
                        <asp:BoundField DataField="Nama_Item" HeaderText="Item" SortExpression="Nama_Item" />
                        <asp:TemplateField HeaderText="Item">
                            <ItemTemplate>
                                <asp:Button ID="btnImage" runat="server" Text="Image" CssClass="btn btn-success open-popup" CommandName="ImageClick" CommandArgument='<%# Eval("Id_Item") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Id_Kategori" HeaderText="ID Category" SortExpression="Id_Kategori" Visible="false" />
                        <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                        <asp:BoundField DataField="Spesifikasi" HeaderText="Specification" SortExpression="Spesifikasi" />
                        <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                        <asp:BoundField DataField="Stok_Minima" HeaderText="Min Stock" SortExpression="Stok_Minima" />
                        <asp:BoundField DataField="Jumlah_Stock" HeaderText="Available Stock" SortExpression="Jumlah_Stock" />
                        <asp:BoundField DataField="Isyarat_Stok" HeaderText="Status" SortExpression="Isyarat_Stok" />
                        <asp:TemplateField HeaderText="Is Investor">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsInvestorRow" runat="server" Checked='<%# Eval("IsInvestor") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Is Visitor">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsVisitorRow" runat="server" Checked='<%# Eval("IsVisitor") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Is Student">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsStudentRow" runat="server" Checked='<%# Eval("IsStudent") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Is Staff Retired">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsStaffRetiredRow" runat="server" Checked='<%# Eval("IsStaffRetired") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Is Staff Noticed">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsStaffNoticedRow" runat="server" Checked='<%# Eval("IsStaffNoticed") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Is VIP">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsVIPRow" runat="server" Checked='<%# Eval("IsVIP") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnAction" runat="server" Text="Request" OnClick="btnAction_Click" CssClass="btn btn-primary" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eSouvenirConnectionString %>" SelectCommand="SELECT [Id_Item], [Nama_Item], [Id_Kategori], [Kategori], [Spesifikasi], [Unit], [Stok_Minima], [Jumlah_Stock], [Isyarat_Stok], [IsInvestor], [IsVisitor], [IsStudent], [IsStaffRetired], [IsStaffNoticed], [IsVIP] FROM [Sou_StockItem]"></asp:SqlDataSource>
                 </div>
        </div>
    </form>
</body>
</html>