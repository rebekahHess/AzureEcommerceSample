using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.ServiceBus;

namespace WingtipToys.SASServer
{
    public partial class SAS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(GetNewSAS());
        }

        public static string GetNewSAS()
        {
            // Test stuff.
            string keyName = "EventHubSendKey";
            string key = "F9Zp42j2iwJL7KCAzVWXGMIjTmZFhFK9HgqNK7xHsag=";
            string @namespace = "ServiceBusIntern2016";
            TimeSpan ttl = TimeSpan.FromDays(730);
            string sas = SharedAccessSignatureTokenProvider.GetSharedAccessSignature(keyName, key, @namespace, ttl);

            return sas;
        }
    }
}