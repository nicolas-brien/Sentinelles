<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FRMPanneauDeControle.aspx.vb" Inherits="SiteSentinellesHY.FRMPanneauDeControle" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Import Namespace="ModeleSentinellesHY" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <link href="../CSS/bootstrap.css" rel="stylesheet" />
    <link href="../CSS/PanneauDeControle.css" rel="stylesheet" />
    <link href="../CSS/SiteMaster.css" rel="stylesheet" />
    <link rel="icon" type="image/png" href="../Images/LogoOfficielHY.png" />

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
            var ratio = 12 / 5;
            var widthCrop = 0;
            var heightCrop = 0;

            widthCrop = width;
            heightCrop = widthCrop / ratio;

            $('#cropbox').Jcrop({
                onSelect: updateCoords,
                onChange: updateCoords,
                setSelect: [0, (height - heightCrop) / 2, widthCrop, (height + heightCrop) / 2],
                aspectRatio: 12 / 5,
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


    <title>Les Sentinelles Haute-Yamaska</title>

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
            <ajaxToolkit:ToolkitScriptManager ID="tsmTest" runat="server" EnablePageMethods="true" EnableScriptGlobalization="true" EnableScriptLocalization="true" />
            <%-------------------------------------Header---------------------------------%>
            <div id="header2">
                <div id="header-contenant">
                    <asp:ImageButton ID="imgbtnLogo" runat="server" ImageUrl="../Images/LogoOfficielHYSmallFR.png" PostBackUrl="~/Formulaires/index.aspx" />
                    <div class="pull-right">
                        <div class="pull-right">
                            <a class="liens" id="lnkAccueil" href="../Formulaires/index.aspx"><%= outils.obtenirLangue("ACCUEIL|HOME")%></a>
                            <asp:Label ID="Label1" runat="server" Text="  |  " CssClass="pipes"></asp:Label>
                            <a class="liens" id="lnkLiensUtiles" href="../Formulaires/FRMliensutiles.aspx"><%= outils.obtenirLangue("LIENS UTILES|USEFUL LINKS")%></a>
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
                    </div>
                    <div class="text-center">
                        <asp:Label runat="server" ID="lblTitreConfig" CssClass="lblTitreConfig"><%= outils.obtenirLangue("PANNEAU DE CONTRÔLE|CONTROL PANEL")%></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <ul>
                    <asp:linkbutton ID="lnkBtn_EnvoiMessage" CssClass="lnkBtn_EnvoiMessage" runat="server"><!-- No text --></asp:linkbutton>
                    <asp:LinkButton ID="lnkButton_accueil" CssClass="lnkBtn_menuConfig" runat="server"><%= outils.obtenirLangue("GÉNÉRAL|GENERAL")%></asp:LinkButton>
                    <asp:LinkButton ID="lnkButton_nouvelle" CssClass="lnkBtn_menuConfig" runat="server"><%= outils.obtenirLangue("NOUVELLES|NEWS")%></asp:LinkButton>
                    <asp:LinkButton ID="lnkButton_evenement" CssClass="lnkBtn_menuConfig" runat="server"><%= outils.obtenirLangue("ÉVÉNEMENTS|EVENTS")%></asp:LinkButton>
                    <asp:LinkButton ID="lnkButton_revueDePresse" CssClass="lnkBtn_menuConfig" runat="server"><%= outils.obtenirLangue("REVUES DE PRESSE|PRESS REVIEW")%></asp:LinkButton>
                    <asp:LinkButton ID="lnkButton_utilisateur" CssClass="lnkBtn_menuConfig" runat="server"><%= outils.obtenirLangue("UTILISATEURS|USERS")%></asp:LinkButton>
                </ul>
            </div>
            <%---------------------------------End Header---------------------------------%>

            <%-----------------------------------Content----------------------------------%>

            <div id="content">
                <div class="row paddingRow">
                    <asp:MultiView ID="MultiView" runat="server">
                        <asp:View ID="viewOptions" runat="server">
                            <asp:Label ID="lblMessageErreurOptions" CssClass="lblMessageErreur" runat="server" Text="" Style="margin-left: 10px;" />
                            <asp:ListView ID="lviewOptions" runat="server"
                                ItemType="ModeleSentinellesHY.InfoGenerale"
                                SelectMethod="GetInfoGenerale"
                                UpdateMethod="UpdateInfoGenerale"
                                DataKeyNames="idInfo">
                                <LayoutTemplate>
                                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="accordion" id="accordionOptions">
                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapseCourriel"><%= outils.obtenirLangue("Changer l'adresse courriel de l'administrateur|Change the Administrator's email")%>
                                                    </a>
                                                </div>
                                                <div id="collapseCourriel" class="accordion-body collapse in">
                                                    <div class="accordion-inner">
                                                        <div>
                                                            <asp:Label ID="lblcourrielFormulaire" runat="server"><%= outils.obtenirLangue("Adresse courriel de l'administrateur : |Administrator's email : ")%> </asp:Label>
                                                            <asp:TextBox ID="txtboxcourrielFormulaire" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.courrielFormulaire%>' />
                                                        </div>
                                                        <asp:LinkButton ID="lnkbtnCourrielAdmin" runat="server"
                                                            CssClass="btn btn-primary disabled-button"
                                                            CommandName="Update"
                                                            Text="<i aria-hidden=true class=icon-check></i>"><% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapseHistorique">
                                                        <%= outils.obtenirLangue("Modifier l'historique|Edit the history")%>
                                                    </a>
                                                </div>
                                                <div id="collapseHistorique" class="accordion-body collapse">
                                                    <div class="accordion-inner">
                                                        <div>
                                                            <div id="div_lblHistoriqueFR">
                                                                <asp:Label ID="lblHistoriqueFR" runat="server">
                                                                    <%= outils.obtenirLangue("Contenu de l'historique (français) : |History content (French) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxHistoriqueFR" TextMode="MultiLine" CssClass="htmleditorHistorique" runat="server" Text='<%# BindItem.historiqueFR%>' />
                                                            <asp:HtmlEditorExtender ID="htmleditorHistoriqueFR" runat="server" TargetControlID="txtboxHistoriqueFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                                        <hr />
                                                        <div>
                                                            <div id="div_lblHistoriqueEN">
                                                                <asp:Label ID="lblHistoriqueEN" runat="server">
                                                                     <%= outils.obtenirLangue("Contenu de l'historique (anglais) : |History content (english) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxHistoriqueEN" TextMode="MultiLine" CssClass="htmleditorHistorique" runat="server" Text='<%# BindItem.historiqueEN%>' />
                                                            <asp:HtmlEditorExtender ID="htmleditorHistoriqueEN" runat="server" TargetControlID="txtboxHistoriqueEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                                        <div id="div_lnkbtnHistorique">
                                                            <asp:LinkButton ID="lnkbtnHistorique" runat="server"
                                                                CssClass="btn btn-primary disabled-button"
                                                                CommandName="Update"
                                                                Text="<i aria-hidden=true class=icon-check></i>"><% =outils.obtenirLangue(" Sauvegarder| Save")%> </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapseMaltraitance">
                                                        <%= outils.obtenirLangue("Modifier l'information sur la maltraitance|Edit the information on the elderly abuse")%>
                                                        
                                                    </a>
                                                </div>
                                                <div id="collapseMaltraitance" class="accordion-body collapse">
                                                    <div class="accordion-inner">
                                                        <div>
                                                            <div id="div_lblMaltraitanceFR">
                                                                <asp:Label ID="lblMaltraitanceFR" runat="server">
                                                                     <%= outils.obtenirLangue("Contenu de l'information sur la maltraitance (français) : |Content of the information about the elderly abuse (french) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxMaltraitanceFR" TextMode="MultiLine" CssClass="htmleditorMaltraitance" runat="server" Text='<%# BindItem.maltraitanceFR%>' />
                                                            <asp:HtmlEditorExtender ID="htmleditorMaltraitanceFR" runat="server" TargetControlID="txtboxMaltraitanceFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                                        <hr />
                                                        <div>
                                                            <div id="div_lblMaltraitanceEN">
                                                                <asp:Label ID="lblMaltraitanceEN" runat="server">
                                                                    <%= outils.obtenirLangue("Contenu de l'information du la maltraitance (anglais) : |Content of the information about the elderly abuse (english) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxMaltraitanceEN" TextMode="MultiLine" CssClass="htmleditorMaltraitance" runat="server" Text='<%# BindItem.maltraitanceEN%>' />

                                                            <asp:HtmlEditorExtender ID="HtmlEditorExtender1" runat="server" TargetControlID="txtboxMaltraitanceEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                                        <div id="div_lnkbtnMaltraitance">
                                                            <asp:LinkButton ID="lnkbtnMaltraitance" runat="server"
                                                                CssClass="btn btn-primary disabled-button"
                                                                CommandName="Update"
                                                                Text="<i aria-hidden=true class=icon-check></i>"><% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapsePensee">
                                                        <%= outils.obtenirLangue("Modifier la pensée|Edit the thought")%>
                                                        
                                                    </a>
                                                </div>
                                                <div id="collapsePensee" class="accordion-body collapse">
                                                    <div class="accordion-inner">
                                                        <div>
                                                            <asp:Label ID="Label4" CssClass="display_block" runat="server"><%= outils.obtenirLangue("Contenu de la pensée (français) : |Content of the thought (french) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxPenseeFR" CssClass="txtboxPenseeFR" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.penseeFR%>' />
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="Label5" CssClass="display_block" runat="server"><%= outils.obtenirLangue("Contenu de la pensée (english) : |Content of the thought (english) : ")%></asp:Label>
                                                            <asp:TextBox ID="txtboxPenseeEN" CssClass="txtboxPenseeEN" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.penseeEN%>' />
                                                        </div>
                                                        <asp:LinkButton ID="LinkButton4" runat="server"
                                                            CssClass="btn btn-primary disabled-button"
                                                            CommandName="Update"
                                                            Text="<i aria-hidden=true class=icon-check></i>"> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapseTemoignage">
                                                        <%= outils.obtenirLangue("Modifier le témoignage|Edit testimonial")%>
                                                        
                                                    </a>
                                                </div>
                                                <div id="collapseTemoignage" class="accordion-body collapse">
                                                    <div class="accordion-inner">
                                                        <div>
                                                            <asp:Label ID="Label9" CssClass="display_block" runat="server">
                                                                <%= outils.obtenirLangue("Contenu du témoignage (français) : |Content of the testimonial (french) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxtemoignageFR" CssClass="txtboxtemoignageFR" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.temoignageFR%>' />
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="Label6" CssClass="display_block" runat="server">
                                                               <%= outils.obtenirLangue("Contenu du témoignage (anglais) : |Content of the testimonial (english) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxtemoignageEN" runat="server" CssClass="txtboxtemoignageEN" TextMode="MultiLine" Height="40px" Text='<%# BindItem.temoignageEN%>' />
                                                        </div>
                                                        <asp:LinkButton ID="LinkButton5" runat="server"
                                                            CssClass="btn btn-primary disabled-button"
                                                            CommandName="Update"
                                                            Text="<i aria-hidden=true class=icon-check></i>"><% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>


                                            <%-- Carousel Images --%>

                                            <div class="accordion-group">
                                                <div class="accordion-heading">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOptions" href="#collapseCarrousel">
                                                        <%= outils.obtenirLangue("Modifier les images du carrousel|Edit the pictures of the caroussel")%>
                                                        
                                                    </a>
                                                </div>
                                                <asp:MultiView runat="server" ID="mvPhotos" ActiveViewIndex="0">
                                                    <asp:View runat="server" ID="vSelect">
                                                        <div id="collapseCarrousel" class="accordion-body collapse">
                                                            <div class="accordion-inner">
                                                                <div>
                                                                    <asp:Label ID="lblFormatImgMessage" runat="server">
                                                                    </asp:Label>
                                                                </div>
                                                                <div class="marginbottom_divImgCarrousel">
                                                                    <asp:Label ID="Label10" runat="server"><%= outils.obtenirLangue("Image carrousel 1 : |Photo caroussel 1 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel1" Enabled=" false" runat="server" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel1]').click(); return false;" href="#"><%= outils.obtenirLangue("Choisir|Select")%></a>
                                                                    <img id="imgCarrousel1" width="360" src="../Upload/ImagesCarrousel/Carrousel1.jpg" />
                                                                    <asp:FileUpload runat="server" ID="fuplPhotoCarrousel1" ClientIDMode="Static" onpropertychange="$('[id$=uploadButton1]').click(); return false;" onchange="$('[id$=uploadButton1]').click(); return false;" Style="display: none" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                    <asp:Button ID="uploadButton1" runat="server" Text="Carrousel1" ClientIDMode="Static" OnClick="lnkUploadPhotoCarrousel_Click" Style="display: none" />
                                                                </div>
                                                                <div class="marginbottom_divImgCarrousel">
                                                                    <asp:Label ID="Label7" runat="server"> <%= outils.obtenirLangue("Image carrousel 2 : |Photo caroussel 2 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel2" runat="server" Enabled=" false" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel2]').click(); return false;" href="#"><%= outils.obtenirLangue("Choisir|Select")%></a>
                                                                    <img id="imgCarrousel2" width="360" src="../Upload/ImagesCarrousel/Carrousel2.jpg" />
                                                                    <asp:FileUpload runat="server" ID="fuplPhotoCarrousel2" ClientIDMode="Static" onpropertychange="$('[id$=uploadButton2]').click(); return false;" onchange="$('[id$=uploadButton2]').click(); return false;" Style="display: none" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                    <asp:Button ID="uploadButton2" runat="server" Text="Carrousel2" ClientIDMode="Static" OnClick="lnkUploadPhotoCarrousel_Click" Style="display: none" />

                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="Label8" runat="server"> <%= outils.obtenirLangue("Image carrousel 3 : |Photo caroussel 3 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel3" runat="server" Enabled=" false" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel3]').click(); return false;" href="#"><%= outils.obtenirLangue("Choisir|Select")%></a>
                                                                    <img id="imgCarrousel3" width="360" src="../Upload/ImagesCarrousel/Carrousel3.jpg" />
                                                                    <asp:FileUpload runat="server" ID="fuplPhotoCarrousel3" ClientIDMode="Static" onpropertychange="$('[id$=uploadButton3]').click(); return false;" onchange="$('[id$=uploadButton3]').click(); return false;" Style="display: none" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                    <asp:Button ID="uploadButton3" runat="server" Text="Carrousel3" ClientIDMode="Static" OnClick="lnkUploadPhotoCarrousel_Click" Style="display: none" />
                                                                </div>
                                                                <asp:HiddenField ID="nomImage" runat="server" ClientIDMode="Static" />
                                                                <asp:HiddenField ID="nonFileUpdate" runat="server" ClientIDMode="Static" />
                                                            </div>
                                                        </div>
                                                    </asp:View>
                                                    <asp:View runat="server" ID="vCrop" OnActivate="vCrop_Activate">
                                                        <div>

                                                            <asp:Button runat="server" ID="imageRotateLeft" CssClass="rotateImgLeft" OnClick="imageRotateLeft_Click" />
                                                            <asp:Button runat="server" ID="imageRotateRight" CssClass="rotateImgRight" OnClick="imageRotateRght_Click" />
                                                            <br />
                                                            <asp:Image runat="server" ID="cropbox" Width="800px" ClientIDMode="Static" />
                                                            <br />
                                                            <asp:Button ID="btCropGo" runat="server" Text="Sauvegarder" CssClass="btn btn-default" OnClick="btCropGo_Click" />

                                                            <asp:HiddenField ID="X" runat="server" ClientIDMode="Static" />
                                                            <asp:HiddenField ID="Y" runat="server" ClientIDMode="Static" />
                                                            <asp:HiddenField ID="W" runat="server" ClientIDMode="Static" />
                                                            <asp:HiddenField ID="H" runat="server" ClientIDMode="Static" />

                                                        </div>

                                                    </asp:View>
                                                </asp:MultiView>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </asp:View>

                        <asp:View ID="ViewNouvelle" runat="server">
                            <div class="petitsPointsListeUtilisateurs overflow-y" style="max-height: 160px;">
                                <asp:ListView ID="lviewNouvelle" runat="server"
                                    ItemType="ModeleSentinellesHY.nouvelle"
                                    SelectMethod="GetNouvelle"
                                    DataKeyNames="idNouvelle"
                                    EnablePersistedSelection="true"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <div style="width: 85%; float: left;">
                                            <asp:LinkButton ID="lbNouvelleTitre" runat="server" CommandName="sort" CommandArgument="TitreFR" class="titreListe"><%= outils.obtenirLangue("Titre Français|English title")%></asp:LinkButton>
                                        </div>
                                        <div style="width: 15%; float: right;">
                                            <asp:LinkButton runat="server" CommandName="sort" CommandArgument="dateRedaction" class="titreListe"><%= outils.obtenirLangue("Date publication|Publish date")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <div class="clear-both">
                                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                        </div>
                                    </GroupTemplate>
                                    <ItemTemplate>
                                        <div class="ItemTemplate">
                                            <div style="width: 85%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 75)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="SelectedItemTemplate">
                                            <div style="width: 85%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <h5><% =outils.obtenirLangue("Aucune nouvelle pour le moment.|There's no news at this time.") %></h5>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                            <div class="petitsPoints">
                                <asp:Label ID="lblMessageErreurNouvelle" CssClass="lblMessageErreur" runat="server" Text="" />
                                <asp:ListView ID="lviewInfoNouvelles" runat="server"
                                    ItemType="ModeleSentinellesHY.nouvelle"
                                    SelectMethod="getInfoNouvelle"
                                    UpdateMethod="UpdateNouvelle"
                                    DeleteMethod="DeleteNouvelle"
                                    DataKeyNames="idNouvelle">
                                    <LayoutTemplate runat="server">
                                        <div class="div_AjoutNouvelle" runat="server">
                                            <asp:LinkButton ID="lnkBtnAjoutNouvelle" runat="server" OnClick="lnkBtnAjoutNouvelle_Click" CssClass="btn btn-primary">+ <% =outils.obtenirLangue("Ajouter une nouvelle|Add a news")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre (français) |Title (french)")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted the ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("DateRedactionDo")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />

                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Tite (anglais) |Title (english)")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />

                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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

                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btn-primary disabled-button">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btn-danger disabled-button"
                                                data-toggle="modal">
                                                <i aria-hidden="true" class="icon-remove"></i><% =outils.obtenirLangue(" Supprimer| Delete")%></asp:LinkButton>
                                            <!-- Modal -->
                                            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    <asp:Label runat="server" ID="myModalLabel" CssClass="modalTitle"><% =outils.obtenirLangue("Attention!|Warning!")%></asp:Label>
                                                </div>
                                                <div class="modal-body">
                                                    <p><% =outils.obtenirLangue("Vous êtes sur le point de supprimer cette nouvelle. Souhaitez-vous continuez?|You are about to delete this news. Would you like to continue?")%></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button class="btn" data-dismiss="modal" aria-hidden="true"><% =outils.obtenirLangue("Annuler|Cancel")%></button>
                                                    <asp:LinkButton ID="btnSupprimerNouv" runat="server" CommandName="Delete" class="btn btn-primary"><% =outils.obtenirLangue("Supprimer|Delete")%></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </asp:View>

                        <asp:View ID="ViewEvenement" runat="server">
                            <div class="petitsPointsListeUtilisateurs overflow-y" style="max-height: 160px;">
                                <asp:ListView ID="lvEvenement" runat="server"
                                    ItemType="ModeleSentinellesHY.événement"
                                    SelectMethod="GetEvenement"
                                    DataKeyNames="idEvenement"
                                    EnablePersistedSelection="true"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <div style="width: 70%; float: left;">
                                            <asp:LinkButton ID="lbEvenementTitre" runat="server" CommandName="sort" CommandArgument="TitreFR" class="titreListe"><%= outils.obtenirLangue("Titre Français|English title")%></asp:LinkButton>
                                        </div>
                                        <div style="width: 15%; float: right;">
                                            <asp:LinkButton runat="server" CommandName="sort" CommandArgument="dateRedaction" class="titreListe"><%= outils.obtenirLangue("Date publication|Publish date")%></asp:LinkButton>
                                        </div>
                                        <div style="width: 15%; float: right;">
                                            <asp:LinkButton runat="server" CommandName="sort" CommandArgument="dateEvenement" class="titreListe"><%= outils.obtenirLangue("Date événement|Event date")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <div class="clear-both">
                                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                        </div>
                                    </GroupTemplate>
                                    <ItemTemplate>
                                        <div class="ItemTemplate">
                                            <div style="width: 70%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 50)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateEvenementDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="SelectedItemTemplate">
                                            <div style="width: 70%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" ID="LinkButton1" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 50)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" ID="LinkButton2" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" ID="LinkButton3" runat="server" CommandName="Select"><%# Eval("DateEvenementDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <h5><% =outils.obtenirLangue("Aucun événement pour le moment.|There's no event at this time.") %></h5>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>

                            <div class="encadrerModification petitsPoints">
                                <asp:Label ID="lblMessageErreurEvenement" CssClass="lblMessageErreur" runat="server" Text="" />
                                <asp:ListView ID="lvInfoEvenement" runat="server"
                                    ItemType="ModeleSentinellesHY.événement"
                                    SelectMethod="getInfoEvenement"
                                    UpdateMethod="UpdateEvenement"
                                    DeleteMethod="DeleteEvenement"
                                    DataKeyNames="idEvenement">
                                    <LayoutTemplate>
                                        <div class="div_AjoutNouvelle" runat="server">
                                            <asp:LinkButton ID="lnkBtnAjoutEvenement" runat="server" OnClick="lnkBtnAjoutEvenement_Click" CssClass="btn btn-primary">+ <% =outils.obtenirLangue("Ajouter un événement|Add an event")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre Français : |French Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted on ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("DateRedactionDo")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />

                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Titre Anglais : |English Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />

                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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

                                        <hr />
                                        <div>
                                            <asp:Label ID="lblDateEvenement" runat="server"><%= outils.obtenirLangue("Date de l'événement |Event date ")%></asp:Label>
                                            <asp:TextBox ID="tbDateEvenement" CssClass="tbEvenement" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.DateEvenementDo%>' runat="server" />
                                            <asp:CalendarExtender ID="calextTbEvenement" runat="server" TargetControlID="tbDateEvenement" Format="D"></asp:CalendarExtender>
                                        </div>
                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btn-primary disabled-button">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btn-danger disabled-button"
                                                data-toggle="modal">
                                                <i aria-hidden="true" class="icon-remove"></i><% =outils.obtenirLangue(" Supprimer| Delete")%></asp:LinkButton>
                                            <!-- Modal -->
                                            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    <asp:Label runat="server" CssClass="modalTitle" ID="myModalLabel"><% =outils.obtenirLangue("Attention!|Warning!")%></asp:Label>
                                                </div>
                                                <div class="modal-body">
                                                    <p><% =outils.obtenirLangue("Vous êtes sur le point de supprimer cet événement. Souhaitez-vous continuez?|You are about to delete this event. Would you like to continue?")%></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button class="btn" data-dismiss="modal" aria-hidden="true"><% =outils.obtenirLangue("Annuler|Cancel")%></button>
                                                    <asp:LinkButton ID="btnSupprimerNouv" runat="server" CommandName="Delete" class="btn btn-primary"><% =outils.obtenirLangue("Supprimer|Delete")%></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </asp:View>

                        <asp:View ID="ViewRevueDePresse" runat="server">
                            <div class="petitsPointsListeUtilisateurs overflow-y" style="max-height: 160px;">
                                <asp:ListView ID="lvRDP" runat="server"
                                    ItemType="ModeleSentinellesHY.revuedepresse"
                                    SelectMethod="GetRDP"
                                    DataKeyNames="idRDP"
                                    EnablePersistedSelection="true"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <div style="width: 85%; float: left;">
                                            <asp:LinkButton ID="lbRDPTitre" runat="server" CommandName="sort" CommandArgument="TitreFR" class="titreListe"><%= outils.obtenirLangue("Titre Français|English title")%></asp:LinkButton>
                                        </div>
                                        <div style="width: 15%; float: right;">
                                            <asp:LinkButton runat="server" CommandName="sort" CommandArgument="dateRedaction" class="titreListe"><%= outils.obtenirLangue("Date publication|Publish date")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <div class="clear-both">
                                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                        </div>
                                    </GroupTemplate>
                                    <ItemTemplate>
                                        <div class="ItemTemplate">
                                            <div style="width: 85%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 75)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="SelectedItemTemplate">
                                            <div style="width: 85%; float: left;">
                                                <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                            <div style="width: 15%; float: right;">
                                                <asp:LinkButton CssClass="listeLigneComplete" runat="server" CommandName="Select"><%# Eval("DateRedactionDo")%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <h5><% =outils.obtenirLangue("Aucune revue de presse pour le moment.|There's no press review at this time.") %></h5>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                            <div class="encadrerModification petitsPoints">
                                <asp:Label ID="lblMessageErreurRDP" CssClass="lblMessageErreur" runat="server" Text="" />
                                <asp:ListView ID="lvInfoRDP" runat="server"
                                    ItemType="ModeleSentinellesHY.revuedepresse"
                                    SelectMethod="getInfoRDP"
                                    UpdateMethod="UpdateRDP"
                                    DeleteMethod="DeleteRDP"
                                    DataKeyNames="idRDP">
                                    <LayoutTemplate>
                                        <div class="div_AjoutNouvelle">
                                            <asp:LinkButton ID="lnkBtnAjoutRDP" CssClass="btn btn-primary" runat="server" OnClick="lnkBtnAjoutRDP_Click">+ <% =outils.obtenirLangue("Ajouter une revue de presse|Add a press review")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre Français : |French Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted on ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("DateRedactionDo")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />

                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Titre Anglais : |English Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />

                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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

                                        <hr />
                                        <asp:Label runat="server"><%= outils.obtenirLangue("Fichier ou lien vers la revue de presse : |File or link to the press review : ")%></asp:Label>
                                        <asp:TextBox ID="txtboxUrlDocument" CssClass="txtBoxModifier" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.urlDocument%>' Width="300" runat="server" />
                                        <div>
                                            <a onclick="$('[id$=fuplRDP]').click(); return false;" href="#"><%= outils.obtenirLangue("Choisir un fichier PDF|Select a PDF file") %></a>

                                            <asp:FileUpload ID="fuplRDP" runat="server" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" onpropertychange="$('[id$=uploadButton1]').click(); return false;" onchange="$('[id$=uploadButton1]').click(); return false;" Style="display: none" />
                                            <asp:Button ID="uploadButton1" runat="server" Text="Carrousel1" ClientIDMode="Static" OnClick="lnkUploadPDF_Click" Style="display: none" />
                                        </div>
                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btn-primary">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btn-danger"
                                                data-toggle="modal">
                                                <i aria-hidden="true" class="icon-remove"></i><% =outils.obtenirLangue(" Supprimer| Delete")%></asp:LinkButton>
                                            <!-- Modal -->
                                            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    <asp:Label runat="server" CssClass="modalTitle" ID="myModalLabel"><% =outils.obtenirLangue("Attention!|Warning!")%></asp:Label>
                                                </div>
                                                <div class="modal-body">
                                                    <p><% =outils.obtenirLangue("Vous êtes sur le point de supprimer cet revue de presse. Souhaitez-vous continuez?|You are about to delete this press review. Would you like to continue?")%></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button class="btn" data-dismiss="modal" aria-hidden="true"><% =outils.obtenirLangue("Annuler|Cancel")%></button>
                                                    <asp:LinkButton ID="btnSupprimerNouv" runat="server" CommandName="Delete" class="btn btn-primary"><% =outils.obtenirLangue("Supprimer|Delete")%></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </asp:View>

                        <asp:View ID="ViewUtilisateur" runat="server">
                            <div class="row paddingRow">
                                <div class="pull-right">
                                    <asp:TextBox ID="txtboxRechercheUtilisateur" runat="server" />
                                    <asp:Button ID="btnRechercheUtilisateur" runat="server" Text="Rechercher" CssClass="btn btn-primary" />
                                </div>
                                <div class="clear-both"></div>
                                <div class="petitsPointsListeUtilisateurs overflow-y" style="max-height: 160px;">
                                    <%--------lviewUtilisateur-------%>
                                    <asp:ListView ID="lviewUtilisateurs" runat="server"
                                        ItemType="ModeleSentinellesHY.utilisateur"
                                        SelectMethod="GetUtilisateurs"
                                        DataKeyNames="idUtilisateur"
                                        EnablePersistedSelection="true"
                                        GroupItemCount="3">

                                        <LayoutTemplate>
                                            <div style="width: 20%; float: left;">
                                                <asp:LinkButton runat="server" ID="lblUtilisateurUsername" CommandName="sort" CommandArgument="nomUtilisateur" class="titreListe"><%= outils.obtenirLangue("Nom Utilisateur|Username")%></asp:LinkButton>
                                            </div>
                                            <div style="width: 26.6%; float: left;">
                                                <asp:LinkButton runat="server" CommandName="sort" CommandArgument="prenom" class="titreListe"><%= outils.obtenirLangue("Prénom|First Name")%></asp:LinkButton>
                                            </div>
                                            <div style="width: 26.6%; float: left;">
                                                <asp:LinkButton runat="server" CommandName="sort" CommandArgument="nom" class="titreListe"><%= outils.obtenirLangue("Nom|Last Name")%></asp:LinkButton>
                                            </div>
                                            <div style="width: 26.7%; float: left;">
                                                <asp:LinkButton runat="server" CommandName="sort" CommandArgument="milieu" class="titreListe"><%= outils.obtenirLangue("Milieu Travail|Workplace")%></asp:LinkButton>
                                            </div>
                                            <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                        </LayoutTemplate>

                                        <GroupTemplate>
                                            <div class="clear-both">
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                            </div>
                                        </GroupTemplate>
                                        <ItemTemplate>
                                            <div class="ItemTemplate">
                                                <div style="width: 20%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("nomUtilisateur")%>' />
                                                </div>
                                                <div style="width: 26.6%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("prenom")%>' />
                                                </div>
                                                <div style="width: 26.6%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("nom")%>' />
                                                </div>
                                                <div style="width: 26.7%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("milieu")%>' />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <SelectedItemTemplate>
                                            <div class="SelectedItemTemplate">
                                                <div style="width: 20%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("nomUtilisateur")%>' />
                                                </div>
                                                <div style="width: 26.6%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("prenom")%>' />
                                                </div>
                                                <div style="width: 26.6%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("nom")%>' />
                                                </div>
                                                <div style="width: 26.7%; float: left;">
                                                    <asp:LinkButton CssClass="listeLigneComplete" CommandName="Select" runat="server" Text='<%# Eval("milieu")%>' />
                                                </div>
                                            </div>
                                        </SelectedItemTemplate>
                                        <EmptyDataTemplate>
                                            <%= outils.obtenirLangue("Il n'y présentement aucun utilisateur d'enregistrer.|There's actually no registered user.")%>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </div>
                                <div class="petitsPoints">
                                    <asp:Label ID="lblMessageErreurInfoUtilisateur" CssClass="lblMessageErreur" runat="server" Text="" />
                                    <%-- lview info d'un utilisateur--%>
                                    <asp:ListView ID="lviewInfoUtilisateur" runat="server"
                                        ItemType="ModeleSentinellesHY.utilisateur"
                                        SelectMethod="getInfoUtilisateur"
                                        UpdateMethod="UpdateUtilisateur"
                                        DeleteMethod="DeleteUtilisateur"
                                        DataKeyNames="idUtilisateur">
                                        <LayoutTemplate>
                                            <div>
                                                <asp:LinkButton ID="lnkbtnAjouter" CssClass="btn btn-primary" runat="server" OnClick="lnkbtnAjouter_Click"><%= outils.obtenirLangue("+ Ajouter un utilisateur|+ Add user")%></asp:LinkButton>
                                            </div>
                                            <div class="lviewInfoUtilisateur_centrer">
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                            </div>
                                        </LayoutTemplate>
                                        <EmptyDataTemplate>
                                            <asp:LinkButton ID="lnkbtnAjouter" CssClass="lnkbtnAjouter_margin btn btn-primary" runat="server" OnClick="lnkbtnAjouter_Click"><%= outils.obtenirLangue("+ Ajouter un utilisateur|+ Add user")%></asp:LinkButton>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <div id="divIdUtilisateur" class="row centrerVerticalement" style="clear: both">
                                                <asp:TextBox runat="server" ID="lblIdUtilisateur" Visible="false" Text='<%# BindItem.idUtilisateur%>' />
                                            </div>
                                            <div id="divNomUtilisateur" class="row centrerVerticalement" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblNomUtilisateur" CssClass="lblUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server"><%= outils.obtenirLangue("Nom d'utilisateur:|Username :")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxnomUtilisateur" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.nomUtilisateur%>' />
                                                </div>
                                            </div>
                                            <div id="divPrenom" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblPrenom" CssClass="lblUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server"><%= outils.obtenirLangue("Prénom:|First name :")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxprenom" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.prenom%>' />
                                                </div>
                                            </div>
                                            <div id="divNom" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblNom" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Nom:|Last name :")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxnom" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.nom%>' />
                                                </div>
                                            </div>
                                            <div id="divSexe" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblSexe" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Sexe:|Gender:")%> </asp:Label>
                                                </div>
                                                <div class="span6" style="float: right; display: inline;">
                                                    <span class="asterisque">*</span>
                                                    <asp:RadioButtonList ID="rbtnSexe" runat="server" RepeatDirection="Horizontal" CssClass="radio rbtnSexe txtboxUtilisateur"
                                                        SelectedValue='<%# BindItem.sexe%>' OnInit="rbtnSexe_Init">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            <div id="divTelephone" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblTelephone" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("No. téléphone:|Phone number:")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxnoTelephone" placeHolder="123-456-7890" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.noTelephone%>' />
                                                </div>
                                            </div>

                                            <div id="divCourriel" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblCourriel" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Courriel:|Email:")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxcourriel" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" placeHolder="abc@microsoft.com" runat="server" Text='<%# BindItem.courriel%>' />
                                                </div>
                                            </div>

                                            <div id="divType" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblType" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Type d'utilisateur:|User type:")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:DropDownList ID="ddlstType"
                                                        DataValueField="idStatut"
                                                        DataTextField="nomStatut"
                                                        ItemType="ModeleSentinellesHY.Statut"
                                                        SelectedValue="<%# BindItem.idStatut%>"
                                                        SelectMethod="getStatutUtilisateur" CssClass="txtboxUtilisateur" runat="server" />
                                                </div>
                                            </div>

                                            <div id="divMilieu" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblMilieu" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Milieu de travail:|Work place:")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxmilieu" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.milieu%>' />
                                                </div>
                                            </div>

                                            <div id="divPassword" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblPassword" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Mot de passe:|Password:")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxmotDePasse" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.motDePasseTemp%>' />
                                                </div>
                                            </div>

                                            <div id="divConfirmer" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblConfirmer" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Confirmer le mot de passe:|Confirm password:")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <span class="asterisque">*</span>
                                                    <asp:TextBox ID="txtboxConfirmer" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.confirmationMotDePasse%>' />
                                                </div>
                                            </div>
                                            <div id="divAvatar" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblAvatar" runat="server" Text="Photo:" />
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:Label ID="lblNomPhoto" Text='<%# BindItem.UrlAvatar%>' runat="server" />
                                                    <asp:Button ID="btnImgDefaut" CssClass="btn btn-mini btn-warning" Text='<%# outils.obtenirLangue(" Image par défaut| Reset default image")%>' OnClick="btnImgDefaut_Click" runat="server"></asp:Button>
                                                </div>
                                                <div class="span6 Avatar_margin" style="float: right;">
                                                    <img id="imgUpload" src='<%# String.Format("../Upload/ImagesProfil/{0}", Eval("UrlAvatar"))%>' runat="server" />
                                                </div>
                                            </div>
                                            <div id="rowBouton" class="row">
                                                <div>
                                                    <asp:LinkButton ID="btnModifier" runat="server"
                                                        CommandName="Update"
                                                        CssClass="btn btn-primary"
                                                        CausesValidation="true"
                                                        ValidationGroup="sommaire">
                                                <i aria-hidden="true" class="icon-check"></i><%= outils.obtenirLangue(" Mettre à jour| Update")%></asp:LinkButton>
                                                    <asp:LinkButton ID="btnSupprimerUti" runat="server" href="#myModal" role="button" class="btn btn-danger" data-toggle="modal" CommandName="Update">
                                                <i aria-hidden="true" class="icon-remove"></i><%= outils.obtenirLangue(" Supprimer| Delete")%></asp:LinkButton>
                                                    <!-- Modal -->
                                                    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                        <div class="modal-header">

                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <asp:Label ID="myModalLabel" CssClass="modalTitle" runat="server"><%= outils.obtenirLangue("Attention!|Warning!")%></asp:Label>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p><%= outils.obtenirLangue("Vous êtes sur le point de supprimer cet utilisateur. Voulez-vous continuez?|You are about to delete this user. Do you want to proceed?")%></p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn" data-dismiss="modal" aria-hidden="true"><%= outils.obtenirLangue("Annuler|Cancel")%></button>
                                                            <asp:Button ID="btnSupprimerUtilisateur" runat="server" Text="Supprimer" CommandName="Delete" class="btn btn-danger" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                        </asp:View>

                        <asp:View ID="viewMessage" runat="server">
                            <div class="encadrerModification">
                                <div>
                                    <asp:Label ID="Label11" runat="server">
                                        <%= outils.obtenirLangue("Veuillez prendre note que ce message sera distribué à tous les utilisateurs présentement inscrits.|Please take note that this email will be sent to all the users actually registered.")%>
                                    </asp:Label>
                                </div>
                                <div class="pull-right">
                                    <asp:Label runat="server" ID="lblMessageErreurEnvoiMessage" CssClass="lblFormulaire text-error"></asp:Label>
                                </div>
                                <div id="div_titreMessage">
                                    <asp:Label ID="lblTitreMessage" runat="server"><%= outils.obtenirLangue("Objet:|Subject:")%></asp:Label>
                                    <asp:TextBox ID="txtboxTitreMessage" runat="server"></asp:TextBox>
                                </div>
                                <div>
                                    <asp:TextBox ID="txtboxMessage" runat="server" CssClass="htmlEditor" TextMode="MultiLine"></asp:TextBox>

                                    <asp:HtmlEditorExtender ID="htmleditorMessage" runat="server" TargetControlID="txtboxMessage" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true">
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
                                <div id="lnkBtn_envoiMessage">
                                    <asp:LinkButton ID="lnkbtnEnvoiMessage" runat="server"
                                        CssClass="btn btn-primary"
                                        CommandName="Update">
                                        <i aria-hidden="true" class="icon-check"></i><%= outils.obtenirLangue(" Envoyer| Send")%>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
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
<script>
    $(function () {
        $('#myModal').modal('hide')
    });
    function PreviewImage(idImage, idFU) {
        var oFReader = new FileReader();
        oFReader.readAsDataURL(document.getElementById(idFU).files[0]);

        oFReader.onload = function (oFREvent) {
            document.getElementById(idImage).src = oFREvent.target.result;
        };
    };
</script>
</html>
