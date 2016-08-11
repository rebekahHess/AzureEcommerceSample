using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using WingtipToys.Logic;
using WingtipToys.Models;


using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Specialized;
using System.Collections;
using System.Web.ModelBinding;

using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace WingtipToys
{
    public class ProductInfoRepository
    {
        public static ShoppingCartActions userShoppingCart;
        public static List<CartItem> cartItems;
        public static IEnumerable<PurchaseInfo> purchaseData;
        // Use for home page recommendations
        public IEnumerable<ProductInfo> GetHome()
        {

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT TOP 5 * FROM [dbo].[Purchases] ORDER BY [Count] DESC;", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    command.Notification = null;

                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        return reader.Cast<IDataRecord>().Select(x => new ProductInfo()
                        {
                            ProductID = x.GetInt32(0),
                            ProductName = x.GetString(1),
                            ImageURL = x.GetString(2),
                            Price = x.GetDouble(3),
                            CategoryID = x.GetInt32(4),
                            Count = x.GetInt32(5)
                        }).ToList();


                    }
                }
            }
        }

        public IEnumerable<ProductInfo> GetProducts(int product)
        {
            List<ProductInfo> recommendations = new List<ProductInfo>();
            List<int> products = new List<int>();
            // Use for product specific recommendations
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Recommendations"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT [RecOne], [RecTwo], [RecThree] FROM [dbo].[ItemRecommendations] WHERE [ProductId] = " + product + ";", connection))
                {
                    command.Notification = null;

                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            products.Add(reader.GetInt32(0));
                            products.Add(reader.GetInt32(1));
                            products.Add(reader.GetInt32(2));
                        }                        
                    }
                }
            }
            foreach(int recommend in products)
            {
                using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(@"SELECT * FROM [dbo].[Purchases] WHERE [ProductID] = " + recommend + ";", connection))
                    {
                        command.Notification = null;

                        if (connection.State == ConnectionState.Closed)
                            connection.Open();

                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                recommendations.Add(new ProductInfo()
                                {
                                    ProductID = reader.GetInt32(0),
                                    ProductName = reader.GetString(1),
                                    ImageURL = reader.GetString(2),
                                    Price = reader.GetDouble(3),
                                    CategoryID = reader.GetInt32(4),
                                    Count = reader.GetInt32(5)
                                });
                            }
                        }
                    }
                }
            }
            return (IEnumerable<ProductInfo>)recommendations;
        }

        public IEnumerable<PurchaseInfo> GetPurchase()
        {
            Boolean hasRows = false;
            foreach (CartItem item in cartItems)
            {
                using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
                {
                    connection.Open();

                    // determine if item is not in purchases table
                    using (SqlCommand command = new SqlCommand(@"SELECT * FROM [dbo].[Purchases] WHERE [ProductID] = '" + item.Product.ProductID + "';", connection))
                    {
                        command.Notification = null;

                        if (connection.State == ConnectionState.Closed)
                            connection.Open();

                        var reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            hasRows = true;
                        }

                    }
                }
                if (hasRows == false)
                {
                    using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
                    {

                        using (SqlCommand command = new SqlCommand(@"INSERT INTO [dbo].[Purchases] (ProductID, ProductName, ImageURL, Price, CategoryID, Count) VALUES (" + item.Product.ProductID + ", '" + item.Product.ProductName + "', '" + item.Product.ImagePath + "', '" + item.Product.UnitPrice + "', '" + item.Product.CategoryID + "', '0');", connection))
                        {
                            command.Notification = null;

                            if (connection.State == ConnectionState.Closed)
                                connection.Open();

                            command.Notification = null;

                            var reader2 = command.ExecuteReader();
                        }
                    }

                }
            }
            return purchaseData;
        }

        public IEnumerable<ProductInfo> GetCategory(int category)
        {

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT TOP 5 * FROM [dbo].[Purchases]  WHERE [CategoryID] = " + category + " ORDER BY [Count] DESC;", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    command.Notification = null;

                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        return reader.Cast<IDataRecord>().Select(x => new ProductInfo()
                        {
                            ProductID = x.GetInt32(0),
                            ProductName = x.GetString(1),
                            ImageURL = x.GetString(2),
                            Price = x.GetDouble(3),
                            CategoryID = x.GetInt32(4),
                            Count = x.GetInt32(5)
                        }).ToList();


                    }
                }
            }
        }

        public IEnumerable<String> GetUser()
        {
            List<String> user = new List<String>();
            if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
            {
                user.Add(HttpContext.Current.User.Identity.Name);
                return (IEnumerable<String>)user;
            }
            else
            {
                // Generate a new random GUID using System.Guid class.     
                Guid tempUser = Guid.NewGuid();
                user.Add(tempUser.ToString());
                return (IEnumerable<String>)user;
            }
        }
        private void dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            SignalrHub.Show();
        }

    }
}