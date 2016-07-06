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
            string keyName = "Managed";
            string key = "oRt/agurnQYUDRsvm0tOKOEi2e5nXr0MnTrUxP8PdTw=";
            string @namespace = "ServiceBusIntern2016";
            TimeSpan ttl = TimeSpan.FromHours(1);
            string sas = SharedAccessSignatureTokenProvider.GetSharedAccessSignature(keyName, key, @namespace, ttl);

            return sas;
        }
    }
}