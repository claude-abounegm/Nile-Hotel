﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="accountsList.aspx.cs" Inherits="Nile_Hotel.accountsList" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <p>
    <asp:Label ID="Label1" runat="server" Text="Please log in first." Visible="False" Font-Names="Century Gothic" ForeColor="White"></asp:Label>
</p>
     <p>
         <asp:Label ID="Label2" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Accounts List" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>
         
</p>
<p>
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
</p>
     <p>
         &nbsp;</p>
</asp:Content>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["userInfo"] != null)
        {
            if (Request.Cookies["userInfo"].Values["username"] == "admin")
            {
                Label2.Visible = true;
                GridView1.Visible = true;
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = databaseAddress;
                string strSelect = "Select* FROM Client";
                SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
                try
                {
                    conn.Open();
                    DataTable tbl = new DataTable();
                    tbl.Load(cmdSelect.ExecuteReader());

                    GridView1.DataSource = tbl;
                    GridView1.DataBind();
                    conn.Close();
                }
                catch (SqlException er){
                    Label1.Text = "Something went wrong " + er;
                    Label1.Visible = true;
                }
            }
            else {
                Label1.Text = "Available only for the admin";
                Label1.Visible = true;
            }
        }
        else {
            Label1.Visible = true;
        }
    }
    
</script>
