<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FRMPageErreur.aspx.vb" MasterPageFile="~/Formulaires/Site.Master" Inherits="SiteSentinellesHY.FRMPageErreur" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("Erreur!|Error!")%></h2>
    <p></p>
    <asp:Label ID="FriendlyErrorMsg" runat="server" Text="Label" Font-Size="Large" style="color: red"></asp:Label>
    <p>
        <br />
        <br />
    <a href="index.aspx"><%= outils.obtenirLangue("Retour à la page d'accueil|Back to home page") %></a>
    </p>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div id="MessageErreur" runat="server" style="opacity:0;height:0px;">
        <%= errorMessage%>
    </div>
</asp:Content>
