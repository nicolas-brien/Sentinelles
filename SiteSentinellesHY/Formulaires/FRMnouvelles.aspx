<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMnouvelles.aspx.vb" Inherits="SiteSentinellesHY.FRMnouvelles" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("NOUVELLES|NEWS")%></h2>

    <div class="dataPager">
        <asp:DataPager runat="server" ID="dataPagerHaut" PageSize="3" PagedControlID="lvNouvelles">
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
        ID="lvNouvelles"
        DataKeyNames="idNouvelle"
        ItemType="ModeleSentinellesHY.Nouvelle" 
        SelectMethod="getFRMNouvelles">
        <ItemTemplate>
            <div id="<%# Eval("idNouvelle")%>" class="listeAccueil">
                <h3><%# Left(Eval(outils.obtenirLangue("titreFR|titreEN")), 50)%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div>
                            <h6><%# Left(Eval("dateRedaction"),10)%></h6>
                        </div>
                        <div class="clear-both">
                            <asp:Label ID="lblNouvelle" runat="server" Text='<%# Eval(outils.obtenirLangue("contenuFR|contenuEN"))%>'></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div class="listeAccueil">
                <h3><%= outils.obtenirLangue("Aucune Nouvelle|No New")%></h3>
                <div class="clear-both">
                    <div class="cadrageItems">
                        <div class="clear-both">
                            <h5><% =outils.obtenirLangue("Aucune nouvelle pour le moment.|There's no news at this time.") %></h5>
                        </div>
                    </div>
                </div>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>

    <div class="dataPager">
        <asp:DataPager runat="server" ID="dataPagerBas" PageSize="3" PagedControlID="lvNouvelles">
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
