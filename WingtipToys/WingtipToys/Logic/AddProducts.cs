using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WingtipToys.Models;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace WingtipToys.Logic
{
    public class AddProducts
    {
        public bool AddProduct(string ProductName, string ProductDesc, string ProductPrice, string ProductCategory, string ProductImagePath)
        {
            var myProduct = new Product();
            myProduct.ProductName = ProductName;
            myProduct.Description = ProductDesc;
            myProduct.UnitPrice = Convert.ToDouble(ProductPrice);
            myProduct.ImagePath = ProductImagePath;
            myProduct.CategoryID = Convert.ToInt32(ProductCategory);

            using (ProductContext _db = new ProductContext())
            {
                // Add product to DB.
                _db.Products.Add(myProduct);
                _db.SaveChanges();
            }

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT MAX([ProdId]) FROM [dbo].[Purchases];", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    int prodId = 0;
                    command.Notification = null;

                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            prodId = reader.GetInt32(0);
                        }

                    }

                    using (SqlCommand command2 = new SqlCommand(@"INSERT INTO [dbo].[Purchases] VALUES (" + (prodId + 1) + ",myProduct.ProductName,myProduct.ImagePath,myProduct.UnitPrice,myProduct.CategoryID,0);", connection))
                    {
                        // Make sure the command object does not already have
                        // a notification object associated with it.
                        command2.Notification = null;

                        var reader = command2.ExecuteReader();
                    }
                }

            }
            // Success.
            return true;
        }
    }
}