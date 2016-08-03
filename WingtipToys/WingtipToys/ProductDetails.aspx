<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="ProductDetails.aspx.cs" Inherits="WingtipToys.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="productDetail" runat="server" ItemType="WingtipToys.Models.Product" SelectMethod ="GetProduct" RenderOuterTable="false">
        <ItemTemplate>
            <div>
                <h1><%#:Item.ProductName %></h1>
            </div>
            <br />
            <table>
                <tr>
                    <td>
                        <img src="<%#:Item.ImagePath %>" style="border:solid; height:300px" alt="<%#:Item.ProductName %>"/>
                    </td>
                    <td>&nbsp;</td>  
                    <td style="vertical-align: top; text-align:left;">
                        <b>Description:</b><br /><%#:Item.Description %>
                        <br />
                        <span><b>Price:</b>&nbsp;<%#: String.Format("{0:c}", Item.UnitPrice) %></span>
                        <br />
                        <span><b>Product Number:</b>&nbsp;<%#:Item.ProductID %></span>
                        <br />
                        <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>">               
                            <span class="ProductListItem">
                                <b>Add To Cart</b>
                            </span>           
                        </a>
                    </td>
                </tr>
            </table>
            <hr />
            <div>
                <h3>Recommended for You</h3>
            </div>
            <table id="recTable" style="width:100%;"></table>
            <script type="text/javascript">
                getData();
                function getData() {
                    $.ajax({
                        url: '/api/Product/5',
                        type: 'GET',
                        parameters: '5',
                        datatype: 'json',
                        success: function (data) {
                            if (data.length > 0) {
                                var rows = [];
                                for (var i = 0; i < data.length; i++) {
                                    rows.push('<td><a href="/Product/' + data[i].ProductID + '"><img src=\'' + data[i].ImageURL +
                                        '\' width="100" height="75" border="1" /></a><br /><a href="/Product/' + data[i].ProductID + '">' + data[i].ProductName +
                                        '</a><br /><span><b>Price: </b>$' + data[i].Price.toFixed(2) + '</span><br /><a href="/AddToCart.aspx?productID=' +
                                        data[i].ProductID + '"><span class="ProductListItem"><b>Add To Cart<b></span></a></td>');
                                }
                                $('#recTable').append(rows.join(''));
                            }
                        }
                    });
                }
            </script>
        </ItemTemplate>
    </asp:FormView>
</asp:Content>