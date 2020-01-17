<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="checkOut.aspx.cs" Inherits="Nile_Hotel.checkOut" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label7" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="CheckOut" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>
    <br />
    <asp:Label ID="Label11" runat="server" Text="No Access - Please login first." Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 250px" ForeColor="White" Width="264px" Visible="False"></asp:Label>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Text="Guest Name" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White" Visible="False"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox1" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False"></asp:TextBox>
    <br />
     <asp:Button ID="Button1" runat="server" Text="Find" OnClick="find" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px; width: 150px;" Visible="False"/>
    <p />
     <asp:Label ID="Label2" runat="server" Text="Guest Reservations" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Width="187px" Visible="False"></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server"  Visible="False" EmptyDataText="No guest found with that name or guest already checked out." Font-Names="Century Gothic" 
        style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px" Font-Size="Medium" OnSelectedIndexChanged="allowBill">
        <Columns>
            <asp:CommandField HeaderText="Select" ShowHeader="True" 
                ShowSelectButton="True"/>
            </Columns>
        <AlternatingRowStyle BackColor="White" ForeColor="#284775"/>
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
    <table>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Guest Full Name" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
                </td>
                  <td>
                       <asp:TextBox ID="TextBox2" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
                </td>
                </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="Room Type" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
          </td>
            <td>
                 <asp:TextBox ID="TextBox3" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
            </td>
            </tr>
         <tr>
            <td>
                 <asp:Label ID="Label5" runat="server" Text="Number of Nights" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
          </td>
            <td>
                    <asp:TextBox ID="TextBox4" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
            </td>
            </tr>
         <tr>
            <td>
                 <asp:Label ID="Label6" runat="server" Text="Guest Type" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
          </td>
            <td>
                 <asp:TextBox ID="TextBox5" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
            </td>
            </tr>
         <tr>
            <td>
                <asp:Label ID="Label8" runat="server" Text="Season" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
          </td>
            <td>
                 <asp:TextBox ID="TextBox6" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
            </td>
            </tr>
         <tr>
            <td>
                 <asp:Label ID="Label9" runat="server" Text="Reference Number" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
          </td>
            <td>
                 <asp:TextBox ID="TextBox7" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False" ReadOnly="True"></asp:TextBox>
            </td>
            </tr>
        </table>

    <br />
    <asp:Button ID="Button2" runat="server" Text="Bill & CheckOut" OnClick="bill" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px; width: 150px;" Visible="False"/>
    <br />

    <asp:Label ID="Label10" runat="server" Text="Bill Sent!" Font-Names="Century Gothic" style="margin-left: 60px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>

    <br />

</asp:Content>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";
    
    protected void Page_Load(object sender, EventArgs e){
        if (Request.Cookies["userInfo"] != null)
        {
            
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            string strSelect = "SELECT * FROM Client "
                + " WHERE username = '" + Request.Cookies["userInfo"].Values["username"]
                + "' AND password = '" + Request.Cookies["userInfo"].Values["password"] + "' AND staff = 1";

           SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
           try
           {
               conn.Open();
               SqlDataReader reader = cmdSelect.ExecuteReader();

               if (reader.Read())
               {
                   Label1.Visible = true;
                   Button1.Visible = true;
                   TextBox1.Visible = true;
               }
               else
                   Label11.Visible = true;
               conn.Close();
           }
           catch (SqlException er){
               Label11.Visible = true;
           } 
           
        }
        else
            Label11.Visible = true;
            
    }
    protected void bill(object sender, EventArgs e)
    {
        CentralDBcheckOut(GridView1.SelectedRow.Cells[1].Text);
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        string strUpdate = "UPDATE Reservations SET bill = 1 WHERE refNo = " + GridView1.SelectedRow.Cells[1].Text;
        SqlCommand cmdUpdate = new SqlCommand(strUpdate, conn);

        try
        {
            conn.Open();
            cmdUpdate.ExecuteNonQuery();
            Label10.Visible = true;
            conn.Close();

            string strSelect = "Select email FROM Client WHERE username = '" + Request.Cookies["userInfo"].Values["username"] + "'";
            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
            SqlDataReader reader;
            try
            {
                conn.Open();
                reader = cmdSelect.ExecuteReader();
                if (reader.Read())
                {
                    string email = (string)reader.GetValue(0);
                    string msg = "Dear, " + Request.Cookies["userInfo"].Values["fname"] + " " + Request.Cookies["userInfo"].Values["lname"]
                        + ", we would like to confirm your checkout and payment for your reservation of reference number: " + GridView1.SelectedRow.Cells[1].Text
                        + ". Thank you!";
                    sendEmail(email, msg);
                }
                reader.Close();
                conn.Close();
                Response.Write("<body onload=\"window.open('checkReservation.aspx', '_top')\"></body>");
            }
            catch {
                Label10.Text = "Email verification failed " ;
                Label10.Visible = true;
            }
        }
        catch (SqlException er) {
            Label10.Text = "Email not found " + er;
            Label10.Visible = true;
        }
    }
    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("nilehotelauc@gmail.com", strEmail);
        msg.Subject = "Nile Hotel - Check Out";
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
            Label10.Text = "Email verification failed " + ex;
            Label10.Visible = true;
        }
    }
    protected void find(object sender, EventArgs e)
    {
        GridView1.Visible = false;
        Label2.Visible = false;
        Label3.Visible = false;
        Label4.Visible = false;
        Label5.Visible = false;
        Label6.Visible = false;
        Label8.Visible = false;
        Label9.Visible = false;
        Label10.Visible = false;
        Button2.Visible = false;
        TextBox2.Visible = false;
        TextBox3.Visible = false;
        TextBox4.Visible = false;
        TextBox5.Visible = false;
        TextBox6.Visible = false;
        TextBox7.Visible = false;
        
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        string strSelect = "Select* FROM Reservations WHERE guest = '" + TextBox1.Text + "' AND bill = 0";
        SqlCommand cmdSelect = new SqlCommand(strSelect, conn);

        try
        {
            conn.Open();
            DataTable guestReservations = new DataTable();
            guestReservations.Load(cmdSelect.ExecuteReader());
            GridView1.DataSource = guestReservations;
            GridView1.DataBind();
            Label2.Visible = true;
            GridView1.Visible = true;

       
            conn.Close();   
        }
        catch (SqlException er)
        {
        }
    }

    protected void allowBill(object sender, EventArgs e)
    {
        
        TextBox7.Text = GridView1.SelectedRow.Cells[1].Text;
        TextBox6.Text = GridView1.SelectedRow.Cells[7].Text;
        TextBox4.Text = (Convert.ToDateTime(GridView1.SelectedRow.Cells[5].Text).Subtract(Convert.ToDateTime(GridView1.SelectedRow.Cells[4].Text)).Days).ToString();
        TextBox3.Text = GridView1.SelectedRow.Cells[3].Text;

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        string strSelect = "Select* FROM Client WHERE username = '" + TextBox1.Text + "'";
        SqlCommand cmdSelect = new SqlCommand(strSelect, conn);

        try
        {
            conn.Open();
            SqlDataReader reader;

            reader = cmdSelect.ExecuteReader();

            if (reader.Read())
            {
                TextBox2.Text = (string)reader.GetValue(3) + " " + (string)reader.GetValue(4);
                TextBox5.Text = ((int)reader.GetValue(8) == 1? "Local" : (int)reader.GetValue(8) == 2? "Foreigner": "Group");  
                reader.Close();
            }
            conn.Close();
            Label3.Visible = true;
            Label4.Visible = true;
            Label5.Visible = true;
            Label6.Visible = true;
            Label7.Visible = true;
            Label8.Visible = true;
            Label9.Visible = true;
            Button2.Visible = true;
            TextBox2.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            TextBox7.Visible = true;
        }
        catch (SqlException er)
        {
            Label10.Text = "Something went wrong. " + er;
            Label10.Visible = true;
        }
    }
</script>