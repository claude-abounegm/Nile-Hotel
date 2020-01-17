<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="signOut.aspx.cs" Inherits="Nile_Hotel.signOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    </asp:Content>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
{
    if (Request.Cookies["userInfo"] != null)
    {
        HttpCookie currentUserCookie = HttpContext.Current.Request.Cookies["userInfo"];
        HttpContext.Current.Response.Cookies.Remove("userInfo");
        currentUserCookie.Expires = DateTime.Now.AddDays(-10);
        currentUserCookie.Value = null;
        HttpContext.Current.Response.SetCookie(currentUserCookie);
        
        Response.Write("<body onload=\"window.open('clientHome.aspx', '_top')\"></body>");
    }
    
}
</script>