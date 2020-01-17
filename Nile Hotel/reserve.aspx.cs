using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Nile_Hotel.localhost;

namespace Nile_Hotel
{
    public partial class reserve : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void find(object sender, EventArgs e)
        {
            GridView1.Visible = false;
            localhost.WebService1 ws = new localhost.WebService1();
            GridView1.DataSource = ws.browseRooms(TextBox1.Text, TextBox2.Text, DropDownList1.SelectedValue);
            GridView1.DataBind();
            GridView1.Visible = true;
        }
        protected int centralDBbook(string guest, string roomNumber, string roomType, string season, string checkIn, string checkOut)
        {
            localhost.WebService1 ws = new localhost.WebService1();
            return ws.book(guest, roomNumber, roomType, season, checkIn, checkOut);
        }
    }
}