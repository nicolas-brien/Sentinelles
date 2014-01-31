<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMmaltraitance.aspx.vb" Inherits="SiteSentinellesHY.FRMmaltraitance" %>

<%@ Import Namespace="ModeleSentinellesHY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("MALTRAITANCE|ELDER ABUSE")%></h2>
    <asp:Label ID="textMaltraitance" runat="server" OnInit="textMaltraitance_Init"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
