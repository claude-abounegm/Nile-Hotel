<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="adminHome.aspx.cs" Inherits="Nile_Hotel.adminHome" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <br />
    <asp:Label ID="Label4" runat="server" Text="Please log in first." Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" ForeColor="White"></asp:Label>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Text="Reservations per room type" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" ForeColor="White"></asp:Label>

    <br />

    <asp:GridView ID="GridView1" runat="server" Visible="False" EmptyDataText="No accounts available." Font-Names="Century Gothic" 
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

    <p/>
    <asp:Label ID="Label2" runat="server" Text="Reservations per user" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" ForeColor="White"></asp:Label>

    <br />

    <asp:GridView ID="GridView2" runat="server" Visible="False" EmptyDataText="No accounts available" Font-Names="Century Gothic" 
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

    <p/>
    <asp:Label ID="Label3" runat="server" Text="All reservations" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" ForeColor="White"></asp:Label>

    <br />

   <asp:GridView ID="GridView3" runat="server" Visible="False" EmptyDataText="No accounts available" Font-Names="Century Gothic" 
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
    
    <p/>
        &nbsp;
    
</asp:Content>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            if (Request.Cookies["userInfo"].Values["username"] == "admin")
            {
                Label1.Visible = true;
                Label2.Visible = true;
                Label3.Visible = true;
                GridView1.Visible = true;
                GridView2.Visible = true;
                GridView3.Visible = true;
                

                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = databaseAddress;
                string strSelect = "Select roomType, COUNT(*) FROM Reservations GROUP BY roomType";


                SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
                conn.Open();
                DataTable tbl = new DataTable();
                tbl.Load(cmdSelect.ExecuteReader());

                GridView1.DataSource = tbl;
                GridView1.DataBind();

                GridView1.HeaderRow.Cells[0].Text = "Room Type";
                GridView1.HeaderRow.Cells[1].Text = "Count";

                conn.Close();

                string strSelectB = "Select guest, COUNT(*) FROM Reservations GROUP BY guest";


                SqlCommand cmdSelectB = new SqlCommand(strSelectB, conn);
                conn.Open();
                DataTable tblB = new DataTable();
                tblB.Load(cmdSelectB.ExecuteReader());

                GridView2.DataSource = tblB;
                GridView2.DataBind();

                GridView2.HeaderRow.Cells[0].Text = "Guest";
                GridView2.HeaderRow.Cells[1].Text = "Count";

                conn.Close();

                string strSelectC = "Select* FROM Reservations";


                SqlCommand cmdSelectC = new SqlCommand(strSelectC, conn);
                conn.Open();
                DataTable tblC = new DataTable();
                tblC.Load(cmdSelectC.ExecuteReader());

                GridView3.DataSource = tblC;
                GridView3.DataBind();

                conn.Close();
            }
            else
            {
                Label4.Text = "Available only for the admin";
                Label4.Visible = true;
            }
        }
        else
        {
            Label4.Visible = true;
        }
    }
    
</script>
