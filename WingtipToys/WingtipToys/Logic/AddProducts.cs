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
            
            //using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            //{
            //    connection.Open();
            //    // Make sure the command object does not already have
            //    // a notification object associated with it.

            //    using (SqlCommand command2 = new SqlCommand(@"INSERT INTO [dbo].[Purchases] (ProductID, ProductName, ImageURL, Price, CategoryID, Count) VALUES (" + myProduct.ProductID + ", '" + ProductName + "', '" + ProductImagePath + "', " + Convert.ToDouble(ProductPrice) + ", " + Convert.ToInt32(ProductCategory) + ", 0);", connection))
            //    {
            //        // Make sure the command object does not already have
            //        // a notification object associated with it.
            //        command2.Notification = null;

            //        var reader = command2.ExecuteReader();
            //    }

            //}

            // Success.
            return true;
        }
    }
}