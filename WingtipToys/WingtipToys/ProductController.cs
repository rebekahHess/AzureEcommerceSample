using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

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