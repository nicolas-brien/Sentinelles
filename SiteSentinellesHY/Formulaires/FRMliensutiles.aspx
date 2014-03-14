<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMliensutiles.aspx.vb" Inherits="SiteSentinellesHY.FRMliensutiles" %>

<%@ Import Namespace="ModeleSentinellesHY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="liensUtiles" runat="server">
        <h2><%= outils.obtenirLangue("LIENS UTILES|HELPFUL LINKS")%></h2>
        <div>
           <ul>
              <%= outils.obtenirLangue("<li><p><b>Association québécoise de prévention du suicide</b><br />Ligne d'aide : 1-866-277-3553<br/>Site internet : <a href='http://www.aqps.info' target='_blank'>www.aqps.info</a></p></li><li><p><b>Centre de prévention du suicide de la Haute-Yamaska</b><br />Téléphone : 450-375-4252</p></li><li><p><b>Ligne Aide Abus Aîné</b><br />Ligne d'aide : 1-888-489-2287<br/>Site internet : <a href='http://www.maltraitanceaines.gouv.qc.ca' target='_blank'>www.maltraitanceaines.gouv.qc.ca</a></p></li><li><p><b>Centre de santé et de services sociaux de la Haute-Yamaska</b><br />Site internet : <a href='http://www.santemonteregie.qc.ca/granby-region/index.fr.html' target='_blank'>www.santemonteregie.qc.ca/granby-region/index.fr.html</a></p></li>|<li><p><b>Quebec Association for Suicide Prevention</b><br />Help Line : 1-866-277-3553<br/>Website : <a href='http://www.aqps.info' target='_blank'>www.aqps.info</a></p></li><li><p><b>Suicide Prevention Center of Haute-Yamaska</b><br />Phone Number : 450-375-4252</p></li><li><p><b>Elder Abuse Help Line</b><br />Help Line : 1-888-489-2287<br/>Website : <a href='http://www.maltraitanceaines.gouv.qc.ca/en/' target='_blank'>www.maltraitanceaines.gouv.qc.ca/en/</a></p></li><li><p><b>Health and Social Services Centres of Haute-Yamaska</b><br />Website : <a href='http://www.santemonteregie.qc.ca/granby-region/index.en.html' target='_blank'>www.santemonteregie.qc.ca/granby-region/index.en.html</a></p></li>")%>
          </ul>
        </div>
    </asp:Label>
</asp:Content>
