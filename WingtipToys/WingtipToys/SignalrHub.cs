using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Client;
using WingtipToys.Models;

namespace WingtipToys
{
    public class SignalrHub : Hub
    {
        public void Send(int prodID, string prod, string im, double? price, int? catID)
        {
            Clients.All.broadcastMessage(prodID, prod, im, price, catID);
        }
    }
}