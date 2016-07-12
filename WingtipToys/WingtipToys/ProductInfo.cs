using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WingtipToys
{
    public class ProductInfo
    {
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ImageURL { get; set; }
        public double Price { get; set; }
        public int CategoryID { get; set; }
        public int Count { get; set; }
    }
}