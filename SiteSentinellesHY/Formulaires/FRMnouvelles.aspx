<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Formulaires/Site.Master" CodeBehind="FRMnouvelles.aspx.vb" Inherits="SiteSentinellesHY.FRMnouvelles" %>

<%@ Import Namespace="ModeleSentinellesHY" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><%= outils.obtenirLangue("NOUVELLES|NEWS")%></h2>

    <div class="dataPager">
        <asp:DataPager runat="server" ID="dataPagerHaut" PageSize="3" PagedControlID="lvNouvelles" class="btn-group">
            <Fields>
                <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True"
                    ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-default btn-sm btn-datapager" />
                <asp:NumericPagerField CurrentPageLabelCssClass="btn btn-info btn-sm btn-datapager" NumericButtonCssClass="btn btn-default btn-sm btn-datapager" />
                <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True"
                    ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-default btn-sm btn-datapager" />
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
                            <p><b><%# outils.obtenirLangue("Date de rédaction : |Redaction date : ")%></b><%# Left(Eval("dateRedaction"),10)%></p>
                        </div>
                        <div class="clear-both">
                            <br />

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
        <asp:DataPager runat="server" ID="dataPagerBas" PageSize="3" PagedControlID="lvNouvelles" class="btn-group">
            <Fields>
                <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True"
                    ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-default btn-sm btn-datapager" />
                <asp:NumericPagerField CurrentPageLabelCssClass="btn btn-info btn-sm btn-datapager" NumericButtonCssClass="btn btn-default btn-sm btn-datapager" />
                <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True"
                    ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-default btn-sm btn-datapager" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>
