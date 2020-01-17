<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="myProfile.aspx.cs" Inherits="Nile_Hotel.myProfile" %>
<%@ Import Namespace="System.Data.SqlClient"  %>


<script runat="server">

 String databaseAddress = "Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|Database1.mdf;Integrated Security=True;User Instance=True";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCountriesDropDownList();
            getGuestTypesDropDownList();
            getUserData();
        }
    }

    protected void deleteAccount(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;

        string strDelete = "DELETE FROM Client WHERE username = '" + TextBox1.Text + "'";
        SqlCommand cmdDelete = new SqlCommand(strDelete, conn);

        conn.Open();
        cmdDelete.ExecuteNonQuery();
        conn.Close();

        string strDeleteB = "DELETE FROM Reservations WHERE guest = '" + TextBox1.Text + "'";
        SqlCommand cmdDeleteB = new SqlCommand(strDeleteB, conn);
        try
        {
            conn.Open();
            cmdDeleteB.ExecuteNonQuery();
            conn.Close();
            Response.Write("<body onload=\"window.open('signOut.aspx', '_top')\"></body>");
        }
        catch {
            Label10.Text = "Error, you may retry later!";
        }
    }
    protected void update(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = databaseAddress;
        
        string strUpdate = "UPDATE Client SET password = '"
                + TextBox2.Text + "', fname = '"
                + TextBox4.Text + "', lname = '"
                + TextBox5.Text + "', phone = '"
                + TextBox6.Text + "', email = '"
                + TextBox7.Text + "', nationality = '"
                + DropDownList1.SelectedValue + "', guestType = '"
                + DropDownList2.SelectedValue + "' "
                + "WHERE username = '" + TextBox1.Text + "'";


        SqlCommand cmdUpdate = new SqlCommand(strUpdate, conn);

        try
        {
            conn.Open();
            cmdUpdate.ExecuteNonQuery();
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

        catch(SqlException er)
        {
            Label10.Text = "Error, you may retry later! " + er;
        }

    }
    
    protected void getUserData() {

        if (Request.Cookies["userInfo"] != null)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = databaseAddress;
            
            string strSelect = "SELECT * FROM Client "
                + " WHERE username = '" + Request.Cookies["userInfo"].Values["username"]
                + "' AND password = '" + Request.Cookies["userInfo"].Values["password"] + "'";

            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);
            SqlDataReader reader;
            try
            {
                conn.Open();

                reader = cmdSelect.ExecuteReader();

                if (reader.Read())
                {
                    TextBox1.Text = (string)reader.GetValue(1);
                    TextBox2.Text = (string)reader.GetValue(2);
                    TextBox3.Text = (string)reader.GetValue(2);
                    TextBox4.Text = (string)reader.GetValue(3);
                    TextBox5.Text = (string)reader.GetValue(4);
                    TextBox6.Text = (string)reader.GetValue(5);
                    TextBox7.Text = (string)reader.GetValue(6);
                    DropDownList1.SelectedIndex = (int)reader.GetValue(7);
                    DropDownList2.SelectedIndex = (int)reader.GetValue(8);
                    reader.Close();
                }
                conn.Close();
            }
            catch (SqlException er){
                Label10.Text = "Error, you may retry later! " + er;
            }
        }
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
        catch(SqlException er){
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
        catch { }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style7 {
            width: 157px;
            height: 40px;
        }
        .auto-style9 {
            width: 200px;
            height: 40px;
        }
        .auto-style10 {
            height: 40px;
        }
        .auto-style11 {
        height: 40px;
        width: 26px;
    }
        .auto-style12 {
            width: 157px;
            height: 70px;
        }
        .auto-style13 {
            height: 70px;
            width: 26px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <asp:Label ID="Label99" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="MyProfile" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>

    <br />
    <br />
    <br />
    <table style="width:100%;">
        <tr>
            <td class="auto-style7"><asp:Label ID="Label" runat="server" Text="Username" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox1" runat="server" Enabled="False" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label2" runat="server" Text="Password" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" Font-Names="Century Gothic" ForeColor="Red" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Font-Names="Century Gothic" ControlToValidate="TextBox2" ErrorMessage="Invalid password format! (8-20 characters)" 
                    ForeColor="Red" ValidationExpression="\w{8,20}"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label3" runat="server" Text="Retype Password" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Font-Names="Century Gothic" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox3"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox3" runat="server" Font-Names="Century Gothic" TextMode="Password" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:CompareValidator ID="CompareValidator1" runat="server" Font-Names="Century Gothic" ControlToCompare="TextBox2" ControlToValidate="TextBox3" ErrorMessage="Password does not match!" 
                    ForeColor="Red"></asp:CompareValidator>
            </td>
  
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label4" runat="server" Text="First Name" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Font-Names="Century Gothic" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox4" runat="server" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox4" ErrorMessage="Invalid firstname format!" 
                    ForeColor="Red" ValidationExpression="([A-Z][a-z]*\s[A-Z][a-z]*)|([A-Z][a-z]*)" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label5" runat="server" Text="Last Name" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Font-Names="Century Gothic" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox5"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox5" runat="server" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" Font-Names="Century Gothic" ControlToValidate="TextBox5" ErrorMessage="Invalid lastname format!" ForeColor="Red" ValidationExpression="([A-Z][a-z]*\s[A-Z][a-z]*)|([A-Z][a-z]*)"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label6" runat="server" Text="Phone" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox6" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox6" runat="server" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox6" ErrorMessage="Invalid phone number!" 
                    ForeColor="Red" ValidationExpression="01[0-2,5][0-24-9]\d{7}" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label7" runat="server" Text="Email" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox7" Font-Names="Century Gothic"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9"><asp:TextBox ID="TextBox7" runat="server" Font-Names="Century Gothic" style="width: 150px;"></asp:TextBox></td>
            <td class="auto-style10">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox7" ErrorMessage="Invalid email format!" 
                    ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Names="Century Gothic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7"><asp:Label ID="Label8" runat="server" Text="Country" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;"></asp:Label></td>
            <td class="auto-style11">
                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="*" ControlToValidate="DropDownList1" MinimumValue="1" ForeColor="Red" MaximumValue="250" Type ="Integer" Font-Names="Century Gothic"></asp:RangeValidator>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="128px" AppendDataBoundItems="true" Font-Names="Century Gothic" style="width: 155px; height: 20px"> 
                    <asp:ListItem Selected="True">Select</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style10"> &nbsp; </td>
        </tr>
        <tr>
            <td class="auto-style7"> <asp:Label ID="Label9" runat="server" Text="Guest Type" Font-Names="Century Gothic" ForeColor="White" style="margin-left: 15px; margin-bottom: 15px;" ></asp:Label> </td>
            <td class="auto-style11">
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="*" ControlToValidate="DropDownList2" MinimumValue="1" ForeColor="Red" MaximumValue="3" Type ="Integer" Font-Names="Century Gothic"></asp:RangeValidator>

            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="DropDownList2" runat="server" Height="16px" Width="128px" AppendDataBoundItems="true" Font-Names="Century Gothic" style="width: 155px; height: 20px"> 
                    <asp:ListItem Selected="True">Select</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style10"></td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:Button ID="Button1" runat="server" Text="Update" OnClick="update" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;"/>
            </td>
            <td class="auto-style13">
                &nbsp;</td>
            <td>
                <asp:Button ID="Button2" runat="server" Text="Delete Account" OnClick ="deleteAccount" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px;"/>
                </td>
        </tr>
    </table>
    <p>
            <asp:Label ID="Label10" runat="server" Text="" Font-Names="Century Gothic" ForeColor="White"></asp:Label>
        </p>
</asp:Content>
