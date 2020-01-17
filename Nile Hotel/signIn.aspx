<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="signIn.aspx.cs" Inherits="Nile_Hotel.signIn" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label1" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="LogIn" Style="margin-left: 15px; margin-bottom: 15px; width: 100px; font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />
    <table style="width: 100%;">
        <tr>
            <td class="auto-style1">
                <asp:Label ID="Label2" runat="server" Text="Username" Font-Names="Century Gothic" ForeColor="White" Style="margin-right: 30px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style1">
                <asp:TextBox ID="TextBox1" Font-Names="Century Gothic" runat="server" Style="float: left; width: 150px"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="Label3" runat="server" Text="Password" Font-Names="Century Gothic" ForeColor="White" Style="margin-right: 30px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style1">
                <asp:TextBox ID="TextBox2" runat="server" Font-Names="Century Gothic" TextMode="Password" Style="float: left; width: 150px"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Names="Century Gothic" ForeColor="White" NavigateUrl="~/forgotPassword.aspx">Forgot password?</asp:HyperLink>
            </td>
            <td class="auto-style1">
                <asp:Label ID="Label4" runat="server" Font-Names="Century Gothic" ForeColor="White" Style="float: left; margin-left: 5px"></asp:Label>
            </td>
        </tr>
    </table>

    <br />
    <asp:Button ID="Button1" runat="server" Text="Sign in" OnClick="signIn" Font-Names="Century Gothic" Style="margin-left: 900px; margin-bottom: 15px;" />
    <br />
    <br />
</asp:Content>

<script runat="server">
    protected void signIn(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True;";

        string strSelect = "SELECT * FROM Client "
            + " WHERE username = '" + TextBox1.Text + "'";

        SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
        SqlDataReader reader;
        try
        {
            conn.Open();

            reader = cmdSelect.ExecuteReader();

            if (reader.Read())
            {
                reader.Close();
                strSelect = "SELECT * FROM Client "
                    + "WHERE username = '" + TextBox1.Text + "'"
               + " AND password = '" + TextBox2.Text + "'";

                cmdSelect.CommandText = strSelect;
                reader = cmdSelect.ExecuteReader();

                if (reader.Read())
                {
                    string fname = (string)reader.GetValue(3);
                    string lname = (string)reader.GetValue(4);
                    int staff = (int)reader.GetValue(9);

                    HttpCookie client = new HttpCookie("userInfo");
                    client.Values.Add("username", TextBox1.Text);
                    client.Values.Add("password", TextBox2.Text);
                    client.Values.Add("fname", fname);
                    client.Values.Add("lname", lname);
                    client.Expires = DateTime.Now.AddDays(10);
                    Response.Cookies.Add(client);
                    if (staff == 1)
                        Response.Write("<body onload=\"window.open('staffHome.aspx', '_top')\"></body>");
                    else if (TextBox1.Text == "admin")
                        Response.Write("<body onload=\"window.open('adminHome.aspx', '_top')\"></body>");
                    else
                        Response.Write("<body onload=\"window.open('clientHome.aspx', '_top')\"></body>");
                }

                else
                    Label4.Text = "Invalid Password!";
            }

            else
                Label4.Text = "Invalid Username!";
            conn.Close();
        }
        catch (SqlException er){
            Label4.Text = "Something went wrong! " + er;
        }
    }
</script>