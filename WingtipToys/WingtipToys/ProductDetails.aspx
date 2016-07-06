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
                        <img src="/Catalog/Images/<%#:Item.ImagePath %>" style="border:solid; height:300px" alt="<%#:Item.ProductName %>"/>
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
            <table id="recTable" style="width:75%;">
                <tbody>
                    <tr>
                        <td><br /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Recommended for You</b></td>
                    </tr>
                </tbody>
            </table>
            <script type="text/javascript">
                $(function () {
                    // Adds a product recommendation to the page.
                    function GetRec(prodID, prod, im, price, catID) {
                        $('#recTable').append('<td><a href="/Product/' + prod + '"><img src=\'/Catalog/Images/Thumbs/' + im +
                            '\' width="100" height="75" border="1" /></a><br /><a href="/Product/' + prod + '">' + prod + '</a><br /><span><b>Price: </b>$' +
                            price + '</span><br /><a href="/AddToCart.aspx?productID=' + prodID + '"><span class="ProductListItem"><b>Add To Cart<b></span></a></td>');                      
                    }
                    // TODO: Query database.
                    GetRec(1, "Convertible Car", "carconvert.png", 22.50, 1);
                    GetRec(2, "Old-time Car", "carearly.png", 15.95, 1);
                    GetRec(3, "Fast Car", "carfast.png", 32.99, 1);

                });
            </script>
        </ItemTemplate>
    </asp:FormView>



</asp:Content>