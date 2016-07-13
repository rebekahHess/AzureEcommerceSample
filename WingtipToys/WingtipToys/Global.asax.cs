﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Data.Entity;
using WingtipToys.Models;
using WingtipToys.Logic;

using System.Data.SqlClient;
using System.Configuration;
using System.Web.Http;

namespace WingtipToys
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            //SqlDependency.Start(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString);


            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Initialize the product database.
            Database.SetInitializer(new ProductDatabaseInitializer());
            //using (var db = new ProductContext())
            //{

            //}

            // Create the custom role and user.
            RoleActions roleActions = new RoleActions();
            roleActions.AddUserAndRole();

            // Add Routes.
            RegisterCustomRoutes(RouteTable.Routes);
            
        }

        //protected void Application_End()
        //{
        //    SqlDependency.Stop(ConfigurationManager.ConnectionStrings["RecTest"].ConnectionString);
        //}




        void RegisterCustomRoutes(RouteCollection routes)
        {
            routes.MapHttpRoute(
              name: "DefaultApi",
              routeTemplate: "api/{controller}"
            );

            routes.MapHttpRoute(
              name: "DefaultApi2",
              routeTemplate: "api/{controller}/{id}"
            );
            routes.MapPageRoute(
              "ProductsByCategoryRoute",
              "Category/{categoryName}",
              "~/ProductList.aspx"
            );
            routes.MapPageRoute(
              "ProductByNameRoute",
              "Product/{productName}",
              "~/ProductDetails.aspx"
            );

        }

        void Application_Error(object sender, EventArgs e)
        {
          // Code that runs when an unhandled error occurs.

          // Get last error from the server
          Exception exc = Server.GetLastError();

          if (exc is HttpUnhandledException)
          {
            if (exc.InnerException != null)
            {
              exc = new Exception(exc.InnerException.Message);
              Server.Transfer("ErrorPage.aspx?handler=Application_Error%20-%20Global.asax",
                  true);
            }
          }
        }
    }
}