using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WingtipToys
{
    public class PurchaseInfo
    {
        public int ProductId { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }
        public DateTime Time { get; set; }
        public string Email { get; set; }
        public string SessionId { get; set; }
    }
}