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
        public static void Show()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<SignalrHub>();
            context.Clients.All.displayStatus();
        }
    }
}