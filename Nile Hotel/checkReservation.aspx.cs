using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Nile_Hotel.localhost;

namespace Nile_Hotel
{
    public partial class checkReservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void centralDBcancel(string refNo)
        {
            localhost.WebService1 ws = new localhost.WebService1();
            ws.cancel(refNo);
        }
    }
}