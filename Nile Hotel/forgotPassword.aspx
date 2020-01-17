<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" ASync="true"  AutoEventWireup="true" CodeBehind="forgotPassword.aspx.cs" Inherits="Nile_Hotel.forgotPassword" %>
<%@ Import Namespace="System.Data.SqlClient"  %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<script runat="server">
    protected void send(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True;";

        string strSelect = "SELECT password FROM Client "
            + " WHERE email = '" + TextBox1.Text + "'";
        
        SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
        SqlDataReader reader;
        try
        {
            conn.Open();

            reader = cmdSelect.ExecuteReader();

            if (reader.Read())
            {
                sendEmail(TextBox1.Text, "Your password: " + reader.GetValue(0));
                reader.Close();
            }

            else
            {
                Label3.Text = "Email does not exist!";
            }
            conn.Close();
        }
        catch (SqlException er){
            Label3.Text = "Something went wrong, retry later. " + er;
        }
    }

    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("nilehotelauc@gmail.com", strEmail);
        msg.Subject = "Nile Hotel Password";
        msg.Body = strMsg;

        SmtpClient Sclient = new SmtpClient("smtp.gmail.com", 587);
        NetworkCredential auth = new NetworkCredential("nilehotelauc@gmail.com", "nilehotel@@");

        Sclient.UseDefaultCredentials = false;
        Sclient.Credentials = auth;
        Sclient.EnableSsl = true;
        try
        {
            Sclient.Send(msg);
            Label3.Text = "Email sent successully! Redirecting";
            Response.Write("<body onload=\"window.open('clientHome.aspx', '_top')\"></body>");
        }
        catch (Exception ex)
        {
            Label3.Text = ex.Message;
        }

    }
    
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 200px;
        }
        .auto-style5 {
            width: 7px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Label ID="Label4" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Forgot Password?" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />
    <table style="width:100%;">
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label2" runat="server" Text="Enter your email below:" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px; width: 200px"></asp:Label>
            </td>
            <td class="auto-style5"></td>
            <td></td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label1" runat="server" Text="Email" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px; width: 200px"></asp:Label>
            </td>
            <td class="auto-style5">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" Width="170px" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 150px"></asp:TextBox>
            </td>
            <td>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox1" ErrorMessage="Invalid email format!" 
                        ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Button ID="Button1" runat="server" Text="Send" OnClick ="send" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 30px"/>
            </td>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Label ID="Label3" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

<script runat="server">
 
</script>