using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace WingtipToys
{
    public class ProductInfoRepository
    {
        // Use for home page recommendations
        public IEnumerable<ProductInfo> GetHome()
        {

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT TOP 3 * FROM [dbo].[Purchases] ORDER BY [Count] DESC;", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    command.Notification = null;

                    //SqlDependency dependency = new SqlDependency(command);
                    //dependency.OnChange += new OnChangeEventHandler(dependency_OnChange);

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

        public IEnumerable<ProductInfo> GetProducts()
        {
            // Use for product specific recommendations
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT TOP 3 * FROM [dbo].[Purchases] ORDER BY [Count];", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    command.Notification = null;

                    //SqlDependency dependency = new SqlDependency(command);
                    //dependency.OnChange += new OnChangeEventHandler(dependency_OnChange);

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
        private void dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            SignalrHub.Show();
        }

    }
}