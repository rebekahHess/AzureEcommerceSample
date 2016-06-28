using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Client;

namespace WingtipToys
{
  public partial class _Default : Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
        }

    private void Page_Error(object sender, EventArgs e)
    {
      // Get last error from the server.
      Exception exc = Server.GetLastError();

      // Handle specific exception.
      if (exc is InvalidOperationException)
      {
        // Pass the error on to the error page.
        Server.Transfer("ErrorPage.aspx?handler=Page_Error%20-%20Default.aspx",
            true);
      }
    }

        [WebMethod]
        public static void TestMethod()
    {
            string connectionString = "Server=tcp:internserver2016.database.windows.net,1433;Data Source=internserver2016.database.windows.net;Initial Catalog=ClickDataRaw;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
            SqlConnection objConn = new SqlConnection(connectionString);
            objConn.Open();
            var sw = new StreamWriter(Console.OpenStandardOutput());
            sw.AutoFlush = true;
            Console.SetOut(sw);
            Console.WriteLine("test");
    }
  }
}