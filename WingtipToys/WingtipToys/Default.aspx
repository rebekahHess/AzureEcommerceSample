﻿<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WingtipToys._Default" %>
<%@ Import Namespace="WingtipToys.Models" %>
<%@ Import Namespace="WingtipToys" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1><%: Title %>.</h1>
    <h2>Wingtip Toys can help you find the perfect gift.</h2>
    <p class="lead">We're all about transportation toys. You can order 
            any of our toys today. Each toy listing has detailed 
            information to help you choose the right toy.</p>

    <table id="recTable" style="width:75%;"></table>

    <!--Script references. -->
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-1.10.2.min.js" ></script>
    <!--Reference the SignalR library. -->

    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>

    <!--Reference the autogenerated SignalR hub script. -->

    <script src="signalr/hubs" type="text/javascript"></script>

    <!--Add script to update the page and send messages.--> 
    <script type="text/javascript">


        $(function () {
            // Declare a proxy to reference the hub.
            var recommend = $.connection.signalrHub;

            recommend.client.broadcastMessage = function () {
                getData();
            }

            $.connection.hub.start();
            getData();
        });

        function getData() {
            $.ajax({
                url: '/api/Product',
                type: 'GET',
                datatype: 'json',
                success: function (data) {
                    if (data.length > 0) {
                        $('#recTable').empty();
                        $('#recTable').append('<tr><td><b>Top Sellers</b></td></tr>');
                        var rows = [];
                        for (var i = 0; i < 3; i++) {
                            rows.push('<td><a href="/Product/' + data[i].ProductName + '"><img src=\'/Catalog/Images/Thumbs/' + data[i].ImageURL +
                                '\' width="100" height="75" border="1" /></a><br /><a href="/Product/' + data[i].ProductName + '">' + data[i].ProductName + '</a><br /><span><b>Price: </b>$' +
                                data[i].Price.toFixed(2) + '</span><br /><a href="/AddToCart.aspx?productID=' + data[i].ProductID + '"><span class="ProductListItem"><b>Add To Cart<b></span></a></td>');
                        }
                        $('#recTable').append(rows.join(''));
                    }
                }
            });
        }

    </script>

</asp:Content>
