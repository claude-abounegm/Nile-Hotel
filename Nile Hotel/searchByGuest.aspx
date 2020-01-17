<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="searchByGuest.aspx.cs" Inherits="Nile_Hotel.searchByGuest" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label7" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Search By Guest" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <asp:Label ID="Label11" runat="server" Text="No Access - Please login first." Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 250px" ForeColor="White" Width="264px" Visible="False"></asp:Label>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Text="Guest Name" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White" Visible="False"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox1" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False"></asp:TextBox>
    <br />
     <asp:Button ID="Button1" runat="server" Text="Find" OnClick="find" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px; width: 100px;" Visible="False"/>
    <br />
     <asp:Label ID="Label2" runat="server" Text="Guest Details" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Width="187px" Visible="False"></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server"  Visible="False" EmptyDataText="No guest found with that name." Font-Names="Century Gothic" 
        style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px" Font-Size="Medium">
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
     <asp:Label ID="Label3" runat="server" Text="Guest Reservations" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px" ForeColor="White" Visible="False"></asp:Label>
    <br />
    <asp:GridView ID="GridView2" runat="server"  Visible="False" EmptyDataText="No reservations for this guest." Font-Names="Century Gothic" 
        style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px" Font-Size="Medium">
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
            catch (SqlException er)
            {
                Label11.Visible = true;
            }

        }
        else
            Label11.Visible = true;
            
    }
    protected void find(object sender, EventArgs e)
    {
        GridView1.Visible = false;
        GridView2.Visible = false;
        Label2.Visible = false;
        Label3.Visible = false;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        string strSelect = "Select* FROM Client WHERE username = '" + TextBox1.Text + "'";
        SqlCommand cmdSelect = new SqlCommand(strSelect, conn);

        try
        {
            conn.Open();
            DataTable guest = new DataTable();
            guest.Load(cmdSelect.ExecuteReader());
            GridView1.DataSource = guest;
            GridView1.DataBind();
            Label2.Visible = true;
            GridView1.Visible = true;

            string strSelectB = "Select* FROM Reservations WHERE guest = '" + TextBox1.Text + "'";

            SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);

            try
            {
                DataTable guestReservations = new DataTable();
                guestReservations.Load(cmdSelectB.ExecuteReader());
                GridView2.DataSource = guestReservations;
                GridView2.DataBind();
                GridView2.Visible = true;
                Label3.Visible = true;
            }
            catch (SqlException er)
            {
            }
            conn.Close();   
        }
        catch (SqlException er)
        {
        }
    }
</script>