<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="Nile_Hotel.signUp" %>
<%@ Import Namespace="System.Data.SqlClient"  %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style4 {
            height: 40px;
        }
        .auto-style5 {
            height: 40px;
        }
        .auto-style6 {
            height: 40px;
        }
        .auto-style7 {
            height: 40px;
        }
        .auto-style8 {
            height: 40px;
        }
        .auto-style9 {
            height: 40px;
        }
        .auto-style10 {
            height: 40px;
        }
        .auto-style11 {
            height: 40px;
        }
        .auto-style12 {
            height: 40px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label410" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Sign Up" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />
    <table>
            <tr>
                <td class="auto-style12"><asp:Label ID="Label2" runat="server" Text="Username" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style12">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style12"><asp:TextBox ID="TextBox1" runat="server" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style12">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Invalid username format! (8-20 characters)" 
                        ForeColor="Red" ValidationExpression="\w{8,20}" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style11"><asp:Label ID="Label3" runat="server" Text="Password" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style11">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox2" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style11"><asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style11">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Invalid password format! (8-20 characters)" 
                        ForeColor="Red" ValidationExpression="\w{8,20}" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style10"><asp:Label ID="Label4" runat="server" Text="Retype Password" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox3" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style10"><asp:TextBox ID="TextBox3" runat="server" TextMode="Password" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style10">
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBox2" ControlToValidate="TextBox3" ErrorMessage="Password does not match!" 
                        ForeColor="Red" Font-Names="Century Gothic"></asp:CompareValidator>
                </td>
  
            </tr>
            <tr>
                <td class="auto-style9"><asp:Label ID="Label5" runat="server" Text="First Name" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox4" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style9"><asp:TextBox ID="TextBox4" runat="server" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style9">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox4" ErrorMessage="Invalid firstname format!" 
                        ForeColor="Red" ValidationExpression="([A-Z][a-z]*\s[A-Z][a-z]*)|([A-Z][a-z]*)" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style8"><asp:Label ID="Label6" runat="server" Text="Last Name" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style8">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox5" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style8"><asp:TextBox ID="TextBox5" runat="server" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style8">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="TextBox5" ErrorMessage="Invalid lastname format!" Font-Names="Century Gothic" ForeColor="Red" ValidationExpression="([A-Z][a-z]*\s[A-Z][a-z]*)|([A-Z][a-z]*)"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style7"><asp:Label ID="Label7" runat="server" Text="Phone" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox6" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style7"><asp:TextBox ID="TextBox6" runat="server" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style7">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox6" ErrorMessage="Invalid phone number! (01XXXXXXXX - 11numbers)" 
                        ForeColor="Red" ValidationExpression="01[0-2,5][0-24-9]\d{7}" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style6"><asp:Label ID="Label8" runat="server" Text="Email" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox7" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style6"><asp:TextBox ID="TextBox7" runat="server" Font-Names="Century Gothic" style="width:150px"></asp:TextBox></td>
                <td class="auto-style6">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox7" ErrorMessage="Invalid email format!" 
                        ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style5"><asp:Label ID="Label9" runat="server" Text="Country" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
                <td class="auto-style5">
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="*" ControlToValidate="DropDownList1" MinimumValue="1" ForeColor="Red" MaximumValue="250" Type ="Integer" Font-Names="Century Gothic"></asp:RangeValidator>
                </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true" Font-Names="Century Gothic" style="width: 155px; height: 20px"> 
                        <asp:ListItem Selected="True">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style5"> &nbsp; </td>
            </tr>
            <tr>
                <td class="auto-style4"> <asp:Label ID="Label10" runat="server" Text="Guest Type" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label> </td>
                <td class="auto-style4">
                     <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="*" ControlToValidate="DropDownList2" MinimumValue="1" ForeColor="Red" MaximumValue="3" Type ="Integer"></asp:RangeValidator>

                </td>
                <td class="auto-style4">
                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="true" Font-Names="Century Gothic" style="width: 155px; height: 20px"> 
                        <asp:ListItem Selected="True">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style4"></td>
            </tr>
        </table>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Sign Up" OnClick="signUp" Font-Names="Century Gothic" style="margin-left: 190px; margin-bottom: 15px;"/>
        </p>
        <p>
            <asp:Label ID="Label11" runat="server" Text="" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label>
        </p>
</asp:Content>

<script runat="server">

    String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        getCountriesDropDownList();
        getGuestTypesDropDownList();
    }

    protected void getCountriesDropDownList() {
        
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;

        string getCountries = "Select * FROM Nationality";
        SqlCommand cmdselect = new SqlCommand(getCountries, conn);
        SqlDataReader countries;
        try
        {
            conn.Open();
            countries = cmdselect.ExecuteReader();
            if (countries.HasRows)
            {
                DropDownList1.DataSource = countries;
                DropDownList1.DataValueField = "id";
                DropDownList1.DataTextField = "country";
                DropDownList1.DataBind();
            }
            conn.Close();
        }
        catch (SqlException er) {
            Label11.Text = "Database error, You may try later! " + er;
        }
    }

    protected void getGuestTypesDropDownList(){

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        
        string getGuestTypes = "Select * FROM GuestType";
        SqlCommand cmdselect = new SqlCommand(getGuestTypes, conn);
        SqlDataReader guestTypes;
        try
        {
            conn.Open();
            guestTypes = cmdselect.ExecuteReader();
            if (guestTypes.HasRows)
            {
                DropDownList2.DataSource = guestTypes;
                DropDownList2.DataValueField = "id";
                DropDownList2.DataTextField = "guestType";
                DropDownList2.DataBind();
            }
            conn.Close();
        }
        catch (SqlException er) {
            Label11.Text = "Database error, You may try later! " + er;
        }
    }

    protected void signUp(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;

        string strInsert = "INSERT INTO Client (username, password, fname, lname, phone, email, nationality, guestType) "
                + " VALUES('" + TextBox1.Text + "', '"
                + TextBox2.Text + "', '"
                + TextBox4.Text + "', '"
                + TextBox5.Text + "', '"
                + TextBox6.Text + "', '"
                + TextBox7.Text + "', '"
                + DropDownList1.SelectedValue + "', '"
                + DropDownList2.SelectedValue + "')";
        
        
        SqlCommand cmdInsert = new SqlCommand(strInsert, conn);

        try
        {
            conn.Open();
            cmdInsert.ExecuteNonQuery();
            conn.Close();
            HttpCookie client = new HttpCookie("userInfo");
            client.Values.Add("username", TextBox1.Text);
            client.Values.Add("password", TextBox2.Text);
            client.Values.Add("fname", TextBox4.Text);
            client.Values.Add("lname", TextBox5.Text);
            client.Expires = DateTime.Now.AddDays(10);
            Response.Cookies.Add(client);
            Response.Write("<body onload=\"window.open('clientHome.aspx', '_top')\"></body>");
        }
        catch (SqlException er)
        {
            if (er.Number == 2627)
                Label11.Text = "Already used username!";
            else
                Label11.Text = "Database error, You may try later!";
        }

        catch
        {
            Label11.Text = "No way to create your account at the moment, you may try again later!";
        }
        sendEmail(TextBox7.Text, "Hello " + TextBox4.Text + " " + TextBox5.Text +", we are pleased to have you with us.");
    }

    protected void sendEmail(string strEmail, string strMsg)
    {

        MailMessage msg = new MailMessage("nilehotelauc@gmail.com", strEmail);
        msg.Subject = "Welcome to Nile Hotel";
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
            Label11.Text = ex.Message;
        }

    }
</script>

