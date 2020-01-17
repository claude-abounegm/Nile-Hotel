<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="reserve.aspx.cs" Inherits="Nile_Hotel.reserve" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";
    
    protected void Page_Load(object sender, EventArgs e){
        CalendarExtender1.StartDate = DateTime.Today;
        CalendarExtender2.StartDate = DateTime.Today;
    }
    protected void allowBook(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            Button2.Visible = true;
        }
        else {
            Label6.Visible = true;
        }
    }
    protected void book(object sender, EventArgs e){
        if (Request.Cookies["userInfo"] != null)
        {
            string guest = Request.Cookies["userInfo"].Values["username"];
            string roomNumber = GridView1.SelectedRow.Cells[1].Text;
            string roomType = GridView1.SelectedRow.Cells[2].Text;
            string season = GridView1.SelectedRow.Cells[3].Text;
            string checkIn = TextBox1.Text;
            string checkOut = TextBox2.Text;
            int numberOfNights = Convert.ToDateTime(TextBox2.Text).Subtract(Convert.ToDateTime(TextBox1.Text)).Days;
            int refNo = centralDBbook(guest, roomNumber, roomType, season, checkIn, checkOut);
            if (refNo != -1)
            {
                string strInsert = "Insert INTO Reservations(refNo, guest, roomType, checkIn, checkOut, roomNumber, season) VALUES('"
               + refNo + "', '" 
               + guest + "', '"
               + roomType + "', '"
               + checkIn + "', '"
               + checkOut + "', '"
               + roomNumber + "', '"
               + season + "')";

                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = databaseAddress;
                SqlCommand cmdInsert = new SqlCommand(strInsert, conn);

                try
                {
                    conn.Open();
                    cmdInsert.ExecuteNonQuery();
                    conn.Close();

                    string strSelectB = "Select email FROM Client WHERE username = '" + Request.Cookies["userInfo"].Values["username"] + "'";
                    SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);
                    SqlDataReader readerB;
                    try
                    {
                        conn.Open();
                        readerB = cmdSelectB.ExecuteReader();
                        if (readerB.Read())
                        {
                            string email = (string)readerB.GetValue(0);
                            string msg = "Dear, " + Request.Cookies["userInfo"].Values["fname"] + " " + Request.Cookies["userInfo"].Values["lname"]
                             + ", we would like to confirm your reservation of reference number: " + refNo
                             + ", Room Number " + roomNumber
                             + ", Room Type: " + roomType
                             + ", starting on: " + checkIn
                             + ", until: " + checkOut
                             + ", with a total of " + numberOfNights + " nights. Thank you!";
                            sendEmail(email, msg);
                        }
                        readerB.Close();
                        conn.Close();
                    }
                    catch (Exception ex)
                    {
                        Label6.Text = "Email verification failed " + ex;
                        Label6.Visible = true;
                    }
                }
                catch (SqlException ex)
                {
                    Label6.Text = "Email verification failed " + ex;
                    Label6.Visible = true;
                }

                Response.Write("<body onload=\"window.open('checkReservation.aspx', '_top')\"></body>");
            }
        }
    }
   

    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("nilehotelauc@gmail.com", strEmail);
        msg.Subject = "Nile Hotel - Reservation";
        msg.Body = strMsg;

        SmtpClient Sclient = new SmtpClient("smtp.gmail.com", 587);
        NetworkCredential auth = new NetworkCredential("nilehotelauc@gmail.com", "nilehotel@@");

        Sclient.UseDefaultCredentials = false;
        Sclient.Credentials = auth;
        Sclient.EnableSsl = true;
        try
        {
            Sclient.Send(msg);

        }
        catch (Exception ex)
        {
            Label6.Text = "Email verification failed " + ex;
            Label6.Visible = true;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

    <asp:Label ID="Label7" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Browse Rooms" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />

    <asp:Label ID="Label1" runat="server" Text="From Date" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox1" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px"></asp:TextBox>

    <ajaxToolkit:CalendarExtender ID="CalendarExtender1"  BehaviorID="CalendarExtender1" runat="server" TargetControlID="TextBox1"/>

    <br />
    <asp:Label ID="Label2" runat="server" Text="To Date" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox2" runat="server" Font-Names="Century Gothic" 
        Font-Size="Medium" ForeColor="#000066" Width="176px" style="margin-left: 35px; margin-bottom: 15px"></asp:TextBox>

    <ajaxToolkit:CalendarExtender ID="CalendarExtender2"  BehaviorID="CalendarExtender2" runat="server" TargetControlID="TextBox2"/>

    <br />
    <asp:Label ID="Label3" runat="server" Text="Room Type" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White"></asp:Label>
 
    <asp:DropDownList ID="DropDownList1" runat="server" style="margin-left: 20px; margin-bottom: 15px; width: 180px; height: 25px">
        <asp:ListItem Selected="True">Any</asp:ListItem>
        <asp:ListItem>Single</asp:ListItem>
        <asp:ListItem>Double</asp:ListItem>
        <asp:ListItem>Suite</asp:ListItem>
    </asp:DropDownList>

    <br />

    <asp:CompareValidator ID="cmpDates" runat="server" ControlToValidate="TextBox1"
                  SetFocusOnError="true" ControlToCompare="TextBox2"
                  ErrorMessage="End date must be greater than start date"
                  Operator="LessThan"
                  ValidationGroup="vg" Type="Date"                           
                  CultureInvariantValues="true" ForeColor="Red" Font-Names="Century Gothic"
                style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px"></asp:CompareValidator>

    <br />
    <asp:Button ID="Button1" runat="server" Text="Find" OnClick="find" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px"/>
    <br />
    <asp:GridView ID="GridView1" runat="server"  OnSelectedIndexChanged="allowBook" Visible="False" EmptyDataText="No Rooms available, please change your preferences." Font-Names="Century Gothic" 
        style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px" Font-Size="Medium">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775"/>
        <Columns>
            <asp:CommandField HeaderText="Select" ShowHeader="True" 
                ShowSelectButton="True"/>
            </Columns>
        
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#6fcec9" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    <br />
    <asp:Label ID="Label6" runat="server" Text="Please login first in order to book your room." Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px" ForeColor="White"></asp:Label>

    <br />
    <asp:Button ID="Button2" runat="server" Text="Book" OnClick="book" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px"/>
    <br />

</asp:Content>
