<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FRMForum.aspx.vb" Inherits="SiteSentinellesHY.FRMForum" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Import Namespace="ModeleSentinellesHY" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <title>Les Sentinelles Haute-Yamaska</title>
    <link href="../CSS/bootstrap.css" rel="stylesheet" />
    <link href="../CSS/Forum.css" rel="stylesheet" />
    <link href="../CSS/SiteMaster.css" rel="stylesheet" />
    <link rel="icon" type="image/png" href="../Images/favicon.png" />
    <script src="../CSS/js/jquery.js"></script>
    <script src="../CSS/js/jquery.Jcrop.min.js"></script>
    <script src="../CSS/js/bootstrap.min.js"></script>
    <script src="../CSS/js/scriptGlobal.js"></script>
    <script src="../CSS/js/loading-link.js"></script>
    <link rel="stylesheet" href="../CSS/jquery.Jcrop.css" type="text/css" />

    <script language="Javascript">

        jQuery(function ($) {
            var img = $('#cropbox');
            var width = img.width();
            var height = img.height();
            var ratio = 1 / 1;
            var widthCrop = 0;
            var heightCrop = 0;

            widthCrop = width;
            heightCrop = widthCrop / ratio;

            $('#cropbox').Jcrop({
                onSelect: updateCoords,
                onChange: updateCoords,
                setSelect: [0, (height - heightCrop) / 2, widthCrop, (height + heightCrop) / 2],
                aspectRatio: 1 / 1,
                bgOpacity: .25
            });
        });

        function updateCoords(c) {
            jQuery('#X').val(c.x);
            jQuery('#Y').val(c.y);
            jQuery('#W').val(c.w);
            jQuery('#H').val(c.h);
        };

    </script>

</head>
<body>
    <div itemscope itemtype="http://schema.org/Organization" class="referencement">
        <span itemprop="name">Les Sentinelles Haute-Yamaska</span>
        <span itemprop="description">Les sentinelles sont des adultes qui désirent s’engager de façon volontaire pour agir comme RELAIS entre les personnes suicidaires et les ressources d’aide. Leur rôle peut être comparé à celui des personnes formées en premiers soins : assurer un soutien en attendant que des professionnels prennent la relève.</span>
        <a itemprop="url" href="http://sentinelleshy.ca/Formulaires/index.aspx"></a>
        <a itemprop="image" href="http://sentinelleshy.ca/Images/LogoOfficielHYSmallFR.png"></a>
        <span itemprop="foundingDate">2008-01-01</span>
        <span itemprop="telephone">1-866-277-3553</span>
    </div>
    <script>
        $(document).ready(function () {
            $('.disabled-button').loadingLink("<%= outils.obtenirLangue("Chargement..|Loading...")%>");
        });
    </script>
    <div id="wrapper">
        <form id="form1" runat="server">
            <ajaxToolkit:ToolkitScriptManager ID="tsmTest" runat="server" />
            <%-------------------------------------Header---------------------------------%>
            <div id="header-contenant">
                <asp:ImageButton ID="imgbtnLogo" runat="server" ImageUrl="../Images/LogoOfficielHYSmallFR.png" PostBackUrl="~/Formulaires/index.aspx" />
                <div class="pull-right">
                    <div class="pull-right">
                        <a class="liens" id="lnkAccueil" href="../Formulaires/index.aspx"><%= outils.obtenirLangue("ACCUEIL|HOME")%></a>
                        <asp:Label ID="Label1" runat="server" Text="  |  " CssClass="pipes"></asp:Label>
                        <a class="liens" id="lnkLiensUtiles" href="../Formulaires/FRMliensutiles.aspx"><%= outils.obtenirLangue("LIENS UTILES|HELPFUL LINKS")%></a>
                        <asp:Label ID="Label2" runat="server" Text="  |  " CssClass="pipes"></asp:Label>
                        <a class="liens" runat="server" id="lnkConnexion" data-toggle="modal" href="../Formulaires/FRMForum.aspx"><%= outils.obtenirLangue("ZONE SENTINELLE|SENTINEL AREA")%></a>
                        <asp:Label ID="Label3" runat="server" Text="  |  " CssClass="pipes"></asp:Label>
                        <asp:LinkButton CssClass="liens" ID="lnkAnglais" runat="server" OnClick="lnkAnglais_Click"><%= outils.obtenirLangue("ENGLISH|FRANÇAIS")%></asp:LinkButton>
                    </div>
                    <a runat="server" id="iconSetting" class="pull-right" href="../Formulaires/FRMPanneauDeControle.aspx" visible="false">
                        <img alt="configuration" src="../Images/configuration.png" /></a>
                    <div runat="server" id="divLogin" class="pull-right" visible="false">
                        <a runat="server" id="lblInfoUtilisateur" href="../Formulaires/FRMForum.aspx?view=4"></a>
                        <asp:Label ID="lblPipeLogin" runat="server" Text="  |  "></asp:Label>
                        <asp:LinkButton ID="lnkbtnLogout" runat="server" OnClick="lnkbtnLogout_Click"><%= outils.obtenirLangue(" Déconnexion | Logout ")%></asp:LinkButton>
                    </div>
                    <div class="clear-both pull-right relative">
                        <asp:TextBox ID="tbRecherche" runat="server" ClientIDMode="Static" MaxLength="100"></asp:TextBox>
                        <asp:AutoCompleteExtender ID="ACERecherche" runat="server"
                            MinimumPrefixLength="4"
                            CompletionListCssClass="completionList"
                            CompletionListHighlightedItemCssClass="itemHighlighted"
                            CompletionListItemCssClass="listItem"
                            ServiceMethod="GetCompletionList"
                            TargetControlID="tbRecherche"
                            UseContextKey="True" />
                        <asp:LinkButton ID="btnRecherche" runat="server" OnClick="btnRecherche_Click" ClientIDMode="Static"><i class="icon-search"></i></asp:LinkButton>
                        <script>
                            $('#tbRecherche').keydown(function (event) {
                                if (event.keyCode == 13) {
                                    event.preventDefault();
                                    eval($('#btnRecherche').attr('href'));
                                }
                            });
                        </script>
                    </div>
                </div>
            </div>
            <%---------------------------------End Header---------------------------------%>

            <%-----------------------------------Content----------------------------------%>

            <div id="content">
                <asp:MultiView ID="MultiViewForum" runat="server">
                    <asp:View ID="viewForum_Accueil" runat="server">
                        <div class="row paddingRow">
                            <div class="text-center">
                                <asp:Label runat="server" ID="Label4" CssClass="lblTitreConfig"><%= outils.obtenirLangue("ZONE SENTINELLE|SENTINEL AREA")%></asp:Label>
                            </div>
                            <div class="alert fade in">
                                <a class="close" data-dismiss="alert" href="#">&times;</a>
                                <strong><% =outils.obtenirLangue("ATTENTION!<br />|WARNING!")%></strong>
                                <% =outils.obtenirLangue("Ce forum sert exclusivement au partage d'information. Pour toute urgence, appeler au numéro suivant : 1-866-277-3553 (Centre de Prévention Suicide)|This forum is used exclusively to share information. For emergencies, call the following number : 1-866-277-3553 (Centre de Prévention Suicide)")%>
                            </div>
                            <asp:LinkButton ID="lnkbtnAjouterPublication" runat="server" OnClick="lnkbtnAjouterPublication_Click">
                                <i aria-hidden="true" class="icon-plus-sign"></i><% =outils.obtenirLangue(" Poser une question| Ask a question")%>
                            </asp:LinkButton>
                            <a id="lnkbtnGererCategorie" runat="server" style="margin-left: 30px; cursor: pointer;" data-toggle="collapse" data-target="#gererLesCategories" visible="false">
                                <i aria-hidden="true" class="icon-plus-sign"></i><% =outils.obtenirLangue(" Gérer les catégories| Manage categories")%>
                            </a>
                            <div id="gererLesCategories" class="collapse out" runat="server" visible="false">
                                <hr />
                                <asp:UpdatePanel ID="upCategorie" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="clear-both">
                                            <span id="Span1" runat="server" class="span2 offset1"><%= outils.obtenirLangue("Nom Français|French Name")%></span>
                                            <span id="Span2" runat="server" class="span2 offset2"><%= outils.obtenirLangue("Nom Anglais|English Name")%></span>
                                        </div>
                                        <asp:ListView runat="server"
                                            ID="lvCategorie"
                                            ItemType="ModeleSentinellesHY.Categorie"
                                            SelectMethod="getCategorieAccueil">
                                            <LayoutTemplate>
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="clear-both">
                                                    <div class="span2 offset1">
                                                        <asp:TextBox ID="tbIDCategorie" runat="server" Text='<%# BindItem.idCategorie %>' Visible="false"></asp:TextBox>
                                                        <asp:TextBox ID="tbNomCategorieFR" runat="server" MaxLength="50" Text='<%# BindItem.nomCategorieFR %>' onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                    </div>
                                                    <div class="span2 offset2">
                                                        <asp:TextBox ID="tbNomCategorieEN" runat="server" MaxLength="50" Text='<%# BindItem.nomCategorieEN %>' onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                                    </div>
                                                    <div class="span2 offset2" style="padding-top: 3px">
                                                        <asp:LinkButton ID="lnkbtnSauvegarderCategorie" runat="server" Width="82px" CssClass="btn disabled-button"><%= outils.obtenirLangue("Sauvegarder|Save")%></asp:LinkButton>
                                                        <asp:LinkButton ID="lnkbtnSupprimerCategorie" runat="server"
                                                            CommandArgument='<%# BindItem.idCategorie %>'
                                                            CssClass="pull-right"
                                                            OnClick="lnkbtnSupprimerCategorie_Click">
                                                            <i aria-hidden="true" class="icon-remove"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <div class="clear-both">
                                            <div class="span2 offset1">
                                                <asp:TextBox ID="tbNomCategorieFR" runat="server" MaxLength="50" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                            </div>
                                            <div class="span2 offset2">
                                                <asp:TextBox ID="tbNomCategorieEN" runat="server" MaxLength="50" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                            </div>
                                            <div class="span1 offset2" style="padding-top: 3px">
                                                <asp:LinkButton ID="lnkbtnAjoutCategorie" runat="server" Width="82px" CssClass="btn disabled-button" OnClick="lnkbtnAjoutCategorie_Click"><%= outils.obtenirLangue("Ajouter|Add")%></asp:LinkButton>
                                            </div>
                                        </div>
                                        <div class="clear-both">
                                            <asp:Label runat="server" ID="lblErreurCategorie" CssClass="lblMessageErreur"></asp:Label>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <asp:ListView ID="lviewForum_accueil" runat="server"
                                ItemType="ModeleSentinellesHY.publication"
                                SelectMethod="getPublications_accueilForum"
                                DataKeyNames="idPublication, idCategorie">
                                <LayoutTemplate>

                                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div id="divCategorie" runat="server">
                                        <h3>
                                            <asp:LinkButton ID="lnkBtn_categorie" OnClick="lnkBtn_categorie_Click" CommandArgument='<%# item.Categorie.idCategorie %>' runat="server" class="a_H3Categorie"><%# outils.obtenirLangue(Item.Categorie.nomCategorieFR.ToUpper & "|" &  Item.Categorie.nomCategorieEN.ToUpper)%></asp:LinkButton>
                                        </h3>
                                    </div>
                                    <div id="divCadrageItems" class="cadrageItems">
                                        <div style="float: right; width: 18%">
                                            <asp:Label ID="lblDatePublication" CssClass="lblInfoPublication" runat="server"><%# "Créé le " + Eval("DatePublication","{0:d MMMM, yyyy}")%></asp:Label><br />
                                            <asp:Label ID="lblPubliePar" CssClass="lblInfoPublication" runat="server"></asp:Label>
                                        </div>
                                        <img id="pinnedIcon" runat="server" src="../Images/icon-pin.png" class="pull-left" style="display: none;" />
                                        <div style="margin-left: 40px;">
                                            <asp:LinkButton ID="lnkBtn_TitrePublication" CssClass="lnkBtn_TitrePublication" CommandArgument='<%# item.idPublication %>' OnClick="lnkBtn_TitrePublication_Click" runat="server"><%# Item.titre %></asp:LinkButton>
                                            <div>
                                                <asp:Label ID="lblContenuPublication" CssClass="lblContenuPublication" runat="server" Text='<%# Left(Eval("contenu"), 200) & IIf(Item.contenu.Length > 200, "...", "") %>'></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <h5><% =outils.obtenirLangue("Il n'y a aucune publication dans cette catégorie pour le moment.|There are currently no post in this category.") %></h5>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </div>
                    </asp:View>

                    <asp:View runat="server" ID="viewCategorie">
                        <div class="row paddingRow">
                            <div class="text-center">
                                <asp:Label runat="server" ID="Label5" CssClass="lblTitreConfig"><%= outils.obtenirLangue("ZONE SENTINELLE|SENTINEL AREA")%></asp:Label>
                            </div>

                            <div class="dataPager">
                                <asp:DataPager runat="server" ID="dataPagerHaut" PageSize="10" PagedControlID="lviewCategorie">
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

                            <asp:ListView ID="lviewCategorie" runat="server"
                                ItemType="ModeleSentinellesHY.Publication"
                                SelectMethod="getCategories"
                                DataKeyNames="idPublication, idCategorie">
                                <LayoutTemplate>
                                    <asp:ImageButton ID="imgbtnRetour" ImageUrl="~/Images/flecheRetour.png" runat="server" CssClass="imgbtnRetour" AlternateText="Page précédente" ToolTip="Page précédente" OnClick="retourAccueil_Click" />
                                    <asp:LinkButton ID="lnkBtnRetour" PostBackUrl="~/Formulaires/FRMForum.aspx" CssClass="lnkBtnRetour" runat="server" OnClick="retourAccueil_Click"><%= outils.obtenirlangue("Retour|Back") %></asp:LinkButton>
                                    <asp:LinkButton ID="lnkbtnAjouterPublication" CssClass="lnkbtnAjouterPublication_categorie" runat="server" OnClick="lnkbtnAjouterPublication_Click">
                                <i aria-hidden="true" class="icon-plus-sign"></i><% =outils.obtenirLangue(" Poser une question| Ask a question")%>
                                    </asp:LinkButton>
                                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div id="divCategorie1" runat="server">
                                        <h3>
                                            <asp:LinkButton ID="lnkBtn_categorie" OnClick="lnkBtn_categorie_Click" CommandArgument='<%# item.Categorie.idCategorie %>' runat="server" class="a_H3Categorie"><%# outils.obtenirLangue(Item.Categorie.nomCategorieFR.ToUpper & "|" &  Item.Categorie.nomCategorieEN.ToUpper)%></asp:LinkButton>
                                        </h3>
                                    </div>
                                    <div id="divCadrageItems" class="cadrageItems">
                                        <div style="float: right;">
                                            <asp:Label ID="lblDatePublication" CssClass="lblInfoPublication" runat="server"><%# Eval("DatePublication","{0:MMMM d, yyyy}")%></asp:Label><br />
                                            <asp:Label ID="lblPubliePar" CssClass="lblInfoPublication" runat="server"></asp:Label>
                                        </div>
                                        <img id="pinnedIcon" runat="server" src="../Images/icon-pin.png" class="pull-left" style="display: none;" />
                                        <div style="margin-left: 40px;">
                                            <asp:LinkButton ID="lnkBtn_TitrePublication" CssClass="lnkBtn_TitrePublication" CommandArgument='<%# item.idPublication %>' OnClick="lnkBtn_TitrePublication_Click" runat="server"><%# Item.titre %></asp:LinkButton>
                                            <div>
                                                <asp:Label ID="lblContenuPublication" CssClass="lblContenuPublication" runat="server"><%# Left(Item.contenu, 200)%></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <h5><% =outils.obtenirLangue("Il n'y a aucune publication dans cette catégorie pour le moment.|There are currently no posts in this category for the moment.") %></h5>
                                </EmptyDataTemplate>
                            </asp:ListView>
                            <div class="dataPager">
                                <asp:DataPager runat="server" ID="dataPagerBas" PageSize="10" PagedControlID="lviewCategorie">
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
                        </div>
                    </asp:View>

                    <asp:View runat="server" ID="viewConsulterPublicaton">
                        <div class="row paddingRow">
                            <div class="text-center">
                                <asp:Label runat="server" ID="Label6" CssClass="lblTitreConfig"><%= outils.obtenirLangue("ZONE SENTINELLE|SENTINEL AREA")%></asp:Label>
                            </div>
                            <div class="row paddingRow">
                                <div class="div_BoutonsRetour">
                                    <asp:ImageButton ID="imgbtnRetour" ImageUrl="~/Images/flecheRetour.png" runat="server" CssClass="imgbtnRetour" AlternateText="Page précédente" OnClick="retourCategorie_Click" />
                                    <asp:LinkButton ID="lnkBtnRetour" CssClass="lnkBtnRetour" runat="server" OnClick="retourCategorie_Click"><%= outils.obtenirlangue("Retour|Back") %></asp:LinkButton>
                                </div>

                                <div class="dataPager">
                                    <asp:DataPager runat="server" ID="dataPagerHautPubs" PageSize="15" PagedControlID="lviewConsulterPublication">
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

                                <asp:ListView runat="server" ID="lviewConsulterPublication"
                                    ItemType="ModeleSentinellesHY.Publication"
                                    DataKeyNames="idPublication"
                                    UpdateMethod="UpdatePublication"
                                    DeleteMethod="DeletePublication"
                                    SelectMethod="getConsulterPublication">

                                    <LayoutTemplate>

                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                        <div class="div_messageErreurReponse">
                                            <asp:Label ID="lblMessageErreurReponse" runat="server" CssClass="lblMessageErreur"></asp:Label>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div id="divPublication" class="clear-both">
                                            <div id="divModifierPublication" class="pull-right" runat="server">
                                                <asp:LinkButton ID="lnkModal" runat="server"
                                                    href='<%# String.format("#Supprimer{0}",Eval("idPublication")) %>'
                                                    role="button"
                                                    data-toggle="modal">
                                                <i aria-hidden="true" class="icon-remove"></i></asp:LinkButton>
                                                <%--fenetre modal--%>
                                                <div id='<%# "Supprimer" & Eval("idPublication") %>' class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-header">
                                                        <a class="close" data-dismiss="modal" aria-hidden="true" onclick="btnClose_Click()">×</a>
                                                        <asp:Label ID="Label9" runat="server" CssClass="modalTitle"><%= outils.obtenirLangue("ATTENTION !|WARNING !")%></asp:Label>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p><% =outils.obtenirLangue("Vous êtes sur le point de supprimer cette publication. Souhaitez-vous continuez?|You are about to delete this post. Would you like to continue?")%></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button class="btn" data-dismiss="modal" aria-hidden="true"><% =outils.obtenirLangue("Annuler|Cancel")%></button>
                                                        <asp:LinkButton ID="btnSupprimerNouv" runat="server" CommandName="Delete" class="btn btn-primary"><% =outils.obtenirLangue("Supprimer|Delete")%></asp:LinkButton>
                                                    </div>
                                                </div>
                                                <asp:LinkButton ID="lnkbtnModifier" runat="server"
                                                    href='<%# String.format("#Modifier{0}",Eval("idPublication")) %>'
                                                    role="button"
                                                    data-toggle="modal"
                                                    CommandArgument="<%# Item.idParent %>">
                                                <i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>
                                                <%--fenetre modal--%>
                                                <div id="divmodale" runat="server">
                                                    <div id='<%# "Modifier" & Eval("idPublication") %>' class="modal hide fade modalModifierPublication" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                        <div class="modal-header">
                                                            <a class="close" data-dismiss="modal" aria-hidden="true">×</a>
                                                            <asp:Label ID="Label4" runat="server" CssClass="modalTitle"><%= outils.obtenirLangue("MODIFICATION|EDIT")%></asp:Label>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div style="height: 280px;">
                                                                <div>
                                                                    <div>
                                                                        <asp:Label ID="lblTitre" runat="server" Font-Bold="true">Titre</asp:Label><br />
                                                                        <asp:TextBox ID="txtboxTitre" Enabled="<%# If(Item.idParent is Nothing,true,false) %>" CssClass="txtboxTitreModal" Text='<%# BindItem.titre%>' runat="server" />
                                                                    </div>
                                                                    <div id="divPinned" runat="server" class="pull-right" style="position: relative; top: 7px;">
                                                                        <asp:CheckBox ID="cbPinned" runat="server" Style="margin: auto auto 5px 20px;" Checked='<%# BindItem.epinglee%>' />
                                                                        <asp:Label ID="lblPinned" runat="server" Style="position: relative; top: 3px;"><%= outils.obtenirLangue("Publication épinglée|Pinned post") %></asp:Label>
                                                                    </div>
                                                                </div>
                                                                <div class="clear-both">
                                                                    <asp:Label ID="lblContenu" runat="server" Font-Bold="true">Contenu de la publication</asp:Label>
                                                                    <asp:TextBox ID="txtboxcontenu" runat="server" CssClass="txtBoxHtmlEditor" Text='<%# BindItem.contenu %>' TextMode="MultiLine"></asp:TextBox>
                                                                    <asp:HtmlEditorExtender ID="htmleditorMessage" runat="server" TargetControlID="txtboxcontenu">
                                                                        <Toolbar>
                                                                            <ajaxToolkit:Undo />
                                                                            <ajaxToolkit:Redo />
                                                                            <ajaxToolkit:Bold />
                                                                            <ajaxToolkit:Italic />
                                                                            <ajaxToolkit:Underline />
                                                                            <ajaxToolkit:StrikeThrough />
                                                                            <ajaxToolkit:InsertUnorderedList />
                                                                            <ajaxToolkit:CreateLink />
                                                                            <ajaxToolkit:UnLink />
                                                                            <ajaxToolkit:RemoveFormat />
                                                                            <ajaxToolkit:SelectAll />
                                                                            <ajaxToolkit:UnSelect />
                                                                            <ajaxToolkit:Delete />
                                                                            <ajaxToolkit:Cut />
                                                                            <ajaxToolkit:Copy />
                                                                            <ajaxToolkit:Paste />
                                                                            <ajaxToolkit:Indent />
                                                                            <ajaxToolkit:Outdent />
                                                                            <ajaxToolkit:InsertHorizontalRule />
                                                                            <ajaxToolkit:HorizontalSeparator />
                                                                        </Toolbar>
                                                                    </asp:HtmlEditorExtender>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <asp:UpdatePanel ID="upModifierPublication" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <div class="modal-footer">
                                                                    <button class="btn" data-dismiss="modal" aria-hidden="true"><% =outils.obtenirLangue("Annuler|Cancel")%></button>
                                                                    <asp:LinkButton ID="lnkbtnModifierPublication" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "DataItemIndex") %>' OnClick="lnkbtnModifierPublication_Click" class="btn btn-primary disabled-button"><% =outils.obtenirLangue("Sauvegarder|Save")%></asp:LinkButton>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <div>
                                                                        <asp:Label runat="server" ID="lblMessageErreurModifierPublication" ClientIDMode="Static" class="text-error pull-left" />
                                                                    </div>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divNomCategorie" class="divNomCategorie" runat="server">
                                                <asp:Label ID="lblNomCategorie" CssClass="lblNomCategorie" runat="server"><%# outils.obtenirLangue(Item.Categorie.nomCategorieFR.ToUpper & "|" &  Item.Categorie.nomCategorieEN.ToUpper)%></asp:Label>
                                            </div>
                                            <hr class="clear-both margin_ReponsePublication" />
                                            <img id="pinnedIcon" runat="server" src="../Images/icon-pin.png" style="display: none;" />
                                            <div id="divTitrePublication" class="divTitrePublication" runat="server">
                                                <b>
                                                    <asp:Label ID="lblTitrePublication" CssClass="lblTitrePublication" runat="server"><%# Item.titre%></asp:Label></b>
                                            </div>

                                            <div class="pull-right divInfoPublication">
                                                <div>
                                                    <asp:Image ID="imgAvatar" CssClass="Avatar_Publication thumbnail" runat="server" />
                                                </div>
                                                <div>
                                                    <asp:Label ID="lblDatePublication" CssClass="lblInfoReponsePublication" runat="server"><%# Eval("DatePublication","{0:MMMM d, yyyy}")%></asp:Label><br />
                                                    <asp:Label ID="lblPubliePar" CssClass="lblInfoReponsePublication" runat="server"></asp:Label><br />
                                                    <asp:Label ID="lblStatut" runat="server" CssClass="lblInfoReponsePublication"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="pull-right divInfoPublication">
                                            </div>
                                            <div class="divContenu">
                                                <asp:Label runat="server" ID="lblContenuReponse" Text='<%# Eval("contenu")  %>' />
                                            </div>
                                            <div class="clear-both">
                                            </div>
                                            <hr class="clear-both margin_ReponsePublication" />
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>

                                <div class="dataPager">
                                    <asp:DataPager runat="server" ID="dataPagerBasPubs" PageSize="15" PagedControlID="lviewConsulterPublication">
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

                                <asp:ListView runat="server" ID="lviewAjouterReponse"
                                    ItemType="ModeleSentinellesHY.Publication"
                                    DataKeyNames="idPublication"
                                    SelectMethod="getPublication_ajouterPublication"
                                    UpdateMethod="UpdateAjouterReponse">
                                    <ItemTemplate>
                                        <div class="clear-both">
                                            <div>
                                                <asp:TextBox ID="txtboxcontenu" CssClass="txtBoxHtmlEditor" TextMode="MultiLine" Text="<%# BindItem.contenu%>" runat="server" />
                                                <asp:HtmlEditorExtender ID="htmleditorContenu" runat="server" TargetControlID="txtboxcontenu" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
                                                    <Toolbar>
                                                        <ajaxToolkit:Undo />
                                                        <ajaxToolkit:Redo />
                                                        <ajaxToolkit:Bold />
                                                        <ajaxToolkit:Italic />
                                                        <ajaxToolkit:Underline />
                                                        <ajaxToolkit:StrikeThrough />
                                                        <ajaxToolkit:InsertUnorderedList />
                                                        <ajaxToolkit:CreateLink />
                                                        <ajaxToolkit:UnLink />
                                                        <ajaxToolkit:RemoveFormat />
                                                        <ajaxToolkit:SelectAll />
                                                        <ajaxToolkit:UnSelect />
                                                        <ajaxToolkit:Delete />
                                                        <ajaxToolkit:Cut />
                                                        <ajaxToolkit:Copy />
                                                        <ajaxToolkit:Paste />
                                                        <ajaxToolkit:Indent />
                                                        <ajaxToolkit:Outdent />
                                                        <ajaxToolkit:InsertHorizontalRule />
                                                        <ajaxToolkit:HorizontalSeparator />
                                                    </Toolbar>
                                                </asp:HtmlEditorExtender>
                                            </div>
                                            <div class="boutonPublier">
                                                <asp:LinkButton ID="lnkbtnPublierQuestion" runat="server"
                                                    CssClass="btn btnAjouter clear-both disabled-button"
                                                    CommandName="Update">
                                                            <i aria-hidden="true" class="icon-check disabled-button"></i><% =outils.obtenirLangue(" Publier| Post")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </asp:View>

                    <asp:View runat="server" ID="viewAjouterPublication">
                        <div class="row paddingRow">
                            <div class="encadrerModification">
                                <asp:ListView runat="server" ID="lviewAjouterPublication"
                                    ItemType="ModeleSentinellesHY.Publication"
                                    DataKeyNames="idPublication"
                                    SelectMethod="getPublication_ajouterPublication"
                                    UpdateMethod="UpdateAjouterPublication">
                                    <LayoutTemplate>
                                        <div class="div_BoutonsRetour">
                                            <asp:ImageButton ID="imgbtnRetour" ImageUrl="~/Images/flecheRetour.png" runat="server" CssClass="imgbtnRetour" AlternateText="Page précédente" ToolTip="Page précédente" OnClick="retourAccueil_Click" />
                                            <asp:LinkButton ID="lnkBtnRetour" CssClass="lnkBtnRetour" runat="server" OnClick="retourAccueil_Click"><%= outils.obtenirlangue("Retour|Back") %></asp:LinkButton>
                                        </div>
                                        <div class="div_messageErreurPublication">
                                            <asp:Label ID="lblMessageErreurPublication" runat="server" CssClass="lblMessageErreur"></asp:Label>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="clear-both" style="margin-bottom: 20px;">
                                            <asp:DropDownList ID="ddlstCategorie" runat="server"
                                                DataValueField="idCategorie"
                                                DataTextField="nomCategorie"
                                                SelectMethod="getCategories_AjouterPublication"
                                                ItemType="ModeleSentinellesHY.categorie"
                                                SelectedValue="<%# BindItem.idCategorie %>" CssClass="pull-left">
                                            </asp:DropDownList>
                                            <div id="divPinned" runat="server" class="pull-left">
                                                <asp:CheckBox ID="cbPinned" runat="server" Style="margin: auto auto 5px 20px;" Checked='<%# BindItem.epinglee%>' />
                                                <asp:Label ID="lblPinned" runat="server" Style="position: relative; top: 3px;"><%= outils.obtenirLangue("Publication épinglée|Pinned post") %></asp:Label>
                                            </div>
                                        </div>
                                        <div class="clear-both">
                                            <asp:TextBox ID="txtboxtitre" CssClass="txtboxTitrePublication" onkeydown="return (event.keyCode !=13);" placeHolder="Titre/Title" Text="<%# BindItem.titre%>" runat="server" />
                                            <asp:TextBox ID="txtboxcontenu" CssClass="txtBoxHtmlEditor" TextMode="MultiLine" Text="<%# BindItem.contenu%>" runat="server" />
                                            <asp:HtmlEditorExtender ID="htmleditorContenu" runat="server" TargetControlID="txtboxcontenu">
                                                <Toolbar>
                                                    <ajaxToolkit:Undo />
                                                    <ajaxToolkit:Redo />
                                                    <ajaxToolkit:Bold />
                                                    <ajaxToolkit:Italic />
                                                    <ajaxToolkit:Underline />
                                                    <ajaxToolkit:StrikeThrough />
                                                    <ajaxToolkit:InsertUnorderedList />
                                                    <ajaxToolkit:CreateLink />
                                                    <ajaxToolkit:UnLink />
                                                    <ajaxToolkit:RemoveFormat />
                                                    <ajaxToolkit:SelectAll />
                                                    <ajaxToolkit:UnSelect />
                                                    <ajaxToolkit:Delete />
                                                    <ajaxToolkit:Cut />
                                                    <ajaxToolkit:Copy />
                                                    <ajaxToolkit:Paste />
                                                    <ajaxToolkit:Indent />
                                                    <ajaxToolkit:Outdent />
                                                    <ajaxToolkit:InsertHorizontalRule />
                                                    <ajaxToolkit:HorizontalSeparator />
                                                </Toolbar>
                                            </asp:HtmlEditorExtender>
                                        </div>
                                        <div class="boutonPublier">
                                            <asp:LinkButton ID="lnkbtnPublierQuestion" runat="server"
                                                CssClass="btn btnAjouter disabled-button"
                                                CommandName="Update">
                                                            <i aria-hidden="true" class="icon-check"></i><% =outils.obtenirLangue(" Publier| Post")%></asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </asp:View>

                    <asp:View ID="viewInfoUtilisateur" runat="server">
                        <div class="text-center">
                            <asp:Label runat="server" ID="Label7" CssClass="lblTitreConfig"><%= outils.obtenirLangue("INFORMATIONS PERSONNELLES|PERSONAL INFORMATIONS")%></asp:Label>
                        </div>
                        <div class="encadreInfoUtilisateur" style="margin: 40px;">
                            <asp:ListView runat="server"
                                ID="lvInfoUtilisateur"
                                ItemType="ModeleSentinellesHY.Utilisateur"
                                SelectMethod="getInfoUtilisateur"
                                UpdateMethod="updateInfoUtilisateur"
                                DataKeyName="idUtilisateur">
                                <LayoutTemplate>
                                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    <div class="clear-both" style="padding-top: 10px;">
                                        <asp:Panel ID="divMessageErreur" Style="margin: 0;" Visible="false" CssClass="alert alert-error" runat="server">
                                            <asp:Label ID="lblMessageErreur" runat="server" Text="" />
                                        </asp:Panel>
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>

                                    <%-- Début pour le crop tool --%>



                                    <asp:MultiView runat="server" ID="mvPhotos" ActiveViewIndex="0">
                                        <asp:View runat="server" ID="vSelect">

                                            <div class="clear-both">
                                                <asp:TextBox runat="server" ID="lblIdUtilisateur" Visible="false" Text='<%# BindItem.idUtilisateur%>' />
                                            </div>

                                            <div id="divAvatar" class="pull-left">
                                                <div>
                                                    <asp:ImageButton runat="server" ID="imgUpload" class="pull-left" src='<%# String.Format("../Upload/ImagesProfil/{0}", Eval("UrlAvatar"))%>' OnClientClick="$('[id$=fuplPhoto]').click(); return false;" Style="width: 300px" />

                                                    <div class="pull-right">
                                                        <asp:TextBox ID="tbAvatar" CssClass="tbInfoUtilisateur" ReadOnly="true" Text='<%# BindItem.UrlAvatar%>' runat="server" Style="display: none" />
                                                        <div class="clear-both tbInfoUtilisateur">
                                                            <asp:Button ID="uploadButton" runat="server" Text="Upload" ClientIDMode="Static" OnClick="lnkUpload_Click" Style="display: none" />
                                                        </div>
                                                        <asp:FileUpload runat="server" ID="fuplPhoto" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" onpropertychange="$('[id$=uploadButton]').click(); return false;" onchange="$('[id$=uploadButton]').click(); return false;" />
                                                    </div>

                                                </div>

                                                <div class="clear-both" style="padding-top: 5px;">
                                                    <asp:RadioButtonList ID="rbtnSexe" runat="server" RepeatDirection="Horizontal" CssClass="radio rbtnSexe"
                                                        SelectedValue='<%# BindItem.sexe%>' OnInit="rbtnSexe_Init">
                                                    </asp:RadioButtonList>
                                                    <asp:Label ID="lblSexe" CssClass="pull-right" runat="server" ClientIDMode="Static"><%= outils.obtenirLangue("Sexe :|Gender :")%> </asp:Label>
                                                </div>

                                            </div>

                                            <div class="pull-right">
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbNomUtilisateur" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# Eval("nomUtilisateur")%>' Enabled="false" />
                                                    <asp:Label ID="lblNomUtilisateur" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Nom d'utilisateur :|Username :")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbPrenom" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.prenom%>' />
                                                    <asp:Label ID="lblPrenom" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Prénom :|First name :")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbNom" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.nom%>' />
                                                    <asp:Label ID="lblNom" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Nom :|Last name :")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:DropDownList ID="ddlstType" runat="server" CssClass="tbInfoUtilisateur"
                                                        DataValueField="idStatut"
                                                        DataTextField="nomStatut"
                                                        ItemType="ModeleSentinellesHY.Statut"
                                                        SelectedValue="<%# Item.idStatut%>"
                                                        SelectMethod="getStatutUtilisateur"
                                                        Enabled="false" />
                                                    <asp:Label ID="lblType" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Type d'utilisateur :|User type :")%></asp:Label>
                                                </div>



                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbNoTelephone" placeHolder="123-456-7890" onkeydown="return (event.keyCode!=13);" CssClass="tbInfoUtilisateur" runat="server" Text='<%# BindItem.noTelephone%>' />
                                                    <asp:Label ID="lblTelephone" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("No. téléphone :|Phone number :")%></asp:Label>
                                                </div>

                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbMilieu" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.milieu%>' />
                                                    <asp:Label ID="lblMilieu" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Milieu de travail:|Work place:")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbCourriel" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" placeHolder="abc@microsoft.com" runat="server" Text='<%# BindItem.courriel%>' />
                                                    <asp:Label ID="lblCourriel" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Courriel :|Email :")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbMotDePasse" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" type="password" runat="server" Text='<%# BindItem.motDePasseTemp%>' />
                                                    <asp:Label ID="lblMotDePasse" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Mot de passe:|Password:")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:TextBox ID="tbConfirmer" CssClass="tbInfoUtilisateur" onkeydown="return (event.keyCode!=13);" type="password" runat="server" Text='<%# BindItem.confirmationMotDePasse%>' />
                                                    <asp:Label ID="lblConfirmer" CssClass="lblInfoUtilisateur" runat="server"><%= outils.obtenirLangue("Confirmer le mot de passe:|Confirm password:")%></asp:Label>
                                                </div>
                                                <div class="clear-both">
                                                    <asp:LinkButton ID="btnModifier" runat="server"
                                                        CommandName="Update"
                                                        CssClass="btn btnAjouter disabled-button tbInfoUtilisateur"
                                                        CausesValidation="true"
                                                        ValidationGroup="sommaire">
                                                    <i aria-hidden="true" class="icon-check"></i><%= outils.obtenirLangue(" Mettre à jour| Update")%></asp:LinkButton>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <asp:View runat="server" ID="vCrop" OnActivate="vCrop_Activate">
                                            <div style="text-align: center">

                                                <div style="display: inline-block">
                                                    <asp:Image runat="server" ID="cropbox" Height="250px" ClientIDMode="Static" />

                                                    <asp:HiddenField ID="X" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="Y" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="W" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="H" runat="server" ClientIDMode="Static" />
                                                </div>
                                                <div>
                                                    <asp:Button runat="server" ID="imageRotateLeft" CssClass="rotateImgLeft" OnClick="imageRotateLeft_Click" />
                                                    <asp:Button runat="server" ID="imageRotateRight" CssClass="rotateImgRight" OnClick="imageRotateRght_Click" />
                                                    <asp:Button ID="btCropGo" runat="server" Text="Sauvegarder" CssClass="btn btn-default" OnClick="btCropGo_Click" />
                                                </div>
                                            </div>
                                        </asp:View>
                                    </asp:MultiView>
                                </ItemTemplate>

                            </asp:ListView>
                        </div>
                    </asp:View>

                    <asp:View ID="viewResultatRecherche" runat="server">
                        <div style="margin: 0px 40px 0px 40px;">
                            <div class="text-center">
                                <asp:Label runat="server" ID="lblrechercheAvancee" CssClass="lblTitreConfig"><%= outils.obtenirLangue("RÉSULTAT DE LA RECHERCHE|SEARCH RESULT")%></asp:Label>
                            </div>
                            <div class="clear-both relative">
                                <asp:TextBox ID="tbRechercheAvancee" runat="server" ClientIDMode="Static" Width="508" MaxLength="50"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="ACERechercheAvancee" runat="server"
                                    MinimumPrefixLength="4"
                                    CompletionListCssClass="completionList"
                                    CompletionListHighlightedItemCssClass="itemHighlighted"
                                    CompletionListItemCssClass="listItem"
                                    ServiceMethod="GetCompletionList"
                                    TargetControlID="tbRechercheAvancee"
                                    UseContextKey="True" />
                                <asp:LinkButton ID="btnRechercheAvancee" runat="server" OnClick="btnRechercheAvancee_Click" ClientIDMode="Static"><i class="icon-search"></i></asp:LinkButton>
                                <script>
                                    $('#tbRechercheAvancee').keydown(function (event) {
                                        if (event.keyCode == 13) {
                                            event.preventDefault();
                                            eval($('#btnRechercheAvancee').attr('href'));
                                        }
                                    });
                                </script>
                                <asp:LinkButton ID="btnRechercheAvanceeLarge" runat="server" CssClass="btn btn-primary btnRechercheAvanceeLarge" OnClick="btnRechercheAvancee_Click" ClientIDMode="Static"><%= outils.obtenirLangue("Rechercher|Search") %></asp:LinkButton>
                            </div>
                            <div>
                                <div style="width: 220px;" class="pull-left marginright-40">
                                    <asp:Label runat="server"><b><%= outils.obtenirLangue("Catégories|Categories") %></b></asp:Label>
                                    <asp:DropDownList ID="DDLRechercheAvancee" runat="server" OnInit="DDLRechercheAvancee_Init"></asp:DropDownList>
                                </div>
                                <div style="width: 280px;" class="pull-left marginright-40">
                                    <asp:Label ID="Label8" runat="server"><b><%= outils.obtenirLangue("Date") %></b><br />
                                    </asp:Label>
                                    <asp:Label runat="server" CssClass="pull-left lblRechercheAvancee"><%= outils.obtenirLangue("Du|From") %></asp:Label>
                                    <asp:TextBox ID="tbDateDebut" CssClass="pull-right" onkeydown="return (event.keyCode!=13);" Text="" runat="server" />
                                    <asp:CalendarExtender ID="CETbDateDebut" runat="server" TargetControlID="tbDateDebut" Format="yyyy-MM-dd"></asp:CalendarExtender>
                                    <div class="clear-both">
                                        <asp:Label runat="server" CssClass="pull-left lblRechercheAvancee"><%= outils.obtenirLangue("Jusqu'au|Until") %></asp:Label>
                                        <asp:TextBox ID="tbDateFin" CssClass="pull-right" onkeydown="return (event.keyCode!=13);" Text="" runat="server" OnInit="tbDateFin_Init" />
                                        <asp:CalendarExtender ID="CETbDateFin" runat="server" TargetControlID="tbDateFin" Format="yyyy-MM-dd"></asp:CalendarExtender>
                                    </div>
                                </div>
                                <div class="pull-left">
                                    <asp:Label runat="server" CssClass="pull-left lblRechercheAvancee"><b><%= outils.obtenirLangue("Lieu de recherche|Search place") %></b></asp:Label>
                                    <asp:CheckBoxList ID="CBLRechercheAvancee" CssClass="clear-both checkbox rbtnSexe" runat="server" RepeatDirection="Vertical" OnInit="CBLRechercheAvancee_Init"></asp:CheckBoxList>
                                </div>
                                <asp:UpdatePanel ID="UPRechercheAvancee" runat="server" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnRechercheAvancee" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnRechercheAvanceeLarge" EventName="Click" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="encadreInfoUtilisateur clear-both">
                                            <div class="text-center">
                                                <div class="clear-both">
                                                    <asp:Label ID="lblQuantiteReponse" CssClass="lblTitreConfig" runat="server"></asp:Label>
                                                    <asp:Label ID="lblReponse" CssClass="lblTitreConfig" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="dataPager text-center">
                                                <asp:DataPager runat="server" ID="DPResultatRechercheHaut" PageSize="10" PagedControlID="lvResultatRecherche">
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
                                                ID="lvResultatRecherche"
                                                ItemType="ModeleSentinellesHY.Publication"
                                                DataKeyNames="idPublication"
                                                SelectMethod="getResultatRecherche"
                                                OnDataBound="lvResultatRecherche_DataBound">
                                                <LayoutTemplate>
                                                    <placeholder id="itemPlaceHolder" runat="server"></placeholder>
                                                </LayoutTemplate>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server" CssClass="lblMessageErreur clear-both"><%= outils.obtenirLangue("Aucun résultat! Essayez une recherche plus simple ou avec des critères différents.|No result! Try a simpler search or with other criterias.") %></asp:Label>
                                                </EmptyDataTemplate>
                                                <ItemTemplate>
                                                    <div id="divPublication" class="clear-both">
                                                        <div id="divNomCategorie" class="divNomCategorie" runat="server">
                                                            <asp:Label ID="lblNomCategorie" CssClass="lblNomCategorie" runat="server"><%# outils.obtenirLangue(Item.Categorie.nomCategorieFR.ToUpper & "|" &  Item.Categorie.nomCategorieEN.ToUpper)%></asp:Label>
                                                        </div>
                                                        <hr class="clear-both margin_ReponsePublication" />
                                                        <div id="divTitrePublication" class="divTitrePublication" runat="server">
                                                            <b>
                                                                <asp:LinkButton ID="lnkBtn_TitrePublication" CssClass="lnkBtn_TitrePublication" CommandArgument='<%# item.idPublication %>' OnClick="lnkBtn_TitrePublication_Click" runat="server"><%# Item.titre %></asp:LinkButton>
                                                        </div>
                                                        <div class="pull-right divInfoPublication">
                                                            <div class="pull-left">
                                                                <asp:Label ID="lblDatePublication" CssClass="lblInfoReponsePublication" runat="server"><%# Eval("DatePublication","{0:MMMM d, yyyy}")%></asp:Label><br />
                                                                <asp:Label ID="lblPubliePar" CssClass="lblInfoReponsePublication" runat="server"></asp:Label>
                                                            </div>
                                                            <div class="pull-right div_marginAvatar">
                                                                <asp:Image ID="imgAvatar" CssClass="Avatar_Publication thumbnail" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="divContenu">
                                                            <asp:Label runat="server" ID="lblContenuReponse" Text='<%# Left(Eval("contenu"), 200) & IIf(Item.contenu.Length > 200, "...", "")  %>' />
                                                        </div>
                                                        <div class="clear-both">
                                                        </div>
                                                        <hr class="clear-both margin_ReponsePublication" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:ListView>
                                            <div class="dataPager text-center">
                                                <asp:DataPager runat="server" ID="DPResultatRechercheBas" PageSize="10" PagedControlID="lvResultatRecherche">
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
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
            <%-------------------------------End Content----------------------------------%>

            <%-----------------------------------Footer-----------------------------------%>
            <div id="footer">
                <div class="span6">
                    <div style="height: 135px; width: 500px;">
                        <a href="http://www.santemonteregie.qc.ca/granby-region/index.fr.html" target="_blank">
                            <img id="imgCSSSHY" width="225" class="footerImages" src="../Images/CSSSHY.jpg" />
                        </a>
                        <a>
                            <img id="imgPreventionSuicide" width="225" src="../Images/CPS.jpg" />
                        </a>

                    </div>
                    <div style="width: 550px;">
                        <a href="http://www.cegepgranby.qc.ca/" class="distanceEntreLogo" target="_blank">
                            <img id="imgCegep" width="150" class="footerImages" src="../Images/CGHY.png" />
                        </a>
                        <a href="http://www.aqdr.org/" class="distanceEntreLogo" target="_blank">
                            <img id="imgAQDR" width="150" class="footerImages" src="../Images/AQDR.jpg" />
                        </a>
                        <a href="http://www.servicecanada.gc.ca/" target="_blank">
                            <img id="imgServiceCanada" width="150" class="footerImages" src="../Images/servicecanada.png" />
                        </a>
                    </div>
                </div>
                <div class="span6">
                    <div id="liensNav" class="span3">
                        <b class="p_footer">NAVIGATION</b>
                        <hr class="hr_Footer" />
                        <p>
                            <a id="LnkBtnNavigation_footer" class="lnkBtn_Footer" href="../Formulaires/index.aspx"><%= outils.obtenirLangue("Accueil|Home")%></a>
                        </p>
                        <p>
                            <a id="LnkBtnHistorique_footer" class="lnkBtn_Footer" href="../Formulaires/FRMhistorique.aspx"><%= outils.obtenirLangue("Historique|History")%></a>
                        </p>
                        <p>
                            <a id="LnkBtnNouvelles_footer" class="lnkBtn_Footer" href="../Formulaires/FRMnouvelles.aspx"><%= outils.obtenirLangue("Nouvelles|News")%></a>
                        </p>
                        <p>
                            <a id="LnkBtnEvenement_footer" class="lnkBtn_Footer" href="../Formulaires/FRMevenements.aspx"><%= outils.obtenirLangue("Événements|Events")%></a>
                        </p>
                        <p>
                            <a id="LnkBtnRDP_footer" class="lnkBtn_Footer" href="../Formulaires/FRMrevuedepresse.aspx"><%= outils.obtenirLangue("Revues de presse|Press Reviews")%></a>
                        </p>
                    </div>
                    <div>
                        <b class="p_footer"><%= outils.obtenirLangue("LIENS RAPIDES|QUICK LINKS")%></b>
                        <hr class="hr_Footer" />
                        <p>
                            <asp:LinkButton ID="LnkBtnDevenirSentinelle_footer" CssClass="lnkBtn_Footer" runat="server" href="#ModalDevenirSentinelle" data-toggle="modal"><%= outils.obtenirLangue("Devenir Sentinelle|Become Sentinel")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnInfoSuicide_footer" CssClass="lnkBtn_Footer" runat="server" href="#ModalInfoSuicide" data-toggle="modal"><%= outils.obtenirLangue("Info Suicide|Suicide Information")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnInfoMaltraitance_footer" CssClass="lnkBtn_Footer" runat="server" href="#ModalInfoMaltraitance" data-toggle="modal"><%= outils.obtenirLangue("Info Maltraitance|Elder Abuse Information")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnZoneSentinelle_footer" CssClass="lnkBtn_Footer" runat="server" data-toggle="modal" href="#ModalConnexion"><%= outils.obtenirLangue("Zone Sentinelle|Sentinel Area")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="lnkBtnPageCreateurs" CssClass="lnkBtn_Footer" runat="server" PostBackUrl="~/Formulaires/FRMCreateurs.aspx"><%= outils.obtenirLangue("Page des créateurs|Developer's page")%></asp:LinkButton>
                        </p>
                    </div>
                </div>
                <div style="clear: both;">
                </div>
            </div>

            <%-------------------------------End Footer-----------------------------------%>
        </form>
    </div>
</body>
<script type="text/javascript">
    String.prototype.trunc = String.prototype.trunc ||
    function (n) {
        var test = this;
        return this.length > n ? this.substr(0, n - 1) + '&hellip;' : this + '';
    };
    $('#fuplPhoto').bind('change propertychange', function () {
        $('#nomAvatar').html($('input[type=file]').val().split('\\').pop().trunc(25));
    }

    );

    $('#lnkbtnGererCategorie').click(function () {
        var icon = $(this).find('i');
        if (icon.is('.icon-plus-sign')) {
            icon.removeClass('icon-plus-sign').addClass('icon-minus-sign');
        }
        else
            icon.removeClass('icon-minus-sign').addClass('icon-plus-sign');
    });

</script>
</html>
