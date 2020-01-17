<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="generalQuery.aspx.cs" Inherits="Nile_Hotel.generalQuery" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            if (Request.Cookies["userInfo"].Values["username"] == "admin")
            {
                Label1.Visible = true;
                TextBox1.Visible = true;
                Button1.Visible = true;
            }

            else
            {
                Label2.Text = "Available only for the admin";
                Label2.Visible = true;
            }
        }

        else
        {
            Label2.Visible = true; 
        }
    }
    protected void execute(object sender, EventArgs e)
    {
        GridView1.Visible = false;
        Label3.Visible = false;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";

        SqlCommand cmdSelect = new SqlCommand(TextBox1.Text, conn);

        DataTable tbl = new DataTable();

        try
        {
            conn.Open();
            tbl.Load(cmdSelect.ExecuteReader());
            GridView1.DataSource = tbl;
            GridView1.DataBind();
            GridView1.Visible = true;
            conn.Close();
        }
        catch {
            Label3.Visible = true;
        }
    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label2" runat="server" Text="Please log in first." Visible="False" Font-Names="Century Gothic" ForeColor="White"></asp:Label>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Enter SQL Query" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>
          
&nbsp;&nbsp;&nbsp;
    <br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="182px" TextMode="MultiLine" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;" Width="347px"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Execute" OnClick ="execute" Visible="False" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;"/>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" Visible="False" EmptyDataText="No accounts available, please change your preferences." Font-Names="Century Gothic" 
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
    <asp:Label ID="Label3" runat="server" Text="Wrong Command. Please try again" Visible="False" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label>
    <br />
</asp:Content>
