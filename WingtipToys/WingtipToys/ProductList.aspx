	<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="ProductList.aspx.cs" Inherits="WingtipToys.ProductList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div>
            <hgroup>
                <h2><%: Page.Title %></h2>
            </hgroup>

            <asp:ListView ID="productList" runat="server" 
                DataKeyNames="ProductID" GroupItemCount="4"
                ItemType="WingtipToys.Models.Product" SelectMethod="GetProducts">
                <EmptyDataTemplate>
                    <table >
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
                    <td/>
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td runat="server">
                        <table>
                            <tr>
                                <td>
                                  <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">
                                    <img src='/Catalog/Images/Thumbs/<%#:Item.ImagePath%>'
                                      width="100" height="75" />
                                  </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">
                                      <%#:Item.ProductName%>
                                    </a>
                                    <br />
                                    <span>
                                        <b>Price: </b><%#:String.Format("{0:c}", Item.UnitPrice)%>
                                    </span>
                                    <br />
                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>">               
                                        <span class="ProductListItem">
                                            <b>Add To Cart</b>
                                        </span>           
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table style="width:100%;">
                        <tbody>
                            <tr>
                                <td>
                                    <table id="groupPlaceholderContainer" runat="server" style="width:100%">
                                        <tr id="groupPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                            <tr></tr>
                        </tbody>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
    </section>


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

</asp:Content>