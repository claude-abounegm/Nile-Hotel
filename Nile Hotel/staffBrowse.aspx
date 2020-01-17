<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="staffBrowse.aspx.cs" Inherits="Nile_Hotel.staffBrowse" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

    <asp:Label ID="Label7" runat="server" Font-Names="Century Gothic" ForeColor="White" Text="Browse Rooms" style="margin-left: 15px; margin-bottom: 15px; width: 100px;  font-size: 230%"></asp:Label>
    <br />
    <asp:Label ID="Label11" runat="server" Text="No Access - Please login first." Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 250px" ForeColor="White" Width="264px" Visible="False"></asp:Label>
    <br />
    <br />

    <asp:Label ID="Label1" runat="server" Text="From Date" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White" Visible="False"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox1" runat="server" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px"
        Font-Size="Medium" ForeColor="#000066" Width="176px" Visible="False"></asp:TextBox>

    <ajaxToolkit:CalendarExtender ID="CalendarExtender1"  BehaviorID="CalendarExtender1" runat="server" TargetControlID="TextBox1"/>

    <br />
    <asp:Label ID="Label2" runat="server" Text="To Date" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; width: 100px" ForeColor="White" Visible="False"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox2"></asp:RequiredFieldValidator>
    <asp:TextBox ID="TextBox2" runat="server" Font-Names="Century Gothic" 
        Font-Size="Medium" ForeColor="#000066" Width="176px" style="margin-left: 35px; margin-bottom: 15px" Visible="False"></asp:TextBox>

    <ajaxToolkit:CalendarExtender ID="CalendarExtender2"  BehaviorID="CalendarExtender2" runat="server" TargetControlID="TextBox2"/>

    <br />
    <asp:Label ID="Label3" runat="server" Text="Room Type" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; " ForeColor="White" Height="21px" Visible="False"></asp:Label>
 
    <asp:DropDownList ID="DropDownList1" runat="server" style="margin-left: 20px; margin-bottom: 15px; width: 180px; height: 25px" Visible="False">
        <asp:ListItem Selected="True">Any</asp:ListItem>
        <asp:ListItem>Single</asp:ListItem>
        <asp:ListItem>Double</asp:ListItem>
        <asp:ListItem>Suite</asp:ListItem>
    </asp:DropDownList>

    <br />

    <asp:CompareValidator ID="cmpDates" runat="server" ControlToValidate="TextBox1"
                  SetFocusOnError="true" ControlToCompare="TextBox2"
                  ErrorMessage="End date must be greater than start date"
                  Operator="LessThan"
                  ValidationGroup="vg" Type="Date"                           
                  CultureInvariantValues="true" ForeColor="Red" Font-Names="Century Gothic"
                style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px"></asp:CompareValidator>

    <br />
    <asp:Button ID="Button1" runat="server" Text="Find" OnClick="find" Font-Names="Century Gothic" style="margin-left: 15px; margin-bottom: 15px; margin-top: 15px; width: 150px" Visible="False"/>
    <br />
    <asp:GridView ID="GridView1" runat="server" Visible="False" EmptyDataText="No Rooms available, please change your preferences." Font-Names="Century Gothic" 
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
                    Label2.Visible = true;
                    Label3.Visible = true;
                    Button1.Visible = true;
                    TextBox1.Visible = true;
                    TextBox2.Visible = true;
                    DropDownList1.Visible = true;
                    CalendarExtender1.StartDate = DateTime.Today;
                    CalendarExtender2.StartDate = DateTime.Today;
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
</script>