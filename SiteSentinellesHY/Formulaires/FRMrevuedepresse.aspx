<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMrevuedepresse.aspx.vb" Inherits="SiteSentinellesHY.FRMrevuedepresse" %>
<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2><%= outils.obtenirLangue("REVUES DE PRESSE|PRESS REVIEW")%></h2>
    <div class="dataPager">
        <asp:DataPager runat="server" ID="dataPagerHaut" PageSize="3" PagedControlID="lvRevueDePresse">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="liensListe" FirstPageText="&lt;&lt;"
                    ShowFirstPageButton="true"
                    ShowNextPageButton="false"
                    ShowPreviousPageButton="false" />
                <asp:NumericPagerField NumericButtonCssClass="liensListe" />
                <asp:NextPreviousPagerField ButtonCssClass="liensListe" LastPageText="&gt;&gt;"
                    ShowLastPageButton="true"
                    ShowNextPageButton="false"
                    ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>
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
                            <h6><%# Left(Eval("dateRedaction"),10)%></h6>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblRDP1" runat="server" Text='<%# Eval(outils.obtenirLangue("contenuFR|contenuEN"))%>'></asp:Label>
                        </div>
                        <div>
                            <h6><%= outils.obtenirLangue("Lien vers la revue de presse|Link to the press review") %></h6>
                            <a target="_blank" href='<%# IIf(Eval("urlDocument").ToString.Contains("http://"), Eval("urlDocument"), "../Upload/" & Eval("urldocument"))%>'><%# Eval("urlDocument") %></a>
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
    <div class="dataPager">
        <asp:DataPager runat="server" ID="dataPagerBas" PageSize="3" PagedControlID="lvRevueDePresse">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="liensListe" FirstPageText="&lt;&lt;"
                    ShowFirstPageButton="true"
                    ShowNextPageButton="false"
                    ShowPreviousPageButton="false" />
                <asp:NumericPagerField NumericButtonCssClass="liensListe" />
                <asp:NextPreviousPagerField ButtonCssClass="liensListe" LastPageText="&gt;&gt;"
                    ShowLastPageButton="true"
                    ShowNextPageButton="false"
                    ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>