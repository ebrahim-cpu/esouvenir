<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sou_Report_User.aspx.cs" Inherits="eSouvenir.Sou_Report_User" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eSouvenir User Reports</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background-image: url('Images_Black/Default_A_wall_paper_consist_of_collages_of_stationary_items_0(1).jpg');
            background-repeat: repeat;
            background-size: 1500px 600px;
            background-attachment: fixed;
            background-position: center center;
            color: #fff;
        }
        .w3-container {
            height: 2px;
        }
        h1 {
            text-align: center;
            font-weight: 700;
            margin: 0;
            font-size: 2.2rem;
            color: #fff;
        }
        .navbar-nav {
            margin-left: auto;
            padding-right: 10px;
            display: flex;
            align-items: center;
        }
        .auto-style1 {
            display: block;
            color: #fff;
            text-decoration: none;
            transition: none;
            height: 25px;
        }
        .nav-item img {
            width: 50px;
            height: 50px;
            margin-left: 5px;
        }
        /* Glassmorphism Panel */
        .glass-card {
            background: rgba(30, 30, 45, 0.75);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            margin-top: 30px;
            animation: fadeIn 0.8s ease-in-out;
        }
        .thick-border {
            border: 2px solid rgba(255, 255, 255, 0.2);
            background-color: rgba(20, 20, 30, 0.8);
            color: #fff;
            border-radius: 8px;
            padding: 5px 12px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s;
        }
        .thick-border:focus {
            border-color: #ffeb3b;
            background-color: rgba(20, 20, 30, 0.95);
            color: #fff;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
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
    </script>
</head>
<body>
    <div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display: none; background-color: #a90505; color: #fff; width: 250px; background-image: url('./Images_Black/Default_A_wall_paper_consist_of_collages_of_stationary_items_0(1).jpg'); background-size: cover; background-repeat: repeat;" id="mySidebar">
        <button class="w3-bar-item w3-button w3-large" onclick="w3_close()">&times;</button>
        <a href="Sou_Senarai_Item_User.aspx" class="w3-bar-item w3-button">1. List Item </a>
        <a href="Sou_Keputusan_Permohonan_User.aspx" class="w3-bar-item w3-button">2. Order Status</a>
        <a href="Sou_Report_User.aspx" class="w3-bar-item w3-button" style="background-color: rgba(255,255,255,0.1); border-left: 4px solid #00bcd4;">3. Reports</a>

        <div style="margin-top: 30px;">
            <p style="font-size: 16px; font-weight: bold; color: deepskyblue; padding-left: 15px;">
                <asp:Literal ID="welcomeMessage" runat="server"></asp:Literal>
            </p>
        </div>
    </div>

    <div id="main">
        <div class="w3-teal">
            <nav class="navbar navbar-expand-lg navbar-inverse" style="background-color: #696969;">
                <div class="navbar-nav ml-auto">
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
                </div>
            </nav>
            <div style="background-color: #696969; padding: 15px 0;">
                <div class="row align-items-center">
                    <div class="col-1">
                        <button id="openNav" class="w3-button w3-teal w3-xlarge" onclick="w3_open()">&#9776;</button>
                    </div>
                    <div class="col-10">
                        <h1>My Reports <img src="./Images/stock.png" width="45" height="45" /></h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <form id="form1" runat="server">
                <div class="glass-card">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-6">
                            <h3 style="font-weight: 600; margin: 0; color: #ffeb3b;">My Monthly Requested Souvenirs Quantity</h3>
                        </div>
                        <div class="col-md-6 text-md-right mt-3 mt-md-0">
                            <span style="font-size: 1.1rem; margin-right: 10px;">Select Year:</span>
                            <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged" CssClass="thick-border">
                            </asp:DropDownList>
                        </div>
                    </div>
                    
                    <div style="position: relative; height: 350px; width: 100%;">
                        <canvas id="monthlyChart"></canvas>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById('monthlyChart').getContext('2d');
            
            var gradient = ctx.createLinearGradient(0, 0, 0, 350);
            gradient.addColorStop(0, 'rgba(255, 235, 59, 0.95)'); // Yellow
            gradient.addColorStop(1, 'rgba(255, 152, 0, 0.35)');  // Orange-Yellow

            var hoverGradient = ctx.createLinearGradient(0, 0, 0, 350);
            hoverGradient.addColorStop(0, 'rgba(255, 255, 0, 1)');    // Vivid Yellow
            hoverGradient.addColorStop(1, 'rgba(255, 193, 7, 0.6)');   // Amber

            var labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            
            var chartData = <%= GetChartDataJson() %>;

            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Quantity Requested By Me',
                        data: chartData,
                        backgroundColor: gradient,
                        hoverBackgroundColor: hoverGradient,
                        borderColor: '#ffeb3b',
                        borderWidth: 1,
                        borderRadius: 6,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true,
                            labels: {
                                color: '#fff',
                                font: {
                                    family: "'Outfit', sans-serif",
                                    size: 14
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(20, 20, 30, 0.95)',
                            titleFont: { family: "'Outfit', sans-serif", size: 14, weight: 'bold' },
                            bodyFont: { family: "'Outfit', sans-serif", size: 13 },
                            borderColor: 'rgba(255,255,255,0.1)',
                            borderWidth: 1,
                            cornerRadius: 8
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#aaa',
                                font: {
                                    family: "'Outfit', sans-serif",
                                    size: 12
                                }
                            }
                        },
                        y: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.08)'
                            },
                            ticks: {
                                color: '#aaa',
                                font: {
                                    family: "'Outfit', sans-serif",
                                    size: 12
                                }
                            },
                            beginAtZero: true
                        }
                    }
                },
                plugins: [{
                    id: 'barLabels',
                    afterDatasetsDraw(chart, args, options) {
                        const { ctx, data } = chart;
                        ctx.save();
                        ctx.font = "bold 12px 'Outfit', sans-serif";
                        ctx.fillStyle = "#ffeb3b";
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'bottom';

                        chart.data.datasets.forEach((dataset, i) => {
                            chart.getDatasetMeta(i).data.forEach((bar, index) => {
                                const value = dataset.data[index];
                                if (value > 0) {
                                    ctx.fillText(value, bar.x, bar.y - 5);
                                }
                            });
                        });
                        ctx.restore();
                    }
                }]
            });
        });
    </script>
</body>
</html>
