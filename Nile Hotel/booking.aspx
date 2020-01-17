<%@ Page Title="" Language="C#" MasterPageFile="~/userMaster.master" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        txtStartDate_CalendarExtender.StartDate = DateTime.Today;
        txtEndDate_CalendarExtender.StartDate = DateTime.Today;

        // Accept Preferences......................................
        // string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
        // SqlConnection conn = new SqlConnection(strConn);

        // create a connect object to the database
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|airline.mdf;Integrated Security=True;User Instance=True";
        
          
        lblMsg.Visible = false;
        gdvBooking.Visible = false;

        string username = "";
        if (Request.Cookies["userInfo"] != null)
            username = Request.Cookies["userInfo"].Values["usern"];
        ViewState["U"] = username;

        // Getting Flights
        string strSelectF = "SELECT * FROM Flight "
            + " WHERE FlightDate >= '" + txtStartDate.Text + "'"
            + " AND   FlightDate <= '" + txtEndDate.Text + "'"
            + " AND   Dairport  = '" + ddlDairport.SelectedValue + "'"
            + " AND   Aairport  = '" + ddlAairport.SelectedValue + "'"
            + " AND   Seats > 0";

        SqlCommand cmdSelectF = new SqlCommand(strSelectF, conn);

        SqlDataReader reader;

        conn.Open();
        reader = cmdSelectF.ExecuteReader();
        if (reader.Read())
        {

            gdvFlights.Visible = true;
            btnBook.Visible = true;
            txtPassengerName.Visible = true;
            lblPassengerName.Visible = true;
            lblMsg.Text = "";

        }
        else
        {
            lblMsg.Text = "No Available Flights, You May Change Your Preferences!!";
            lblMsg.Visible = true;
            btnBook.Visible = false;
            txtPassengerName.Visible = false;
            lblPassengerName.Visible = false;
            gdvFlights.Visible = false;
        }
               
    }


    protected void btnBook_Click(object sender, EventArgs e)
    {
        lblMsg2.Text = "";

        if (gdvFlights.SelectedIndex != -1)
        {

            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|airline.mdf;Integrated Security=True;User Instance=True";

            string username = "";
            string email = "";
            if (Request.Cookies["userInfo"] != null)
            {
                username = Request.Cookies["userInfo"].Values["usern"];
                email = Request.Cookies["userInfo"].Values["email"];
            }
            ViewState["U"] = username;


            // getting Flight key
            string FlightNo = gdvFlights.SelectedRow.Cells[0].Text;
            string FlightDate = gdvFlights.SelectedRow.Cells[1].Text;
            string Dtime = gdvFlights.SelectedRow.Cells[3].Text;
            string Atime = gdvFlights.SelectedRow.Cells[5].Text;

            // Getting RefNo
            string strSelect = "SELECT MAX(RefNo) FROM Booking";

            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);

            SqlDataReader reader;

            conn.Open();
            reader = cmdSelect.ExecuteReader();

            int RefNo = 0;
            if (reader.Read())
                RefNo = (int)reader.GetValue(0);
            reader.Close();
            conn.Close();

            Random rnd = new Random();
            int incr = rnd.Next(100, 10000); // creates a number between 1 and 100

            RefNo = RefNo + incr;


            string strInsert = String.Format("Insert Into Booking Values({0},'{1}','{2}', '{3}', '{4}', '{5}')", RefNo, username, FlightNo, FlightDate, txtPassengerName.Text, null);

            SqlCommand cmdInsert = new SqlCommand(strInsert, conn);


            conn.Open();
            cmdInsert.ExecuteNonQuery();
            conn.Close();


            // display current booking
            gdvBooking.Visible = true;
            lblCurrent.Visible    = true;

            // Getting bookings
            string strSelectB = "SELECT B.RefNo, B.FlightNo, B.FlightDate, F.Dairport, F.Dtime, F.Aairport, F.Atime, B.PassengerName, B.SeatNo "
                + " FROM Booking B, Flight F "
                + " WHERE B.FlightNo   = F.FlightNo "
                + " AND   B.FlightDate = F.FlightDate "
                + " AND   B.Username = '" + username + "'"
                + " AND   B.FlightDate >= '" + txtStartDate.Text + "'"
                + " AND   B.FlightDate <= '" + txtEndDate.Text + "'";


            SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);

            DataTable tbl = new DataTable();
            
            conn.Open();
            tbl.Load(cmdSelectB.ExecuteReader());

            gdvBooking.DataSource = tbl;
            gdvBooking.DataBind();

            conn.Close();


            string strBook = "Thanks for using Egypt Airlines. This is to confirm your booking of a seat for "
            + txtPassengerName.Text + " in our Flight " + FlightNo + " on " + FlightDate + "'\n'"
            + " Departure from  " + ddlDairport.SelectedValue + " at " + Dtime + "'\n'"
            + " Arrival to " + ddlAairport.SelectedValue + " at " + Atime + "'\n'"
            + "Your Reference No: " + RefNo;

            sendEmail(email, strBook);

            // Updating seats of selected Flight

            string strUpdate = "UPDATE Flight "
                + " SET Seats = Seats - 1 "
                + " WHERE FlightNo = '" + FlightNo + "'"
                + " AND   FlightDate = '" + FlightDate + "'";

            SqlCommand cmdUpdate = new SqlCommand(strUpdate, conn);


            conn.Open();
            cmdUpdate.ExecuteNonQuery();
            conn.Close();

            //....................................................
            
            gdvFlights.DataBind();
            btnConfirm.Visible = true;
            
        }
        else
        {
            lblMsg2.Text = "No Flight Selected!! Select a Flight, then Click the Button Book!!";
            lblMsg.Visible = true;
        }


    }


    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("CSCE4502@gmail.com", strEmail);
        msg.Subject = "Booking Confirmation";
        msg.Body = strMsg;

        SmtpClient Sclient = new SmtpClient("smtp.gmail.com", 587);
        NetworkCredential auth = new NetworkCredential("CSCE4502@gmail.com", "csce4502f16");

        Sclient.UseDefaultCredentials = false;
        Sclient.Credentials = auth;
        Sclient.EnableSsl = true;
        try
        {
            Sclient.Send(msg);
            lblMsg2.Text = "A Message has been sent to your Email Address with details of your booking!!";
            lblMsg2.Visible = true;
        }
        catch (Exception ex)
        {
            lblMsg2.Text = ex.Message;
        }

    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        gdvBooking.Visible = false;
        gdvFlights.Visible = false;
        lblMsg.Visible = false;
        lblMsg2.Visible = false;

        btnConfirm.Visible = false;
        btnBook.Visible = false;
        txtPassengerName.Visible = false;
        lblPassengerName.Visible = false;
        lblCurrent.Visible = false;

    }

    protected void btnConfirm_Click1(object sender, EventArgs e)
    {
        gdvBooking.Visible = false;
        gdvFlights.Visible = false;
        lblMsg.Visible = false;
        lblMsg2.Visible = false;

        btnConfirm.Visible = false;
        btnBook.Visible = false;
        txtPassengerName.Visible = false;
        lblPassengerName.Visible = false;
        lblCurrent.Visible = false;
        txtStartDate.Text = "";
        txtEndDate.Text = "";
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

    <asp:Label ID="Label1" runat="server" Font-Names="Arial Black" 
        Font-Size="Large" ForeColor="#000066" Text="Enter Your Preferences:"></asp:Label>
    <br />
    <br />
    <asp:Label ID="Label2" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="From Date:"></asp:Label>
&nbsp;&nbsp;
    &nbsp;<asp:TextBox ID="txtStartDate" runat="server" Font-Names="Arial" 
        Font-Size="Medium" ForeColor="#000066" Width="176px"></asp:TextBox>

        <ajaxToolkit:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" 
                BehaviorID="txtStartDate_CalendarExtender" TargetControlID="txtStartDate">
            </ajaxToolkit:CalendarExtender>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label3" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="To Date:"></asp:Label>
&nbsp;
    <asp:TextBox ID="txtEndDate" runat="server" Font-Names="Arial" 
        Font-Size="Medium" ForeColor="#000066" Width="176px"></asp:TextBox>

        <ajaxToolkit:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" 
                BehaviorID="txtStartDate_CalendarExtender" 
        TargetControlID="txtEndDate">
            </ajaxToolkit:CalendarExtender>


    <br />
    <br />
    <asp:Label ID="Label4" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="Departure From:"></asp:Label>
&nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="ddlDairport" runat="server" AutoPostBack="True" 
        Font-Names="Arial" Font-Size="Medium" ForeColor="#000066">
        <asp:ListItem Selected="True">Cairo</asp:ListItem>
        <asp:ListItem>Alexandria</asp:ListItem>
        <asp:ListItem>Aswan</asp:ListItem>
        <asp:ListItem>Luxor</asp:ListItem>
        <asp:ListItem>Hurghada</asp:ListItem>
        <asp:ListItem>London</asp:ListItem>
        <asp:ListItem>Paris</asp:ListItem>
        <asp:ListItem>Rome</asp:ListItem>
        <asp:ListItem>Frankfort</asp:ListItem>
        <asp:ListItem>Madrid</asp:ListItem>
    </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label5" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="Arrival To:"></asp:Label>
&nbsp;
    <asp:DropDownList ID="ddlAairport" runat="server" AutoPostBack="True" 
        Font-Names="Arial" Font-Size="Medium" ForeColor="#000066">
        <asp:ListItem Selected="True">Cairo</asp:ListItem>
        <asp:ListItem>Alexandria</asp:ListItem>
        <asp:ListItem>Aswan</asp:ListItem>
        <asp:ListItem>Luxor</asp:ListItem>
        <asp:ListItem>Hurghada</asp:ListItem>
        <asp:ListItem>London</asp:ListItem>
        <asp:ListItem>Paris</asp:ListItem>
        <asp:ListItem>Rome</asp:ListItem>
        <asp:ListItem>Frankfort</asp:ListItem>
        <asp:ListItem>Madrid</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />

    <asp:Label ID="lblMsg" runat="server" Font-Names="Monotype Corsiva" 
        Font-Size="X-Large" ForeColor="#CC0000"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gdvFlights" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="FlightNo,FlightDate" 
        DataSourceID="SqlDataSource1" ForeColor="#000066" GridLines="None" 
        Font-Names="Arial" Font-Size="Medium">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="FlightNo" HeaderText="FlightNo" ReadOnly="True" 
                SortExpression="FlightNo" />
            <asp:BoundField DataField="FlightDate" HeaderText="FlightDate" ReadOnly="True" 
                SortExpression="FlightDate" />
            <asp:BoundField DataField="Dairport" HeaderText="Dairport" 
                SortExpression="Dairport" />
            <asp:BoundField DataField="Dtime" HeaderText="Dtime" SortExpression="Dtime" />
            <asp:BoundField DataField="Aairport" HeaderText="Aairport" 
                SortExpression="Aairport" />
            <asp:BoundField DataField="Atime" HeaderText="Atime" SortExpression="Atime" />
            <asp:BoundField DataField="Seats" HeaderText="Seats" SortExpression="Seats" />
            <asp:CommandField />
            <asp:CommandField HeaderText="Select" ShowHeader="True" 
                ShowSelectButton="True" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Flight] WHERE (([Dairport] = @Dairport) AND ([Aairport] = @Aairport) AND ([FlightDate] &gt;= @FlightDate) AND ([FlightDate] &lt;= @FlightDate2) AND ([Seats] &gt; @Seats))">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDairport" Name="Dairport" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddlAairport" Name="Aairport" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtStartDate" Name="FlightDate" 
                PropertyName="Text" DbType="Date" />
            <asp:ControlParameter ControlID="txtEndDate" Name="FlightDate2" 
                PropertyName="Text" DbType="Date" />
            <asp:Parameter DefaultValue="0" Name="Seats" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:Label ID="lblPassengerName" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="Passenger Name" 
        Visible="False"></asp:Label>
&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtPassengerName" runat="server" Font-Names="Arial" 
        Font-Size="Medium" ForeColor="#000066" Width="184px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnBook" runat="server" Font-Bold="True" 
        Font-Names="Arial Black" Font-Size="Medium" ForeColor="#000066" Text="Book Now" 
        Visible="False" onclick="btnBook_Click" />
    <br />
    <br />

    <asp:Label ID="lblMsg2" runat="server" Font-Names="Monotype Corsiva" 
        Font-Size="X-Large" ForeColor="#CC0000" Visible="False"></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblCurrent" runat="server" Font-Names="Arial Black" 
        Font-Size="Medium" ForeColor="#000066" Text="Your Current Bookings:" 
    Visible="False"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gdvBooking" runat="server" CellPadding="4" Font-Names="Arial" 
        Font-Size="Medium" ForeColor="#000066" GridLines="None" 
    Visible="False">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="btnConfirm" runat="server" Font-Bold="True" 
        Font-Names="Arial Black" Font-Size="Medium" ForeColor="#000066" 
        Text="Confirm Your Booking !!" onclick="btnConfirm_Click1" 
    Visible="False" />
    <br />
</asp:Content>

