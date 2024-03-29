﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMrevuedepresse.aspx.vb" Inherits="SiteSentinellesHY.FRMrevuedepresse" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("REVUES DE PRESSE|PRESS REVIEW")%></h2>
    <asp:ListView runat="server"
        ID="lvRevueDePresse"
        DataKeyNames="idRDP"
        ItemType="ModeleSentinellesHY.RevueDePresse"
        SelectMethod="getRevueDePresse">
        <ItemTemplate>
            <div id='<%# Eval("idRDP")%>' class="listeAccueil">
                <h3><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div>
                            <p><b><%# outils.obtenirLangue("Date de rédaction : |Redaction date : ")%></b><%# Eval("DateRedactionDo")%></p>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblRDP1" runat="server" Text='<%# Eval(outils.obtenirLangue("contenuFR|contenuEN"))%>'></asp:Label>
                        </div>
                        <div>
                            <h6><%= outils.obtenirLangue("Lien vers la revue de presse|Link to the press review") %></h6>
                            <a target="_blank" href='<%# IIf(Eval("urlDocument").ToString.StartsWith("http"), Eval("urlDocument"), "../Upload/PDF/" & Eval("urldocument"))%>'><%# IIf(Eval("urlDocument").ToString.Count > 75,Left(Eval("urlDocument"),75) & "..." , Eval("urlDocument")) %></a>

                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div class="listeAccueil">
                <h3><%= outils.obtenirLangue("Aucune revue de presses|No Press reviews")%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div class="clear-both">
                            <h5><% =outils.obtenirLangue("Aucune revue de presses pour le moment.|There's no press review at this time.") %></h5>
                        </div>
                    </div>
                </div>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</asp:Content>
