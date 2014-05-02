<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="index.aspx.vb" Inherits="SiteSentinellesHY.index" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%---------------------------------------PENSÉES----------------------------------------------%>
    <div class="textePensee">
        <blockquote>
            <asp:Label ID="lblPenseeAccueil" OnInit="lblPenseeAccueil_Init" runat="server" CssClass="pensee"></asp:Label>
        </blockquote>
    </div>
    
    <%--------------------------------------NOUVELLES----------------------------------------------%>
    <div id="divContantNouvelles" class="listeAccueil" runat="server">
        <h3><%= outils.obtenirLangue("NOUVELLES|NEWS")%></h3>
        <div class="cadrageItems">
            <div class="clear-both">
                <asp:ListView runat="server"
                    ID="lvPremiereNouvellesAccueil"
                    DataKeyNames="idNouvelle"
                    ItemType="ModeleSentinellesHY.Nouvelle"
                    SelectMethod="getPremiereNouvelle">
                    <ItemTemplate>
                        <div>
                            <h5 class="pull-left"><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h5>
                            <h6 class="pull-right"><b><%# outils.obtenirLangue("Date de rédaction : |Redaction date : ") %></b><%# Eval("dateRedaction") %></h6>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblNouvelle" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("contenuFR|contenuEN")),500) & IIf(outils.obtenirLangue("contenuFR|contenuEN").Count > 500, "...", "") %>'></asp:Label>
                        </div>
                        <div class="btnListe">
                            <asp:HyperLink ID="liensListeNouvelle" runat="server" CssClass="btn btn-primary" NavigateUrl='<%# Eval("idNouvelle", "~/Formulaires/FRMnouvelles.aspx#{0}")%>'><%= outils.obtenirLangue("Lire plus|Read more")%></asp:HyperLink>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <h5><% =outils.obtenirLangue("Aucune nouvelle pour le moment.|There's no news at this time.") %></h5>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
            <asp:ListView runat="server"
                ID="lvNouvellesAccueil"
                DataKeyNames="idNouvelle"
                ItemType="ModeleSentinellesHY.Nouvelle"
                SelectMethod="getNouvelles">
                <ItemTemplate>
                    <div class="clear-both">
                        <li style="margin-left: 10px">
                            <h5>
                                <asp:HyperLink ID="hlNouvelles" runat="server" CssClass="liensListe" Text='<%#Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%>' NavigateUrl='<%# Eval("idNouvelle", "~/Formulaires/FRMnouvelles.aspx#{0}" & "   ")%>'>Plus...</asp:HyperLink></h5>
                        </li>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <%--------------------------------------EVENEMENTS------------------------------------------------------%>
    <div id="divContenantEvenement" class="listeAccueil" runat="server">
        <h3><%= outils.obtenirLangue("ÉVÉNEMENTS|EVENTS")%></h3>
        <div class="cadrageItems">
            <div class="clear-both">
                <asp:ListView runat="server"
                    ID="lvPremierEvenementAccueil"
                    DataKeyNames="idEvenement"
                    ItemType="ModeleSentinellesHY.Événement"
                    SelectMethod="getPremierEvenement">
                    <ItemTemplate>
                        <div>
                            <h5 class="pull-left"><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h5>
                            <h6 class="pull-right"><b><%# outils.obtenirLangue("Date de l'événement : |Event Date : ") %></b><%# Eval("DateEvenementDo") %></h6>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblEvenement" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("contenuFR|contenuEN")),500) & IIf(outils.obtenirLangue("contenuFR|contenuEN").Count > 500, "...", "") %>'></asp:Label>
                        </div>
                        <div class="btnListe">
                            <asp:HyperLink ID="liensListeEvenement" runat="server" CssClass="btn btn-primary" NavigateUrl='<%# Eval("idEvenement", "~/Formulaires/FRMevenements.aspx#{0}")%>'><%= outils.obtenirLangue("Lire plus|Read more")%></asp:HyperLink>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <h5><% =outils.obtenirLangue("Aucun événement à venir pour le moment.|There's no event to come at this time.") %></h5>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
            <asp:ListView runat="server"
                ID="lvEvenementAccueil"
                DataKeyNames="idEvenement"
                ItemType="ModeleSentinellesHY.Événement"
                SelectMethod="getEvenements">
                <ItemTemplate>
                    <div class="clear-both">
                        <li style="margin-left: 10px">
                            <h5>
                            <asp:HyperLink ID="hlEvenements" runat="server" CssClass="liensListe" Text='<%#Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%>' NavigateUrl='<%# Eval("idEvenement", "~/Formulaires/FRMevenements.aspx#{0}" & "   ")%>'>Plus...</asp:HyperLink></h5>
                        </li>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <%--------------------------------------REVUE DE PRESSE------------------------------------------------%>
    <div id="divContenantRDP" class="listeAccueil" runat="server">
        <h3><%= outils.obtenirLangue("REVUE DE PRESSE|PRESS REVIEW")%></h3>
        <div class="cadrageItems">
            <div class="clear-both">
                <asp:ListView runat="server"
                    ID="lvPremiereRDPAccueil"
                    DataKeyNames="idRDP"
                    ItemType="ModeleSentinellesHY.RevueDePresse"
                    SelectMethod="getPremiereRDP">
                    <ItemTemplate>
                        <div>
                            <h5 class="pull-left"><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h5>
                            <h6 class="pull-right"><b><%# outils.obtenirLangue("Date de rédaction : |Redaction date : ") %></b><%#  Eval("dateRedaction")%></h6>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblRDP" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("contenuFR|contenuEN")),500) & IIf(outils.obtenirLangue("contenuFR|contenuEN").Count > 500, "...", "") %>'></asp:Label>
                            <div>
                                <asp:Label runat="server"><b><%= outils.obtenirLangue("Lien vers la revue de presse : |Link to the press review : ") %></b></asp:Label>
                                <a target="_blank" href='<%# IIf(Eval("urlDocument").ToString.StartsWith("http"), Eval("urlDocument"), "../Upload/PDF/" & Eval("urldocument"))%>'><%# IIf(Eval("urlDocument").ToString.Count > 75,Left(Eval("urlDocument"),75) & "..." , Eval("urlDocument")) %></a>
                            </div>
                        </div>
                        <div class="btnListe">
                            <asp:HyperLink ID="liensListeRevueDePresse" runat="server" CssClass="btn btn-primary" NavigateUrl='<%# Eval("idRDP", "~/Formulaires/FRMrevuedepresse.aspx#{0}")%>'><%= outils.obtenirLangue("Lire plus|Read more")%></asp:HyperLink>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <h5><% =outils.obtenirLangue("Aucune revue de presse disponible pour le moment.|There's no press review available at this time.") %></h5>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
            <asp:ListView runat="server"
                ID="lvRDPAccueil"
                DataKeyNames="idRDP"
                ItemType="ModeleSentinellesHY.RevueDePresse"
                SelectMethod="getRDP">
                <ItemTemplate>
                    <div class="clear-both">
                        <li style="margin-left: 10px">
                            <h5>
                                <asp:HyperLink ID="hlRDP" runat="server" CssClass="liensListe" Text='<%#Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%>' NavigateUrl='<%# Eval("idRDP", "~/Formulaires/FRMrevuedepresse.aspx#{0}" & "   ")%>'>Plus...</asp:HyperLink></h5>
                        </li>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
