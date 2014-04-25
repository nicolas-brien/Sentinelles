<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMhistorique.aspx.vb" Inherits="SiteSentinellesHY.FRMhistorique" %>

<%@ Import Namespace="ModeleSentinellesHY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
    <link href="../CSS/FRMhistorique.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("HISTORIQUE|HISTORY")%></h2>
    <div class="left">
        <div class="temoignage">
            <h5><%= outils.obtenirLangue("TÉMOIGNAGE|TESTIMONIAL")%></h5>
             <asp:Label ID="temoignageHistorique" runat="server" CssClass="textePensee" OnInit="temoignageHistorique_Init"></asp:Label>
             <div class="text-right">
                 <em style="color: grey">-<%= outils.obtenirLangue("Anonyme|Anonymous")%></em>
             </div>
        </div>
       <asp:Label ID="texteHistorique" runat="server" OnInit="texteHistorique_Init"></asp:Label>
    </div>
</asp:Content>
