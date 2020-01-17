<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="checkReservation.aspx.cs" Inherits="Nile_Hotel.checkReservation" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    


    <asp:Label ID="Label1" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="MyReservations" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" Visible="False" OnSelectedIndexChanged="allowCancel" EmptyDataText="No reservations available." Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" Font-Size="Medium">
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
    <asp:Button ID="Button1" runat="server" Text="Cancel reservation" Visible="False" OnClick="cancel" Font-Names="Century Gothic" style="margin-left: 50px; margin-bottom: 15px;"/>
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Text="Sorry, cannot cancel a reservation that late" Visible="False" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label>
    <br />
    <br />
</asp:Content>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";
    
    protected void Page_Load(object sender, EventArgs e){

        if (Request.Cookies["userInfo"] != null)
        {
            string guest = Request.Cookies["userInfo"].Values["username"];
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            string strSelectB = "Select* FROM Reservations WHERE guest = '" + guest + "'";

            SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);

            DataTable reservations = new DataTable();

            try
            {
                conn.Open();
                reservations.Load(cmdSelectB.ExecuteReader());
                GridView1.DataSource = reservations;
                GridView1.DataBind();
                GridView1.Visible = true;

                conn.Close();
            }
            catch (SqlException er)
            {
                Label3.Text = "Failed please retry. " + er;
                Label3.Visible = true;
            }
        }
        else {
            Response.Write("<body onload=\"window.open('reserve.aspx', '_top')\"></body>");
        }
    }

    protected void allowCancel(object sender, EventArgs e)
    {
        Button1.Visible = true;
    }

    protected void cancel(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            string refNo = GridView1.SelectedRow.Cells[01].Text;
            string checkIn = GridView1.SelectedRow.Cells[4].Text;
            int diff = Convert.ToDateTime(checkIn).Subtract(DateTime.Today).Days;

            if (diff > 1)
            {
                centralDBcancel(refNo);
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = databaseAddress;
                string strDelete = "DELETE FROM Reservations WHERE refNo = " + refNo;

                SqlCommand cmdDelete = new SqlCommand(strDelete, conn);

                try
                {
                    conn.Open();
                    cmdDelete.ExecuteNonQuery();
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
                                + ", we would like to confirm the cancellation of your reservation of reference number: " + refNo
                                + ". Thank you!";
                            sendEmail(email, msg);
                        }
                        reader.Close();
                        conn.Close();
                    }
                    catch {
                        Label3.Text = "Email verification failed.";
                        Label3.Visible = true; 
                    }
                }
                catch (SqlException er){
                    Label3.Text = "Failed please retry. " + er;
                    Label3.Visible = true;
                }
                Response.Write("<body onload=\"window.open('checkReservation.aspx', '_top')\"></body>");
            }
            else
            {
                Label3.Visible = true;
            }
        }
    }

    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("nilehotelauc@gmail.com", strEmail);
        msg.Subject = "Nile Hotel - Cancellation";
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

        }
    }
</script>