using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Client;

[assembly: OwinStartupAttribute(typeof(WingtipToys.Startup))]
namespace WingtipToys
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            
        }
    }
}
