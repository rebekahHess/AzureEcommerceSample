<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WingtipToys._Default" %>
<%@ Import Namespace="WingtipToys.Models" %>
<%@ Import Namespace="WingtipToys" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1><%: Title %>.</h1>
    <h2>Wingtip Toys can help you find the perfect gift.</h2>
    <p class="lead">We're all about transportation toys. You can order 
            any of our toys today. Each toy listing has detailed 
            information to help you choose the right toy.</p>
    <hr />
    <div>
        <h3>Top Sellers</h3>
    </div>
    <table id="recTable" style="width:100%;"></table>
    <!--Script references. -->
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: '/api/Product',
                type: 'GET',
                datatype: 'json',
                success: function (data) {
                    if (data.length > 0) {
                        var rows = [];
                        for (var i = 0; i < data.length; i++) {
                            rows.push('<td><a href="/Product/' + data[i].ProductName + '"><img src=\'' + data[i].ImageURL +
                                '\' width="100" height="75" border="1" /></a><br /><a href="/Product/' + data[i].ProductName + '">' + data[i].ProductName +
                                '</a><br /><span><b>Price: </b>$' + data[i].Price.toFixed(2) + '</span><br /><a href="/AddToCart.aspx?productID=' +
                                data[i].ProductID + '"><span class="ProductListItem"><b>Add To Cart<b></span></a></td>');
                        }
                        $('#recTable').append(rows.join(''));
                    }
                }
            });
        })
    </script>
</asp:Content>
