<%@ Page Title="Welcome" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WingtipToys._Default" %>
<%@ Import Namespace="WingtipToys.Models" %>
<%@ Import Namespace="WingtipToys" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <hr />
    <div>
        <h3>Top Sellers</h3>
    </div>
    <table id="topSellerTable" style="width:100%;"></table>

    <hr />
    <div style="float:left; width: 37%;">    
        <h3>Recommended for you in Computers</h3>
    </div>
    <div style="float:right; padding-top:25px; width:63%">
        <a href="/Category/Computers"><b>See more</b></a>
    </div>
    <div style="clear: both;"></div>
    <table id="compTable" style="width:100%;"></table>

    <hr />
    <div style="float:left; width: 45%;">   
        <h3>Recommended for you in Computer Software</h3>
    </div>
    <div style="float:right; padding-top:25px; width:55%">
        <a href="/Category/Computer%20Software"><b>See more</b></a>
    </div>
    <div style="clear: both;"></div>
    <table id="softwareTable" style="width:100%;"></table>

    <hr />
    <div style="float:left; width: 38%;">  
        <h3>Recommended for you in Appliances</h3>
        </div>
    <div style="float:right; padding-top:25px; width:62%">
        <a href="/Category/Appliances"><b>See more</b></a>
    </div>
    <div style="clear: both;"></div>
    <table id="applianceTable" style="width:100%;"></table>

    <hr />
    <div style="float:left; width: 34%;">  
        <h3>Recommended for you in Video</h3>
    </div>
    <div style="float:right; padding-top:25px; width:66%">
        <a href="/Category/Video"><b>See more</b></a>
    </div>
    <div style="clear: both;"></div>
    <table id="videoTable" style="width:100%;"></table>
    <!--Script references. -->
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: '/api/Product',
                type: 'GET',
                datatype: 'json',
                success: function (data) {
                    displayData(data, 'topSellerTable');
                }
            });
        })

        function displayCategory(categoryNum, table) {
            $.ajax({
                url: '/api/Product',
                type: 'GET',
                data: { category: categoryNum },
                datatype: 'json',
                success: function (data) {
                    displayData(data, table);
                }
            });
        }

        function displayData(data, table) {
            if (data.length > 0) {
                var rows = [];
                for (var i = 0; i < data.length; i++) {
                    rows.push('<td width=20%><a href="/Product/' + data[i].ProductID + '"><img src=\'' + data[i].ImageURL +
                        '\' width="120" height="120" border="1" /></a><br /><a href="/Product/' + data[i].ProductID + '">' + data[i].ProductName +
                        '</a><br /><span><b>Price: </b>$' + data[i].Price.toFixed(2) + '</span><br /><a href="/AddToCart.aspx?productID=' +
                        data[i].ProductID + '"><span class="ProductListItem"><b>Add To Cart<b></span></a></td>');
                }
                $('#' + table).append(rows.join(''));
            }
        }

        displayCategory(6, 'compTable');
        displayCategory(13, 'softwareTable');
        displayCategory(4, 'applianceTable');
        displayCategory(2, 'videoTable');
    </script>
</asp:Content>
