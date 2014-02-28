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

    <script src="../CSS/js/jqueryCrop.min.js"></script>
    <script src="../CSS/js/jquery.Jcrop.min.js"></script>
    <script src="../CSS/js/jquery.Jcrop.js"></script>
    
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


    <div id="wrapper">
        <form id="form1" runat="server">
            <ajaxToolkit:ToolkitScriptManager ID="tsmTest" runat="server" />
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
            <div class="row">
                <ul class="text-center">
                    <asp:ImageButton ID="imgBtn_EnvoiMessage" ImageUrl="~/Images/enveloppe.png" runat="server" />
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
                                                            CssClass="btn btnAjouter disabled-button"
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
                                                            <asp:HtmlEditorExtender ID="htmleditorHistoriqueFR" runat="server" TargetControlID="txtboxHistoriqueFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                                        </div>
                                                        <hr />
                                                        <div>
                                                            <div id="div_lblHistoriqueEN">
                                                                <asp:Label ID="lblHistoriqueEN" runat="server">
                                                                     <%= outils.obtenirLangue("Contenu de l'historique (anglais) : |History content (english) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxHistoriqueEN" TextMode="MultiLine" CssClass="htmleditorHistorique" runat="server" Text='<%# BindItem.historiqueEN%>' />
                                                            <asp:HtmlEditorExtender ID="htmleditorHistoriqueEN" runat="server" TargetControlID="txtboxHistoriqueEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                                        </div>
                                                        <div id="div_lnkbtnHistorique">
                                                            <asp:LinkButton ID="lnkbtnHistorique" runat="server"
                                                                CssClass="btn btnAjouter disabled-button"
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
                                                            <asp:HtmlEditorExtender ID="htmleditorMaltraitanceFR" runat="server" TargetControlID="txtboxMaltraitanceFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                                        </div>
                                                        <hr />
                                                        <div>
                                                            <div id="div_lblMaltraitanceEN">
                                                                <asp:Label ID="lblMaltraitanceEN" runat="server">
                                                                    <%= outils.obtenirLangue("Contenu de l'information du la maltraitance (anglais) : |Content of the information about the elderly abuse (english) : ")%>
                                                                </asp:Label>
                                                            </div>
                                                            <asp:TextBox ID="txtboxMaltraitanceEN" TextMode="MultiLine" CssClass="htmleditorMaltraitance" runat="server" Text='<%# BindItem.maltraitanceEN%>' />
                                                            <asp:HtmlEditorExtender ID="HtmlEditorExtender1" runat="server" TargetControlID="txtboxMaltraitanceEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                                        </div>
                                                        <div id="div_lnkbtnMaltraitance">
                                                            <asp:LinkButton ID="lnkbtnMaltraitance" runat="server"
                                                                CssClass="btn btnAjouter disabled-button"
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
                                                            <asp:Label ID="Label4" runat="server"><%= outils.obtenirLangue("Contenu de la pensée (français) : |Content of the thought (french) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxPenseeFR" CssClass="txtboxPenseeFR" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.penseeFR%>' />
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="Label5" runat="server"><%= outils.obtenirLangue("Contenu de la pensée (english) : |Content of the thought (english) : ")%></asp:Label>
                                                            <asp:TextBox ID="txtboxPenseeEN" CssClass="txtboxPenseeEN" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.penseeEN%>' />
                                                        </div>
                                                        <asp:LinkButton ID="LinkButton4" runat="server"
                                                            CssClass="btn btnAjouter disabled-button"
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
                                                            <asp:Label ID="Label9" runat="server">
                                                                <%= outils.obtenirLangue("Contenu du témoignage (français) : |Content of the testimonial (french) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxtemoignageFR" CssClass="txtboxtemoignageFR" TextMode="MultiLine" Height="40px" runat="server" Text='<%# BindItem.temoignageFR%>' />
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="Label6" runat="server">
                                                               <%= outils.obtenirLangue("Contenu du témoignage (anglais) : |Content of the testimonial (english) : ")%>
                                                            </asp:Label>
                                                            <asp:TextBox ID="txtboxtemoignageEN" runat="server" CssClass="txtboxtemoignageEN" TextMode="MultiLine" Height="40px" Text='<%# BindItem.temoignageEN%>' />
                                                        </div>
                                                        <asp:LinkButton ID="LinkButton5" runat="server"
                                                            CssClass="btn btnAjouter disabled-button"
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
                                                                <%= outils.obtenirLangue("*Les images du carrousel doivent être approximativement de 960 x 200 et de types .png ou .jpg|*The images of the caroussel must be approximately 960 x 200 and with the type .png or .jpg")%>
                                                                    </asp:Label>
                                                                </div>
                                                                <div class="marginbottom_divImgCarrousel">
                                                                    <asp:Label ID="Label10" runat="server"><%= outils.obtenirLangue("Image carrousel 1 : |Photo caroussel 1 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel1" Enabled=" false" runat="server" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel1]').click(); return false;" href="#"><%= outils.obtenirLangue("Choisir|Select")%></a> |
                                                                    <asp:LinkButton ID="btCarrousel1" runat="server" Text="Upload" OnClick="lnkUploadPhotoCarrousel_Click" />
                                                                    <img id="imgCarrousel1" width="360" src="../Upload/Carrousel1.jpg" />
                                                                    <asp:FileUpload runat="server" ID="fuplPhotoCarrousel1"  ClientIDMode="Static" onpropertychange="$('[id$=uploadButton]').click(); return false;" onchange="$('[id$=uploadButton]').click(); return false;"  Style="Display: none" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                    <asp:Button ID="uploadButton" runat="server" Text="Upload!"  ClientIDMode="Static" OnClick="lnkUploadPhotoCarrousel_Click" />
                                                                </div>
                                                                <div class="marginbottom_divImgCarrousel">
                                                                    <asp:Label ID="Label7" runat="server"> <%= outils.obtenirLangue("Image carrousel 2 : |Photo caroussel 2 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel2" runat="server" Enabled=" false" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel2]').click(); return false;"
                                                                        href="#"><%= outils.obtenirLangue("Choisir|Select")%></a> |
                                                            <asp:LinkButton ID="Carrousel2" runat="server" Text="Upload" OnClick="lnkUploadPhotoCarrousel_Click" />
                                                                    <img id="imgCarrousel2" width="360" src="../Upload/Carrousel2.jpg" />
                                                                    <asp:FileUpload ID="fuplPhotoCarrousel2" onchange="PreviewImage('imgCarrousel2','fuplPhotoCarrousel2');" runat="server" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                </div>
                                                                <div>
                                                                    <asp:Label ID="Label8" runat="server"> <%= outils.obtenirLangue("Image carrousel 3 : |Photo caroussel 3 : ")%></asp:Label>
                                                                    <asp:TextBox ID="txtboxImgCarrousel3" runat="server" Enabled=" false" />
                                                                    <a onclick="$('[id$=fuplPhotoCarrousel3]').click(); return false;"
                                                                        href="#"><%= outils.obtenirLangue("Choisir|Select")%></a> |
                                                            <asp:LinkButton ID="Carrousel3" runat="server" Text="Upload" OnClick="lnkUploadPhotoCarrousel_Click" />
                                                                    <img id="imgCarrousel3" width="360" src="../Upload/Carrousel3.jpg" />
                                                                    <asp:FileUpload ID="fuplPhotoCarrousel3" onchange="PreviewImage('imgCarrousel3','fuplPhotoCarrousel3');" runat="server" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:View>
                                                    <asp:View runat="server" ID="vCrop" OnActivate="vCrop_Activate">
                                                        <div>

                                                            <asp:Button runat="server" ID="imageRotateLeft" CssClass="btn rotateImgLeft" meta:resourcekey="imageRotateLeftResource1" />
                                                            <asp:Button runat="server" ID="imageRotateRight" CssClass="btn rotateImgRight" meta:resourcekey="imageRotateRightResource1" />
                                                            <br />
                                                            <asp:Image runat="server" ID="cropbox" Width="800px" ClientIDMode="Static" meta:resourcekey="cropboxResource1" />
                                                            <br />
                                                            <asp:Button ID="btCropGo" runat="server" Text="Sauvegarder" CssClass="btn btn-default" meta:resourcekey="btCropGoResource1" />

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
                            <div class="petitsPointsListeUtilisateurs overflow-y" style="max-height: 120px;">
                                <asp:ListView ID="lviewNouvelle" runat="server"
                                    ItemType="ModeleSentinellesHY.nouvelle"
                                    SelectMethod="GetNouvelle"
                                    DataKeyNames="idNouvelle"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <div style="width: 82.5%; float: left;">
                                            <asp:Label runat="server" class="titreListe"><%= outils.obtenirLangue("Titre Français|English title")%></asp:Label>
                                        </div>
                                        <div style="width: 17.5%; float: right;">
                                            <asp:Label runat="server" class="titreListe"><%= outils.obtenirLangue("Date de publication|Publish date")%></asp:Label>
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
                                            <div style="width: 82.5%; float: left;">
                                                <asp:LinkButton CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                            <div style="width: 17.5%; float: right;">
                                                <asp:LinkButton runat="server" CommandName="Select"><%# Left(Eval("dateRedaction"),10)%></asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="SelectedItemTemplate">
                                            <div style="width: 82.5%; float: left;">
                                                <asp:LinkButton CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                            <div style="width: 17.5%; float: right;">
                                                <asp:LinkButton runat="server" CommandName="Select"><%# Left(Eval("dateRedaction"),10)%></asp:LinkButton>
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
                                    <LayoutTemplate>
                                        <div class="div_AjoutNouvelle">
                                            <asp:LinkButton ID="lnkBtnAjoutNouvelle" runat="server" OnClick="lnkBtnAjoutNouvelle_Click">+ <% =outils.obtenirLangue("Ajouter une nouvelle|Add a news")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre (français) |Title (french)")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted the ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("dateRedaction")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />
                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        </div>
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Tite (anglais) |Title (english)")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />
                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btnAjouter disabled-button">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btnAjouter disabled-button"
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
                            <div class="petitsPointsListeUtilisateurs overflow-y">
                                <asp:ListView ID="lvEvenement" runat="server"
                                    ItemType="ModeleSentinellesHY.événement"
                                    SelectMethod="GetEvenement"
                                    DataKeyNames="idEvenement"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </GroupTemplate>
                                    <ItemTemplate>
                                        <div class="span3">
                                            <div id="divTitreFR" style="color: black;" class="ItemTemplateNom">
                                                <asp:LinkButton ID="lblTitreFR" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="span3">
                                            <div id="divTitreFR" class="SelectedItemTemplateNom">
                                                <asp:LinkButton ID="lblTitreFR" title='<%# Eval("TitreFR")%>' CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <h5><% =outils.obtenirLangue("Aucun événement pour le moment.|There's no event at this time.") %></h5>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>

                            <div class="encadrerModification">
                                <asp:Label ID="lblMessageErreurEvenement" CssClass="lblMessageErreur" runat="server" Text="" />
                                <asp:ListView ID="lvInfoEvenement" runat="server"
                                    ItemType="ModeleSentinellesHY.événement"
                                    SelectMethod="getInfoEvenement"
                                    UpdateMethod="UpdateEvenement"
                                    DeleteMethod="DeleteEvenement"
                                    DataKeyNames="idEvenement">
                                    <LayoutTemplate>
                                        <div class="div_AjoutNouvelle">
                                            <asp:LinkButton ID="lnkBtnAjoutEvenement" runat="server" OnClick="lnkBtnAjoutEvenement_Click">+ <% =outils.obtenirLangue("Ajouter un événement|Add an event")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre Français : |French Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted on ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("dateRedaction")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />
                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        </div>
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Titre Anglais : |English Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />
                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblDateEvenement" runat="server"><%= outils.obtenirLangue("Date de l'événement |Event date ")%></asp:Label>
                                            <asp:TextBox ID="tbDateEvenement" CssClass="tbEvenement" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.dateEvenement%>' runat="server" />
                                            <asp:CalendarExtender ID="calextTbEvenement" runat="server" TargetControlID="tbDateEvenement" Format="yyyy-MM-dd"></asp:CalendarExtender>
                                        </div>
                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btnAjouter disabled-button">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btnAjouter disabled-button"
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
                            <div class="petitsPointsListeUtilisateurs overflow-y">
                                <asp:ListView ID="lvRDP" runat="server"
                                    ItemType="ModeleSentinellesHY.revuedepresse"
                                    SelectMethod="GetRDP"
                                    DataKeyNames="idRDP"
                                    GroupItemCount="3">
                                    <LayoutTemplate>
                                        <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </GroupTemplate>
                                    <ItemTemplate>
                                        <div class="span3">
                                            <div id="divTitreFR" style="color: black;" class="ItemTemplateNom">
                                                <asp:LinkButton ID="lblTitreFR" CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <SelectedItemTemplate>
                                        <div class="span3">
                                            <div id="divTitreFR" class="SelectedItemTemplateNom">
                                                <asp:LinkButton ID="lblTitreFR" title='<%# Eval("TitreFR")%>' CommandName="Select" runat="server" Text='<%# Left(Eval(outils.obtenirLangue("TitreFR|TitreEN")), 35)%>' />
                                            </div>
                                        </div>
                                    </SelectedItemTemplate>
                                    <EmptyDataTemplate>
                                        <h5><% =outils.obtenirLangue("Aucune revue de presse pour le moment.|There's no press review at this time.") %></h5>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                            </div>
                            <div class="encadrerModification">
                                <asp:Label ID="lblMessageErreurRDP" CssClass="lblMessageErreur" runat="server" Text="" />
                                <asp:ListView ID="lvInfoRDP" runat="server"
                                    ItemType="ModeleSentinellesHY.revuedepresse"
                                    SelectMethod="getInfoRDP"
                                    UpdateMethod="UpdateRDP"
                                    DeleteMethod="DeleteRDP"
                                    DataKeyNames="idRDP">
                                    <LayoutTemplate>
                                        <div class="div_AjoutNouvelle">
                                            <asp:LinkButton ID="lnkBtnAjoutRDP" runat="server" OnClick="lnkBtnAjoutRDP_Click">+ <% =outils.obtenirLangue("Ajouter une revue de presse|Add a press review")%></asp:LinkButton>
                                        </div>
                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div style="position: relative;">
                                            <asp:Label ID="lblTitreFR" runat="server"><%= outils.obtenirLangue("Titre Français : |French Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreFR" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreFR%>' runat="server" />
                                            <div id="divDateRedaction" class="divDateRedaction" runat="server">
                                                <asp:Label ID="lblRedigele" runat="server"><%= outils.obtenirLangue("Rédigé le |Posted on ")%></asp:Label>
                                                <asp:Label ID="lblDateRedaction" runat="server" Text='<%# Eval("dateRedaction")%>' />
                                            </div>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtboxcontenuFR" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuFR%>' runat="server" />
                                            <asp:HtmlEditorExtender ID="htmleditorContenuFR" runat="server" TargetControlID="txtboxcontenuFR" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        </div>
                                        <hr />
                                        <div>
                                            <asp:Label ID="lblTitreEN" runat="server"><%= outils.obtenirLangue("Titre Anglais : |English Title : ")%></asp:Label>
                                            <asp:TextBox ID="txtboxtitreEN" CssClass="txtBoxModifier_Titre" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.titreEN%>' runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtboxcontenuEN" CssClass="txtBoxModifier" TextMode="MultiLine" Text='<%# BindItem.contenuEN%>' runat="server" />
                                        <asp:HtmlEditorExtender ID="htmleditorContenuEN" runat="server" TargetControlID="txtboxcontenuEN" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                        <hr />
                                        <asp:Label runat="server"><%= outils.obtenirLangue("Fichier ou lien vers la revue de presse : |File or link to the press review : ")%></asp:Label>
                                        <asp:TextBox ID="txtboxUrlDocument" CssClass="txtBoxModifier" onkeydown="return (event.keyCode!=13);" Text='<%# BindItem.urlDocument%>' Width="300" runat="server" />
                                        <div>
                                            <a onclick="$('[id$=fuplRDP]').click(); return false;"
                                                href="#"><%= outils.obtenirLangue("Choisir|Select") %></a> |
                                                <asp:LinkButton ID="lnkUploadRDP" runat="server" Text="Upload" OnClick="lnkUploadRDP_Click" />
                                            <asp:FileUpload ID="fuplRDP" runat="server" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                        </div>
                                        <div class="boutonsNouvelleMargin">
                                            <asp:LinkButton ID="btnModifierNouvelle" runat="server"
                                                CommandName="Update"
                                                CssClass="btn btnAjouter">
                                                <i aria-hidden="true" class="icon-check"></i> <% =outils.obtenirLangue(" Sauvegarder| Save")%></asp:LinkButton>
                                            <asp:LinkButton ID="lnkbtnSupprimerNouvelle" runat="server"
                                                href="#myModal"
                                                role="button"
                                                class="btn btnAjouter"
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
                                <div class="petitsPointsListeUtilisateurs overflow">
                                    <%--------lviewUtilisateur-------%>
                                    <asp:ListView ID="lviewUtilisateurs" runat="server"
                                        ItemType="ModeleSentinellesHY.utilisateur"
                                        SelectMethod="GetUtilisateurs"
                                        DataKeyNames="idUtilisateur"
                                        GroupItemCount="3">
                                        <LayoutTemplate>
                                            <asp:PlaceHolder ID="groupPlaceHolder" runat="server" />
                                        </LayoutTemplate>
                                        <GroupTemplate>
                                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                        </GroupTemplate>
                                        <ItemTemplate>
                                            <div class="span3">
                                                <div id="divNom" style="color: black;" class="ItemTemplateNom">
                                                    <asp:LinkButton ID="lblPrenom" CssClass="lnkBtnPrenom" CommandName="Select" runat="server" Text='<%# Eval("nomUtilisateur")%>' />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <SelectedItemTemplate>
                                            <div class="span3">
                                                <div id="divNom" class="SelectedItemTemplateNom">
                                                    <asp:LinkButton ID="lblPrenom" title='<%# Eval("prenom")%>' CommandName="Select" runat="server" Text='<%# Eval("nomUtilisateur")%>' />
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
                                                <asp:LinkButton ID="lnkbtnAjouter" runat="server" OnClick="lnkbtnAjouter_Click"><%= outils.obtenirLangue("+ Ajouter un utilisateur|+ Add user")%></asp:LinkButton>
                                            </div>
                                            <div class="lviewInfoUtilisateur_centrer">
                                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                            </div>
                                        </LayoutTemplate>
                                        <EmptyDataTemplate>
                                            <asp:LinkButton ID="lnkbtnAjouter" CssClass="lnkbtnAjouter_margin" runat="server" OnClick="lnkbtnAjouter_Click"><%= outils.obtenirLangue("+ Ajouter un utilisateur|+ Add user")%></asp:LinkButton>
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
                                                    <asp:TextBox ID="txtboxnomUtilisateur" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.nomUtilisateur%>' />
                                                </div>
                                            </div>
                                            <div id="divPrenom" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblPrenom" CssClass="lblUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server"><%= outils.obtenirLangue("Prénom:|First name :")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxprenom" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.prenom%>' />

                                                </div>
                                            </div>
                                            <div id="divNom" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblNom" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Nom:|Last name :")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxnom" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.nom%>' />

                                                </div>
                                            </div>
                                            <div id="divSexe" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblSexe" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Sexe:|Gender:")%> </asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:RadioButtonList ID="rbtnSexe" runat="server" RepeatDirection="Horizontal" CssClass="radio rbtnSexe"
                                                        SelectedValue='<%# BindItem.sexe%>' OnInit="rbtnSexe_Init">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            <div id="divTelephone" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblTelephone" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("No. téléphone:|Phone number:")%></asp:Label>
                                                </div>
                                                <div class="span6" style="float: right;">
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
                                                    <asp:TextBox ID="txtboxmilieu" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.milieu%>' />

                                                </div>
                                            </div>

                                            <div id="divPassword" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblPassword" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Mot de passe:|Password:")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxmotDePasse" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.motDePasseTemp%>' />

                                                </div>
                                            </div>

                                            <div id="divConfirmer" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblConfirmer" CssClass="lblUtilisateur" runat="server"><%= outils.obtenirLangue("Confirmer le mot de passe:|Confirm password:")%></asp:Label>

                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxConfirmer" CssClass="txtboxUtilisateur" onkeydown="return (event.keyCode!=13);" runat="server" Text='<%# BindItem.confirmationMotDePasse%>' />
                                                </div>
                                            </div>
                                            <div id="divAvatar" class="row" style="clear: both">
                                                <div class="span3" style="margin-left: 35px;">
                                                    <asp:Label ID="lblAvatar" runat="server" Text="Photo:" />
                                                    <div id="divFileUpload">
                                                        <a onclick="$('[id$=fuplPhoto]').click(); return false;"
                                                            href="#"><%= outils.obtenirLangue("Choisir|Select") %></a> |
                                                        <asp:LinkButton ID="lnkUpload" runat="server" Text="Upload" OnClick="lnkUpload_Click" />
                                                    </div>
                                                </div>
                                                <div class="span6" style="float: right;">
                                                    <asp:TextBox ID="txtboxNomPhoto" CssClass="txtboxUtilisateur" ReadOnly="true" Text='<%# BindItem.UrlAvatar%>' runat="server" />
                                                </div>
                                                <div>
                                                    <asp:FileUpload ID="fuplPhoto" runat="server" ClientIDMode="Static" Width="1px" color="white" BorderColor="white" CssClass="opacity0" />
                                                </div>
                                                <div class="span6 Avatar_margin" style="float: right;">
                                                    <img id="imgUpload" src='<%# String.Format("../Upload/{0}", Eval("UrlAvatar"))%>' runat="server" />
                                                </div>
                                            </div>
                                            <div id="rowBouton" class="row">
                                                <div class="span4 offset3">
                                                    <asp:LinkButton ID="btnModifier" runat="server"
                                                        CommandName="Update"
                                                        CssClass="btn btnAjouter"
                                                        CausesValidation="true"
                                                        ValidationGroup="sommaire">
                                                    <i aria-hidden="true" class="icon-check"></i><%= outils.obtenirLangue(" Mettre à jour| Update")%></asp:LinkButton>
                                                    <asp:LinkButton ID="btnSupprimerUti" runat="server" href="#myModal" role="button" class="btn btnAjouter" data-toggle="modal" CommandName="Update">
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
                                                            <asp:Button ID="btnSupprimerUtilisateur" runat="server" Text="Supprimer" CommandName="Delete" class="btn btn-primary" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
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
                                    <asp:HtmlEditorExtender ID="htmleditorMessage" runat="server" TargetControlID="txtboxMessage" ValidateRequestMode="Disabled" EnableSanitization="false" Enabled="true" />
                                </div>
                                <div id="lnkBtn_envoiMessage">
                                    <asp:LinkButton ID="lnkbtnEnvoiMessage" runat="server"
                                        CssClass="btn btnAjouter"
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
                    <div>
                        <a href="http://www.santemonteregie.qc.ca/granby-region/index.fr.html" target="_blank">
                            <img id="imgCSSSHY" width="225" class="footerImages" src="../Images/CSSSHY.jpg" />
                        </a>
                        <a href="http://www.aqdr.org/" target="_blank">
                            <img id="imgAQDR" width="225" class="footerImages" src="../Images/AQDR.jpg" />
                        </a>
                    </div>
                    <div>
                        <a href="http://www.cegepgranby.qc.ca/" target="_blank">
                            <img id="imgCegep" width="225" class="footerImages" src="../Images/CGHY.jpg" />
                        </a>
                        <a>
                            <img id="imgPreventionSuicide" width="225" class="footerImages" src="../Images/CPS.jpg" />
                        </a>
                    </div>
                </div>
                <div class="span6">
                    <div class="span3">
                        <b class="p_footer">NAVIGATION</b>
                        <hr class="hr_Footer" />
                        <p>
                            <asp:LinkButton ID="LnkBtnNavigation_footer" CssClass="lnkBtn_Footer" runat="server" PostBackUrl="~/Formulaires/index.aspx"><%= outils.obtenirLangue("Accueil|Home")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnHistorique_footer" CssClass="lnkBtn_Footer" runat="server" PostBackUrl="~/Formulaires/FRMhistorique.aspx"><%= outils.obtenirLangue("Historique|History")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnNouvelles_footer" PostBackUrl="~/Formulaires/FRMnouvelles.aspx" CssClass="lnkBtn_Footer" runat="server"><%= outils.obtenirLangue("Nouvelles|News")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnEvenement_footer" PostBackUrl="~/Formulaires/FRMevenements.aspx" CssClass="lnkBtn_Footer" runat="server"><%= outils.obtenirLangue("Événements|Events")%></asp:LinkButton>
                        </p>
                        <p>
                            <asp:LinkButton ID="LnkBtnRDP_footer" PostBackUrl="~/Formulaires/FRMrevuedepresse.aspx" CssClass="lnkBtn_Footer" runat="server"><%= outils.obtenirLangue("Revues de presse|Press Reviews")%></asp:LinkButton>
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
                    </div>
                </div>
                <div style="clear: both;">
                </div>
            </div>

            <%-------------------------------End Footer-----------------------------------%>
        </form>
    </div>
</body>
<script src="../CSS/js/jquery.js"></script>
<script src="../CSS/js/bootstrap.min.js"></script>
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
