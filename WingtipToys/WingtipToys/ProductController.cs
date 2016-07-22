using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WingtipToys.Logic;

using System.Web;
using WingtipToys.Models;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Collections;
using System.Web.ModelBinding;

namespace WingtipToys
{
    public class ProductController : ApiController
    {


        // GET api/<controller>
        [HttpGet]
        public IEnumerable<ProductInfo> Get()
        {
            ProductInfoRepository objRepo = new ProductInfoRepository();
            return objRepo.GetHome();
        }

        // GET api/<controller>/5
        [HttpGet]
        public IEnumerable<ProductInfo> Get(int id)
        {
            ProductInfoRepository objRepo = new ProductInfoRepository();
            return objRepo.GetProducts();
        }

        // GET api/<controller>/5
        [HttpGet]
        public IEnumerable<PurchaseInfo> Get(string s1, int i1)
        {
            ProductInfoRepository objRepo = new ProductInfoRepository();
            return objRepo.GetPurchase();
        }

        // GET api/<controller>/5
        [HttpGet]
        public IEnumerable<String> Get(int i1, int i2)
        {
            ProductInfoRepository objRepo = new ProductInfoRepository();
            return objRepo.GetUser();
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}