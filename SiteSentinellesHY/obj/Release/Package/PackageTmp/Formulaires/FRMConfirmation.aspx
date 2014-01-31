<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMConfirmation.aspx.vb" Inherits="SiteSentinellesHY.FRMConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= ModeleSentinellesHY.outils.obtenirLangue("Formulaire envoyé!|Form sent!")%></h2>
    <br />
    <h4><%= ModeleSentinellesHY.outils.obtenirLangue("Votre formulaire a bien été acheminé à nos responsables et ils vous contacteront sous peu. Merci de l'intérêt que vous portez aux Sentinelles!|Your form has been sent to our managers and they will contact you shortly. Thank you for your interest in the Sentinels!")%></h4>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
