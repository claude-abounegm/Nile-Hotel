﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Staff.Master" AutoEventWireup="true" CodeBehind="staffHome.aspx.cs" Inherits="Nile_Hotel.staffHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #Image1
{
    background-image:url(Hotel.jpg);
    background-size:cover;
}
    </style>

    <asp:Image id="Image1" runat="server"
           AlternateText="Image text"
           ImageAlign="Middle"
           ImageUrl="~/Hotel.jpg"/>
</asp:Content>
