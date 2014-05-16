<%@ Page Title="Événements" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMevenements.aspx.vb" Inherits="SiteSentinellesHY.FRMevenements" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("ÉVÉNEMENTS|EVENTS")%></h2>
    <asp:ListView runat="server"
        ID="lvEvenements"
        DataKeyNames="idEvenement"
        ItemType="ModeleSentinellesHY.Événement"
        SelectMethod="getEvenements">
        <ItemTemplate>
            <div id='<%# Eval("idEvenement")%>' class="listeAccueil">
                <h3><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div>
                            <asp:Label ID="Label1" runat="server"><b><%= outils.obtenirLangue("Date de l'événement : |Event Date : ") %></b><%# Eval("DateEvenementDo")%></asp:Label>
                        </div>
                        <div class="clear-both">
                            <br />
                            <asp:Label ID="lblEvenement1" runat="server" Text='<%# Eval(outils.obtenirLangue("contenuFR|contenuEN"))%>'></asp:Label>
                        </div>
                        <%-- <div class="clear-both">
                            <br />
                            <asp:Label ID="lblDateEvenement" runat="server" Font-Size="smaller"><b><%= outils.obtenirLangue("Date de rédaction : |Redaction Date : ")%></b><%# Left(Eval("dateRedaction"),10) %></asp:Label>
                        </div>--%>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div class="listeAccueil">
                <h3><%= outils.obtenirLangue("Aucun événements|No events")%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div class="clear-both">
                            <h5><% =outils.obtenirLangue("Aucun événements pour le moment.|There's no events at this time.")%></h5>
                        </div>
                    </div>
                </div>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</asp:Content>
