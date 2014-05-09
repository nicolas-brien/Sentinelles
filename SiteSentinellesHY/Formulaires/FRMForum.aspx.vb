Imports System.IO
Imports System.Threading
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports System.Data.Entity.Validation
Imports ModeleSentinellesHY

Public Class FRMForum
    Inherits ModeleSentinellesHY.FRMdeBase

    'Liste erreur est déclaré ici afin d'être accessible dans toute les méthodes de cette page
    Dim listeErreur As New List(Of ModeleSentinellesHY.clsErreur)

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Vérifie si l'utilisateur est authentifié
        If Session("Autorisation") Is Nothing Then
            Response.Redirect("index.aspx")
        End If

        imgbtnLogo.ImageUrl = ModeleSentinellesHY.outils.obtenirLangue("~/Images/LogoOfficielHYSmallFR.png|~/Images/LogoOfficielHYSmallEN.png")

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer

        If Not Page.IsPostBack Then
            'Change la vue selon le Query String
            Dim vueActive = Request.QueryString("view")
            Select Case vueActive
                Case 0
                    MultiViewForum.ActiveViewIndex = 0
                Case 1
                    MultiViewForum.ActiveViewIndex = 1
                Case 2
                    MultiViewForum.ActiveViewIndex = 2
                Case 3
                    MultiViewForum.ActiveViewIndex = 3
                Case 4
                    MultiViewForum.ActiveViewIndex = 4
                Case 5
                    MultiViewForum.ActiveViewIndex = 5
                Case Else
                    MultiViewForum.ActiveViewIndex = 0
            End Select

            Dim cat = Request.QueryString("cat")
            Dim id = Request.QueryString("id")

            If (cat <> "" And id <> "") Then
                Dim idPublication = id
                Dim unePublication = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                      Where pub.idPublication = id).FirstOrDefault
                If unePublication.idParent Is Nothing Then
                    ViewState("idPublication") = unePublication.idPublication
                Else
                    ViewState("idPublication") = unePublication.idParent
                End If

                ViewState("idCategorie") = cat

                lviewCategorie.DataBind()
                MultiViewForum.ActiveViewIndex = 2
            End If

        End If


        If Not Session("Utilisateur") Is Nothing Then
            divLogin.Visible = True

            'Affiche l'accès au panneau de controle si l'usager est Intervenant ou Admin
            If CType(Session("Autorisation"), Integer) < 3 Then
                iconSetting.Visible = True
                gererLesCategories.Visible = True
                lnkbtnGererCategorie.Visible = True
            End If

            'Affiche le nom de l'utilisateur
            lblInfoUtilisateur.InnerText = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).nomUtilisateur
        End If

        If Not Page.IsPostBack Then
            Dim di As New DirectoryInfo(Server.MapPath("../Upload/ImagesProfil/"))
            For Each fi As FileInfo In di.GetFiles()
                If (fi.Name.IndexOf("default") < 0) Then
                    Dim utilisateur As Utilisateur
                    utilisateur = leContexte.UtilisateurJeu.Where(Function(x) x.UrlAvatar = fi.Name).FirstOrDefault
                    If (utilisateur Is Nothing) Then
                        Try
                            File.Delete(fi.FullName)
                            'le lorsque le fichier est utilisé par un autre process nous ne pouvons le suprimier alors le catch le capt.
                        Catch
                        End Try
                    End If
                End If
            Next
            'attribution de la photo pat default si trouve pas la photo du profil dans le dossier
            For Each utilisateur As Utilisateur In leContexte.UtilisateurJeu
                If ((di.GetFiles.Where(Function(x) x.Name = utilisateur.UrlAvatar).FirstOrDefault) Is Nothing) Then
                    utilisateur.UrlAvatar = "default.png"
                End If
            Next

            leContexte.SaveChanges()

        End If

    End Sub

    'Effectue des databind lorsque les vues sont changées
    Private Sub MultiViewForum_ActiveViewChanged(sender As Object, e As EventArgs) Handles MultiViewForum.ActiveViewChanged
        If MultiViewForum.ActiveViewIndex = 0 Then
            lblErreurCategorie.Text = ""
        ElseIf MultiViewForum.ActiveViewIndex = 2 Then
            lviewConsulterPublication.DataBind()
        ElseIf MultiViewForum.ActiveViewIndex = 3 Then
            lviewAjouterPublication.DataBind()
        ElseIf MultiViewForum.ActiveViewIndex = 4 Then
            lvInfoUtilisateur.DataBind()
        End If
    End Sub

#Region "Liens_Click"
    Protected Sub lnkAnglais_Click(sender As Object, e As EventArgs)
        Dim culture As String = ""

        culture = ModeleSentinellesHY.outils.obtenirLangue("EN|FR")

        'Mémorise dans un cookie la langue choisie par l'utilisateur
        Dim aCookie As New HttpCookie("SentinellesHY")
        aCookie.Values("langue") = culture
        aCookie.Expires = System.DateTime.Now.AddDays(3650)
        Response.Cookies.Add(aCookie)

        Response.Redirect(Request.Url.AbsoluteUri, False)
    End Sub

    'Méthode qui, lorsque l'on clique sur le nom d'une catégorie, nous amène à la vue de cette catégorie
    'avec toutes les publications qui s'y trouve
    Protected Sub lnkBtn_categorie_Click(sender As Object, e As EventArgs)
        ViewState("idCategorie") = CType(sender, LinkButton).CommandArgument
        lviewCategorie.DataBind()
        MultiViewForum.ActiveViewIndex = 1
    End Sub

    'Méthode qui, lorsque l'on clique sur le titre d'une publication parent, nous amène à la vue de cette publication
    'avec toutes les publications enfants qui s'y trouvent
    Protected Sub lnkBtn_TitrePublication_Click(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim idPublication = CType(sender, LinkButton).CommandArgument
        Dim unePublication = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                              Where pub.idPublication = CType(sender, LinkButton).CommandArgument).FirstOrDefault
        If unePublication.idParent Is Nothing Then
            ViewState("idPublication") = unePublication.idPublication
        Else
            ViewState("idPublication") = unePublication.idParent
        End If

        ViewState("idCategorie") = unePublication.idCategorie

        lviewCategorie.DataBind()
        MultiViewForum.ActiveViewIndex = 2
    End Sub

    'Méthode qui nous amène à la vue d'ajout de publication parent
    Protected Sub lnkbtnAjouterPublication_Click(sender As Object, e As EventArgs)
        MultiViewForum.ActiveViewIndex = 3
        ViewState("modePublication") = "AjoutPublication"
    End Sub

    Protected Sub lnkbtnLogout_Click(sender As Object, e As EventArgs)
        Session("Utilisateur") = Nothing
        Session("Autorisation") = Nothing
        Response.Redirect("index.aspx")
    End Sub
#End Region

#Region "Accueil Forum Vue0"
#Region "Categorie"
    'Ici sont les méthodes afin de gérer les catégories. Cette partie se retrouve sur l'accueil du forum.
    'Elle n'est accessible que pour les administrateurs ainsi que les intervenants
    Public Function getCategorieAccueil() As IQueryable(Of ModeleSentinellesHY.Categorie)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeCategoriePublication As New List(Of ModeleSentinellesHY.Categorie)

        listeCategoriePublication = (From ca In leContexte.CategorieJeu Order By ca.nomCategorieFR).ToList
        Return listeCategoriePublication.AsQueryable
    End Function

    Public Sub DeleteCategorie(ByVal categorieASupprimer As ModeleSentinellesHY.Categorie, sender As Object)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim categorieAValider As ModeleSentinellesHY.Categorie = Nothing

        categorieAValider = leContexte.CategorieJeu.Find(categorieASupprimer.idCategorie)

        Dim listePublication = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                        Where pub.idCategorie = categorieAValider.idCategorie).ToList

        If listePublication.Count <> 0 Then
            lblErreurCategorie.Text = ModeleSentinellesHY.outils.obtenirLangue("La catégorie ne peut pas être supprimée car elle contient des publications.|" _
                                                                               & "The category can not be deleted because it contains publications.")
        Else
            Dim uneCategorie = (From cat As ModeleSentinellesHY.Categorie In leContexte.CategorieJeu _
                                Where cat.idCategorie = categorieAValider.idCategorie).FirstOrDefault
            leContexte.CategorieJeu.Remove(uneCategorie)
            leContexte.SaveChanges()
            lblErreurCategorie.Text = ""
            etatCategorie.Value = "elementSupprime"
            tbNomCategorieEN.Text = ""
            tbNomCategorieFR.Text = ""
        End If
        lvCategorie.DataBind()

        If etatCategorie.Value = "elementSupprime" Then
            gererLesCategories.Attributes("class") = "collapse in"
            etatCategorie.Value = ""
        End If
    End Sub

    Protected Sub lnkbtnAjoutCategorie_Click(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim uneCategorie As New ModeleSentinellesHY.Categorie
        uneCategorie.nomCategorieEN = tbNomCategorieEN.Text
        uneCategorie.nomCategorieFR = tbNomCategorieFR.Text

        'Condition pour vérifier si la catégorie à enregistrer est valide
        If (uneCategorie.nomCategorieEN = "" Or uneCategorie.nomCategorieFR = "") Or _
           (uneCategorie.nomCategorieEN.Count > 50 Or uneCategorie.nomCategorieFR.Count > 50) Then
            lblErreurCategorie.Text = ModeleSentinellesHY.outils.obtenirLangue("Tous les champs doivent contenir un nom valide de moins de 50 caractères." _
                                                                               & "|All fields must contain a valid name of less than 50 characters.")
        Else
            leContexte.CategorieJeu.Add(uneCategorie)
            leContexte.SaveChanges()
            lblErreurCategorie.Text = ""
            tbNomCategorieEN.Text = ""
            tbNomCategorieFR.Text = ""
        End If
        lvCategorie.DataBind()
    End Sub
#End Region
    Public Function getPublications_accueilForum() As IQueryable(Of ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listePublication As New List(Of ModeleSentinellesHY.Publication)
        Dim listeRetour As New List(Of ModeleSentinellesHY.Publication)

        'Pour chaque catégorie, on choisi les trois parents ayant eu la réponse la plus récente
        For Each cat As ModeleSentinellesHY.Categorie In leContexte.CategorieJeu
            Dim listePublicationTemp As New List(Of ModeleSentinellesHY.Publication)
            listePublication = (From uti In leContexte.PublicationJeu Where cat.idCategorie = uti.idCategorie _
             Order By uti.datePublication Descending).ToList()
            For Each pub As ModeleSentinellesHY.Publication In listePublication
                If pub.idParent Is Nothing Then
                    listePublicationTemp.Add(pub)
                Else
                    Dim parent = (From unParent As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                  Where pub.idParent = unParent.idPublication).FirstOrDefault
                    listePublicationTemp.Add(parent)
                End If
            Next
            listeRetour.AddRange(listePublicationTemp.Distinct().Take(5).ToList())
        Next
        Return listeRetour.AsQueryable()
    End Function

    Private Sub lviewPublication_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewForum_accueil.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim DroitUtilisateur = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).idStatut
        Dim unePublication As ModeleSentinellesHY.Publication = CType(e.Item.DataItem, ModeleSentinellesHY.Publication)
        Dim lblPubliePar = CType(e.Item.FindControl("lblPubliePar"), Label)

        'Condition qui vérifie si l'auteur de la publication est encore présent dans la BD
        If Not unePublication.idUtilisateur Is Nothing Then
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Publié par |Posted by ") & unePublication.Utilisateur.nomUtilisateur
        Else
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Utilisateur supprimé|User deleted")
        End If

        'Condition qui affiche en orange le titre de la publication si elle ou un de ses enfants n'a pas été consulté 
        'par un intervenant ou un admin
        If DroitUtilisateur < 3 Then
            If unePublication.consulteParIntervenant = False Then
                CType(e.Item.FindControl("lnkBtn_TitrePublication"), LinkButton).Attributes("style") = "color:orange;"
            Else
                Dim listeEnfants As List(Of ModeleSentinellesHY.Publication) = Nothing
                listeEnfants = (From enf As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                   Where enf.idParent = unePublication.idPublication).ToList
                For Each enf As ModeleSentinellesHY.Publication In listeEnfants
                    If enf.consulteParIntervenant = False Then
                        CType(e.Item.FindControl("lnkBtn_TitrePublication"), LinkButton).Attributes("style") = "color:orange;"
                    End If
                Next
            End If
        End If

        'Affiche la catégorie si c'est la première publication de cette catégorie
        If e.Item.ItemType = ListViewItemType.DataItem AndAlso e.Item.DisplayIndex > 0 Then
            Dim categorieActuelle As String = CType(e.Item.DataItem, ModeleSentinellesHY.Publication).Categorie.idCategorie
            Dim categoriePrecedente As String = lviewForum_accueil.DataKeys(e.Item.DisplayIndex - 1)(1)

            If categorieActuelle = categoriePrecedente Then
                CType(e.Item.FindControl("divCategorie"), HtmlControl).Attributes("style") = "display: none;"

            End If

        End If
    End Sub
#End Region

#Region "Categorie Vue1"
    Public Function getCategories() As IQueryable(Of ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listePublication As New List(Of ModeleSentinellesHY.Publication)
        Dim listePublication2 As New List(Of ModeleSentinellesHY.Publication)
        Dim listeRetour As New List(Of ModeleSentinellesHY.Publication)
        Dim uneCategorie As Integer = ViewState("idCategorie")
        Dim listePublicationTemp As New List(Of ModeleSentinellesHY.Publication)

        'On crée une liste avec que les publications parents épinglées en ordre de date décroissant
        listePublication = (From pub In leContexte.PublicationJeu Where uneCategorie = pub.idCategorie AndAlso pub.epinglee = True _
             Order By pub.datePublication Descending).ToList()
        For Each pub As ModeleSentinellesHY.Publication In listePublication
            If pub.idParent Is Nothing Then
                listePublicationTemp.Add(pub)
            Else
                Dim parent = (From unParent As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                              Where pub.idParent = unParent.idPublication).FirstOrDefault
                listePublicationTemp.Add(parent)
            End If
        Next
        listeRetour.AddRange(listePublicationTemp.ToList())

        'On crée une liste avec que les publications parents non épinglées en ordre de date décroissant
        Dim listePublicationTemp2 As New List(Of ModeleSentinellesHY.Publication)
        listePublication2 = (From pub In leContexte.PublicationJeu Where uneCategorie = pub.idCategorie AndAlso pub.epinglee = False _
             Order By pub.datePublication Descending).ToList()
        For Each pub As ModeleSentinellesHY.Publication In listePublication2
            If pub.idParent Is Nothing Then
                listePublicationTemp2.Add(pub)
            Else
                Dim parent = (From unParent As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                              Where pub.idParent = unParent.idPublication).FirstOrDefault
                listePublicationTemp2.Add(parent)
            End If
        Next

        'On concatène les deux listes dans la même et on enlève ensuite les doublons
        listeRetour.AddRange(listePublicationTemp2.ToList())
        listeRetour = listeRetour.Distinct.ToList

        Return listeRetour.AsQueryable()
    End Function

    Private Sub lviewCategorie_DataBound(sender As Object, e As EventArgs) Handles lviewCategorie.DataBound
        dataPagerHaut.Visible = (dataPagerHaut.PageSize < dataPagerHaut.TotalRowCount)
        dataPagerBas.Visible = (dataPagerBas.PageSize < dataPagerBas.TotalRowCount)
    End Sub

    Private Sub lviewCategorie_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewCategorie.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim DroitUtilisateur = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).idStatut
        Dim unePublication As ModeleSentinellesHY.Publication = CType(e.Item.DataItem, ModeleSentinellesHY.Publication)
        Dim lblPubliePar = CType(e.Item.FindControl("lblPubliePar"), Label)

        'On vérifie que l'utilisateur existe encore dans la BD
        If Not unePublication.idUtilisateur Is Nothing Then
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Publié par |Posted by ") & unePublication.Utilisateur.nomUtilisateur
        Else
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Utilisateur supprimé|User deleted")
        End If

        'Condition qui affiche en orange le titre de la publication si elle ou un de ses enfants n'a pas été consulté 
        'par un intervenant ou un admin
        If DroitUtilisateur < 3 Then
            If unePublication.consulteParIntervenant = False Then
                CType(e.Item.FindControl("lnkBtn_TitrePublication"), LinkButton).Attributes("style") = "color:orange;"
            Else
                Dim listeEnfants As List(Of ModeleSentinellesHY.Publication) = Nothing
                listeEnfants = (From enf As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                   Where enf.idParent = unePublication.idPublication).ToList
                For Each enf As ModeleSentinellesHY.Publication In listeEnfants
                    If enf.consulteParIntervenant = False Then
                        CType(e.Item.FindControl("lnkBtn_TitrePublication"), LinkButton).Attributes("style") = "color:orange;"
                    End If
                Next
            End If
        End If

        'Épingle les "pinned posts"
        If unePublication.epinglee = True Then
            CType(e.Item.FindControl("pinnedIcon"), HtmlImage).Attributes("style") = "display:normal;position:relative;top:5px;"
        End If

        'Affiche le titre de la catégorie lorsqu'on affiche la première publication
        If e.Item.ItemType = ListViewItemType.DataItem AndAlso e.Item.DisplayIndex > 0 Then
            CType(e.Item.FindControl("divCategorie1"), HtmlControl).Attributes("style") = "display: none;"
        End If
    End Sub

    'Liens pour retourner à l'accueil du forum
    Protected Sub retourAccueil_Click(sender As Object, e As EventArgs)
        lviewForum_accueil.DataBind()
        MultiViewForum.ActiveViewIndex = 0
        Response.Redirect("FRMForum.aspx")
    End Sub
#End Region

#Region "Publication+Enfants Vue2"
    Public Sub DeletePublication(ByVal PubADelete As ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listePublication As New List(Of ModeleSentinellesHY.Publication)
        Dim idParent As Integer = ViewState("idPublication")
        listePublication = (From pub In leContexte.PublicationJeu _
                            Where pub.idParent = idParent Or pub.idPublication = idParent).ToList
        Dim pubAValider As ModeleSentinellesHY.Publication = Nothing
        pubAValider = leContexte.PublicationJeu.Find(PubADelete.idPublication)

        If (Not pubAValider Is Nothing) Then
            If pubAValider.idParent Is Nothing Then
                For Each pub As ModeleSentinellesHY.Publication In listePublication
                    leContexte.PublicationJeu.Remove(pub)
                Next
                MultiViewForum.ActiveViewIndex = 1
            Else
                leContexte.PublicationJeu.Remove(pubAValider)
            End If
            leContexte.SaveChanges()
        End If

        lviewForum_accueil.DataBind()
        lviewCategorie.DataBind()
        'Redirige afin d'empecher le rafraichissement
        Response.Redirect("FRMForum.aspx")
    End Sub
    Protected Sub retourCategorie_Click(sender As Object, e As EventArgs)
        'On vérifie si le Viewstate Recherche contient un résultat de recherche. Si c'est le cas,
        'on retourne à la vue de la recherche. Sinon, on retourne à la vue de la catégorie
        If ViewState("Recherche") <> "" Then
            MultiViewForum.ActiveViewIndex = 5
        Else
            lviewCategorie.DataBind()
            MultiViewForum.ActiveViewIndex = 1
        End If
    End Sub

    Private Sub lviewConsulterPublication_DataBound(sender As Object, e As EventArgs) Handles lviewConsulterPublication.DataBound
        dataPagerHautPubs.Visible = (dataPagerHautPubs.PageSize < dataPagerHautPubs.TotalRowCount)
        dataPagerBasPubs.Visible = (dataPagerBasPubs.PageSize < dataPagerBasPubs.TotalRowCount)
    End Sub

    Private Sub lviewConsulterPublication_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewConsulterPublication.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unUtilisateur = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur)
        Dim lblPubliePar = CType(e.Item.FindControl("lblPubliePar"), Label)
        Dim imgAvatar = CType(e.Item.FindControl("imgAvatar"), System.Web.UI.WebControls.Image)
        Dim unePublication As ModeleSentinellesHY.Publication = CType(e.Item.DataItem, ModeleSentinellesHY.Publication)

        'Ici, on permet à l'utilisateur ayant publié une REPONSE à une publication de modifier sa propre publication.
        'Il ne peut pas modifier une publication parent
        If unUtilisateur.idStatut = 3 Then
            If CType(e.Item.DataItem, ModeleSentinellesHY.Publication).idParent Is Nothing Or unUtilisateur.nomUtilisateur <> CType(e.Item.DataItem, ModeleSentinellesHY.Publication).Utilisateur.nomUtilisateur Then
                CType(e.Item.FindControl("divModifierPublication"), HtmlControl).Attributes("style") = "display: none;"
            End If
        End If

        'On affiche le statut de l'auteur du message dans la bonne langue
        If Not unUtilisateur Is Nothing Then
            CType(e.Item.FindControl("lblStatut"), Label).Text = ModeleSentinellesHY.outils.obtenirLangue(CType(e.Item.DataItem, ModeleSentinellesHY.Publication).Utilisateur.Statut.nomStatutFR _
                                                                                                          & "|" & CType(e.Item.DataItem, ModeleSentinellesHY.Publication).Utilisateur.Statut.nomStatutEN)
        End If

        If unePublication.Utilisateur.idStatut = 1 Then
            CType(e.Item.FindControl("lblStatut"), Label).CssClass = "lblCouleurStatut_administrateur"
        ElseIf unePublication.Utilisateur.idStatut = 2 Then
            CType(e.Item.FindControl("lblStatut"), Label).CssClass = "lblCouleurStatut_intervenant"
        End If


        'On affiche l'image de la publication épinglée
        If unePublication.epinglee = True Then
            CType(e.Item.FindControl("pinnedIcon"), HtmlImage).Attributes("style") = "display:normal;position:relative;top:5px;"
        End If

        If Not unePublication.idParent Is Nothing Or unUtilisateur.idStatut = 3 Then
            CType(e.Item.FindControl("divPinned"), HtmlControl).Attributes("style") = "display:none;"
        End If

        'On vérifie si l'utilisateur existe encore dans la BD
        If Not unePublication.idUtilisateur Is Nothing Then
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Publié par |Posted by ") & unePublication.Utilisateur.nomUtilisateur
            imgAvatar.ImageUrl = "../Upload/ImagesProfil/" & unePublication.Utilisateur.UrlAvatar
        Else
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Utilisateur supprimé|User deleted")
            imgAvatar.ImageUrl = "../Upload/ImagesProfil/default.png"
        End If

        'Condition qui affiche en orange le titre de la publication si elle ou un de ses enfants n'a pas été consulté 
        'par un intervenant ou un admin après quoi le titre redevient normal au prochain affichage
        If unePublication.consulteParIntervenant = False AndAlso unUtilisateur.idStatut < 3 Then
            CType(e.Item.FindControl("lblTitrePublication"), Label).Attributes("style") = "color:orange;"
            unePublication.consulteParIntervenant = True
            leContexte.SaveChanges()
        End If

        'Si ce n'est pas une publication parent, on n'affiche pas le div de la catégorie et on met un Re: devant le titre
        If e.Item.ItemType = ListViewItemType.DataItem AndAlso e.Item.DisplayIndex > 0 Then
            CType(e.Item.FindControl("divNomCategorie"), HtmlControl).Attributes("style") = "display: none;"
            CType(e.Item.FindControl("lblTitrePublication"), Label).Text = ("Re : " & unePublication.titre)
        End If
    End Sub
    Public Function getConsulterPublication() As IQueryable(Of ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listePublication As New List(Of ModeleSentinellesHY.Publication)
        Dim idPublication As Integer = ViewState("idPublication")

        listePublication = (From uti In leContexte.PublicationJeu Where uti.idPublication = idPublication).ToList.Union _
        (From uti In leContexte.PublicationJeu Where uti.idParent = idPublication Order By uti.datePublication).ToList

        ViewState("idCategorie") = listePublication.Item(0).idCategorie

        Return listePublication.AsQueryable()
    End Function

    'Méthode utiliser dans la fenêtre modal pour modifier une publication existante
    Protected Sub lnkbtnModifierPublication_Click(sender As Object, e As EventArgs)
        Dim noItem = CType(sender, LinkButton).CommandArgument
        ViewState("noItem") = noItem
        'On force ici l'appel de la méthode Update du ListView
        lviewConsulterPublication.UpdateItem(noItem, False)
    End Sub

    Public Sub UpdatePublication(ByVal publicationAUpdater As ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim noItem = ViewState("noItem")
        Dim listeEnfants = New List(Of Publication)

        listeEnfants = (From pub As Publication In leContexte.PublicationJeu _
                        Where pub.idParent = publicationAUpdater.idPublication).ToList()
        Dim lblMessageErreurModifierPublication = CType(lviewConsulterPublication.Items(noItem).FindControl("lblMessageErreurModifierPublication"), Label)
        lblMessageErreurModifierPublication.Text = ""
        lblMessageErreurModifierPublication.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewConsulterPublication.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        publicationAUpdater = (From pub In leContexte.PublicationJeu _
                                       Where pub.idPublication = publicationAUpdater.idPublication).FirstOrDefault
        TryUpdateModel(publicationAUpdater)

        For Each enfant As Publication In listeEnfants
            enfant.titre = publicationAUpdater.titre
        Next

        'Remplace les div par des p pour un retour à la ligne
        If Not publicationAUpdater.contenu = Nothing Then
            publicationAUpdater.contenu = publicationAUpdater.contenu.Replace("<div", "<p")
            publicationAUpdater.contenu = publicationAUpdater.contenu.Replace("</div>", "</p>")
        End If

        'On attribue à la publication son utilisateur et sa catégorie
        publicationAUpdater.Utilisateur = (From pub In leContexte.PublicationJeu _
                                       Where pub.idPublication = publicationAUpdater.idPublication).FirstOrDefault.Utilisateur
        publicationAUpdater.Categorie = (From pub In leContexte.PublicationJeu _
                                       Where pub.idPublication = publicationAUpdater.idPublication).FirstOrDefault.Categorie
        ModeleSentinellesHY.outils.validationFormulaire(publicationAUpdater, New ModeleSentinellesHY.PublicationValidation(), lviewConsulterPublication, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurModifierPublication.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If
        If ModelState.IsValid Then
            If listeErreur.Count = 0 Then
                leContexte.SaveChanges()
                lviewConsulterPublication.DataBind()
            End If
        End If
        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            CType(lviewConsulterPublication.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
        Next

    End Sub
    Public Sub UpdateAjouterReponse()
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        'Méthode qui sert à ajouter une réponse à une publication
        Dim lblMessageErreurReponse = CType(lviewConsulterPublication.FindControl("lblMessageErreurReponse"), Label)
        Dim reponseAValider As New ModeleSentinellesHY.Publication
        lblMessageErreurReponse.Text = ""
        lblMessageErreurReponse.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewConsulterPublication.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        reponseAValider = New ModeleSentinellesHY.Publication
        TryUpdateModel(reponseAValider)

        'Remplace les div par des p pour un retour à la ligne
        If Not reponseAValider.contenu = Nothing Then
            reponseAValider.contenu = reponseAValider.contenu.Replace("<div", "<p")
            reponseAValider.contenu = reponseAValider.contenu.Replace("</div>", "</p>")
        End If

        reponseAValider.datePublication = Date.Now()
        reponseAValider.idParent = CType(ViewState("idPublication"), Integer)
        reponseAValider.Utilisateur = outils.getCleanUser(leContexte, Session)
        reponseAValider.idCategorie = (From pub In leContexte.PublicationJeu _
                                       Where pub.idPublication = reponseAValider.idParent).FirstOrDefault.idCategorie
        reponseAValider.titre = (From pub In leContexte.PublicationJeu _
                                 Where pub.idPublication = reponseAValider.idParent).FirstOrDefault().titre
        ModeleSentinellesHY.outils.validationFormulaire(reponseAValider, New ModeleSentinellesHY.PublicationValidation(), lviewAjouterReponse, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurReponse.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If
        If listeErreur.Count = 0 Then
            leContexte.PublicationJeu.Add(reponseAValider)
            leContexte.SaveChanges()
            CType(lviewAjouterReponse.Items(0).FindControl("txtboxcontenu"), TextBox).Text = ""
            lviewConsulterPublication.DataBind()

            Response.Redirect("FRMForum.aspx?cat=" & ViewState("idCategorie") & "&id=" & ViewState("idPublication"))

        End If

        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            If Not erreur.nomPropriete.ToString.Contains("Categorie") Then
                CType(lviewConsulterPublication.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
            Else
                CType(lviewConsulterPublication.Items(0).FindControl("ddlstCategorie"), DropDownList).BorderColor = Drawing.Color.Red
            End If
        Next
    End Sub
    Public Shared Function getReponse_ajouterReponse() As ModeleSentinellesHY.Publication
        'Retourne une publication vide afin de donner les valeurs du constructeur dans les champs du listview
        Dim listePublication As New ModeleSentinellesHY.Publication
        Return listePublication
    End Function
#End Region

#Region "Ajout Publication Vue3"
    Public Function getCategories_AjouterPublication() As IQueryable(Of ModeleSentinellesHY.Categorie)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeCategoriePublication As New List(Of ModeleSentinellesHY.Categorie)

        listeCategoriePublication = (From ca In leContexte.CategorieJeu).ToList

        'On ajoute la catégorie suivante afin d'obliger l'usager à en choisir une
        Dim CategorieDefault As New ModeleSentinellesHY.Categorie
        CategorieDefault.idCategorie = 0
        CategorieDefault.nomCategorieFR = "Sélectionner une catégorie"
        CategorieDefault.nomCategorieEN = "Select a category"
        listeCategoriePublication.Insert(0, CategorieDefault)

        For Each categorie As ModeleSentinellesHY.Categorie In listeCategoriePublication
            categorie.nomCategorie = ModeleSentinellesHY.outils.obtenirLangue(categorie.nomCategorieFR & "|" & categorie.nomCategorieEN)
        Next
        Return listeCategoriePublication.AsQueryable
    End Function

    Public Sub UpdateAjouterPublication(ByVal publicationAUpdater As ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lblMessageErreurPublication = CType(lviewAjouterPublication.FindControl("lblMessageErreurPublication"), Label)
        Dim publicationAValider As ModeleSentinellesHY.Publication = Nothing
        lblMessageErreurPublication.Text = ""
        lblMessageErreurPublication.ForeColor = Drawing.Color.Red

        For Each tb As Object In lviewAjouterPublication.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        publicationAValider = New ModeleSentinellesHY.Publication
        TryUpdateModel(publicationAValider)

        'Remplace les div par des p pour un retour à la ligne
        If Not publicationAValider.contenu = Nothing Then
            publicationAValider.contenu = publicationAValider.contenu.Replace("<div", "<p")
            publicationAValider.contenu = publicationAValider.contenu.Replace("</div>", "</p>")
        End If
        publicationAValider.datePublication = Date.Now()
        publicationAValider.Utilisateur = outils.getCleanUser(leContexte, Session)

        'On vérifie si la catégorie a été changée
        If publicationAValider.idCategorie = 0 Then
            ModelState.AddModelError("idCategorie", "Vous devez choisir une catégorie|You must choose a category")
            publicationAValider.idCategorie = Nothing
        Else
            publicationAValider.Categorie = (From cat In leContexte.CategorieJeu _
                                             Where cat.idCategorie = publicationAValider.idCategorie).FirstOrDefault()
        End If

        ModeleSentinellesHY.outils.validationFormulaire(publicationAValider, New ModeleSentinellesHY.PublicationValidation(), lviewAjouterPublication, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurPublication.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If

        If ModelState.IsValid Then
            leContexte.PublicationJeu.Add(publicationAValider)
            leContexte.SaveChanges()
            ViewState("idCategorie") = publicationAValider.idCategorie
            MultiViewForum.ActiveViewIndex = 1
            ViewState("modePublication") = ""

            'On reset les valeurs
            CType(lviewAjouterPublication.Items(0).FindControl("ddlstCategorie"), DropDownList).SelectedValue = 0
            CType(lviewAjouterPublication.Items(0).FindControl("txtboxtitre"), TextBox).Text = ""
            CType(lviewAjouterPublication.Items(0).FindControl("txtboxcontenu"), TextBox).Text = ""

            lviewForum_accueil.DataBind()
            lviewCategorie.DataBind()
        End If
        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            If Not erreur.nomPropriete.ToString.Contains("Categorie") Then
                CType(lviewAjouterPublication.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
            Else
                CType(lviewAjouterPublication.Items(0).FindControl("ddlstCategorie"), DropDownList).BorderColor = Drawing.Color.Red
            End If
        Next
    End Sub

    Public Shared Function getPublication_ajouterPublication() As ModeleSentinellesHY.Publication
        'On retourne une publication vide afin de fournir le listview d'ajout de publication
        Dim unePublication As New ModeleSentinellesHY.Publication
        Return unePublication
    End Function

    Private Sub lviewAjouterPublication_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewAjouterPublication.ItemDataBound
        Dim unUtilisateur = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur)

        'On cache ce div afin que les usagers qui ne sont pas Admin ou Intervenant ne puissent pas 
        'épingler une publication
        If unUtilisateur.idStatut = 3 Then
            CType(e.Item.FindControl("divPinned"), HtmlControl).Attributes("style") = "display:none;"
        End If
    End Sub
#End Region

#Region "InfoUtilisateur Vue4"
    Protected Sub vCrop_Activate(sender As Object, e As EventArgs)
        Dim controlUpload = CType(lvInfoUtilisateur.Items(0).FindControl("fuplPhoto"), FileUpload)


        If controlUpload.PostedFile.ContentType = "image/jpeg" Or controlUpload.PostedFile.ContentType = "image/png" Then
            Dim newFileName As String = ""
            Dim nomFichier As String = Path.GetFileName(controlUpload.FileName)
            'Save it in the server images folder
            Dim random As New Random()
            Dim rndnbr As Integer = 0
            rndnbr = random.[Next](0, 99999)
            newFileName = "AvantCrop-" + rndnbr.ToString + nomFichier

            controlUpload.SaveAs(Server.MapPath("../Upload/ImagesProfil/" & newFileName))

            Dim cropbox = CType(lvInfoUtilisateur.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
            cropbox.ImageUrl = "~/Upload/ImagesProfil/" & newFileName
        End If

    End Sub

    Protected Sub imageRotateLeft_Click(sender As Object, e As EventArgs)
        Dim cropbox = CType(lvInfoUtilisateur.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim path As [String] = Server.MapPath(cropbox.ImageUrl)
        Dim img As System.Drawing.Image = System.Drawing.Image.FromFile(path)
        img.RotateFlip(RotateFlipType.Rotate270FlipNone)
        img.Save(path)
    End Sub

    Protected Sub imageRotateRght_Click(sender As Object, e As EventArgs)
        Dim cropbox = CType(lvInfoUtilisateur.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim path As [String] = Server.MapPath(cropbox.ImageUrl)
        Dim img As System.Drawing.Image = System.Drawing.Image.FromFile(path)
        img.RotateFlip(RotateFlipType.Rotate90FlipNone)
        img.Save(path)
    End Sub
    Protected Sub btCropGo_Click(sender As Object, e As EventArgs)
        'Load the Image from the location
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim cropbox = CType(lvInfoUtilisateur.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim image As System.Drawing.Image = Bitmap.FromFile(Server.MapPath(cropbox.ImageUrl))
        Dim unFichier As String = Server.MapPath(cropbox.ImageUrl)
        Dim ratio As Double = image.Height / 250.0
        Dim nomFichier As String = ""

        Dim utilisateurAValider As ModeleSentinellesHY.Utilisateur = Session("Utilisateur")

        'Get the Cordinates
        Dim X = CType(lvInfoUtilisateur.Items(0).FindControl("X"), System.Web.UI.WebControls.HiddenField)
        Dim Y = CType(lvInfoUtilisateur.Items(0).FindControl("Y"), System.Web.UI.WebControls.HiddenField)
        Dim W = CType(lvInfoUtilisateur.Items(0).FindControl("W"), System.Web.UI.WebControls.HiddenField)
        Dim H = CType(lvInfoUtilisateur.Items(0).FindControl("H"), System.Web.UI.WebControls.HiddenField)

        Dim x__1 As Integer = Convert.ToInt32(Convert.ToDouble(X.Value) * (ratio))
        Dim y__2 As Integer = Convert.ToInt32(Convert.ToDouble(Y.Value) * (ratio))
        Dim w__3 As Integer = Convert.ToInt32(Convert.ToDouble(W.Value) * (ratio))
        Dim h__4 As Integer = Convert.ToInt32(Convert.ToDouble(H.Value) * (ratio))

        If (w__3 = 0) Then
            x__1 = 0
            y__2 = 0
            w__3 = image.Width
            h__4 = image.Height

        End If

        'Create a new image from the specified location to
        'specified height and width
        Dim bmp As New Bitmap(400, 400, image.PixelFormat)
        Dim g As Graphics = Graphics.FromImage(bmp)
        g.DrawImage(image, New Rectangle(0, 0, 400, 400), New Rectangle(x__1, y__2, w__3, h__4), GraphicsUnit.Pixel)
        'Save the file and reload to the control

        'On ajoute un nombre aléatoire à la fin du fichier afin d'éviter d'écraser les photos existantes
        Dim MyRandomNumber As New Random()
        Dim xr As Integer = MyRandomNumber.Next(10000, 100000)
        nomFichier = xr.ToString + ".jpg"

        bmp.Save(Server.MapPath("../Upload/ImagesProfil/") + nomFichier, image.RawFormat)
        utilisateurAValider.UrlAvatar = nomFichier

        leContexte.SaveChanges()
        lvInfoUtilisateur.DataBind()
        CType(lvInfoUtilisateur.Items(0).FindControl("mvPhotos"), MultiView).ActiveViewIndex = 0

    End Sub
    Public Function getInfoUtilisateur() As ModeleSentinellesHY.Utilisateur
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unUtilisateur As New ModeleSentinellesHY.Utilisateur
        If Not Session("Utilisateur") Is Nothing Then
            Dim idUtilisateur = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).idUtilisateur
            unUtilisateur = (From uti In leContexte.UtilisateurJeu Where uti.idUtilisateur = idUtilisateur).FirstOrDefault
            leContexte.Entry(unUtilisateur).Reload()
        Else
            'S'il n'y a aucun utilisateur, on redirige vers l'index puisqu'on ne pourra pas afficher les infos
            Response.Redirect("index.aspx")
        End If
        Return unUtilisateur
    End Function

    Public Sub updateInfoUtilisateur(ByVal idUtilisateur As Integer)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lblMessageErreur = CType(lvInfoUtilisateur.FindControl("lblMessageErreur"), Label)
        Dim divMessageErreur = CType(lvInfoUtilisateur.FindControl("divMessageErreur"), Panel)
        Dim utilisateurAValider As ModeleSentinellesHY.Utilisateur = Nothing
        Dim tbMotDePasse As String = CType(lvInfoUtilisateur.Items(0).FindControl("tbMotDePasse"), TextBox).Text
        Dim tbConfirmation As String = CType(lvInfoUtilisateur.Items(0).FindControl("tbConfirmer"), TextBox).Text

        lblMessageErreur.Text = ""
        divMessageErreur.CssClass = "alert alert-error"
        divMessageErreur.Visible = True
        For Each tb As Object In lvInfoUtilisateur.Items(0).Controls 'Reset l'encadrer autour de tout txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next

        utilisateurAValider = leContexte.UtilisateurJeu.Find(idUtilisateur)

        'Prend les données qui sont dans le formulaire
        TryUpdateModel(utilisateurAValider)

        'Url Avatar avant de l'avoir enregistré. Permet de remettre l'url si l'usager n'est pas enregistré
        utilisateurAValider.urlAvatarTemp = utilisateurAValider.UrlAvatar

        ModeleSentinellesHY.outils.validationUtilisateur(utilisateurAValider, New ModeleSentinellesHY.UtilisateurValidation(), lvInfoUtilisateur, listeErreur)

        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreur.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If

        If ModelState.IsValid Then
            leContexte.SaveChanges()
            divMessageErreur.CssClass = "alert alert-success"
            divMessageErreur.Visible = True
            lblMessageErreur.Text = ModeleSentinellesHY.outils.obtenirLangue("L'utilisateur a été modifié avec succès!|The user has been successfully updated!")


            'Conditions pour Supprimer Avatar du fichier Upload mais ne pas supprimer la photo par défaut
            If utilisateurAValider.UrlAvatar <> utilisateurAValider.urlAvatarTemp AndAlso utilisateurAValider.UrlAvatar <> "" _
                AndAlso utilisateurAValider.UrlAvatar <> "default.png" Then
                ModeleSentinellesHY.outils.SupprimerFichierUpload(utilisateurAValider.urlAvatarTemp)
            End If
            lvInfoUtilisateur.DataBind()
        Else

            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                If Not erreur.nomPropriete Is Nothing Then
                    CType(lvInfoUtilisateur.Items(0).FindControl("tb" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
                ElseIf erreur.errorMessage.ToString.Contains("pass") Then
                    CType(lvInfoUtilisateur.Items(0).FindControl("tbMotDePasse"), TextBox).BorderColor = Drawing.Color.Red
                    CType(lvInfoUtilisateur.Items(0).FindControl("tbConfirmer"), TextBox).BorderColor = Drawing.Color.Red
                End If
            Next
        End If
        utilisateurAValider.motDePasseTemp = ""
        utilisateurAValider.confirmationMotDePasse = ""
    End Sub

    Protected Sub lnkUpload_Click(sender As Object, e As EventArgs)
        Dim lblMessageErreur = CType(lvInfoUtilisateur.FindControl("lblMessageErreur"), Label)
        Dim divMessageErreur = CType(lvInfoUtilisateur.FindControl("divMessageErreur"), Panel)
        lblMessageErreur.Text = ""
        divMessageErreur.CssClass = "alert alert-error"
        divMessageErreur.Visible = False
        CType(lvInfoUtilisateur.Items(0).FindControl("mvPhotos"), MultiView).ActiveViewIndex = 1

    End Sub

    Public Shared Function ResizeImageFile(imageFileMS As Stream, targetSize As Integer, lepathfichier As String, typeUpload As String) As String

        'Fonction qui redimensionne selon un format pour l'avatar ou selon les images du carrousel
        Dim original As Image = Image.FromStream(imageFileMS)
        Dim targetH As Integer, targetW As Integer
        If typeUpload.Contains("typeAvatar") Then
            If original.Height > original.Width Then
                targetH = targetSize
                targetW = CInt(original.Width * (CSng(targetSize) / CSng(original.Height)))
            Else
                targetW = targetSize
                targetH = CInt(original.Height * (CSng(targetSize) / CSng(original.Width)))
            End If
        Else
            targetH = 200
            targetW = 960
        End If

        Dim imgPhoto As Image = Image.FromStream(imageFileMS)
        ' Create a new blank canvas.  The resized image will be drawn on this canvas.
        Dim bmPhoto As New Bitmap(targetW, targetH, PixelFormat.Format24bppRgb)
        bmPhoto.SetResolution(72, 72)

        Dim grPhoto As Graphics = Graphics.FromImage(bmPhoto)
        grPhoto.SmoothingMode = SmoothingMode.AntiAlias
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic
        grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality
        grPhoto.DrawImage(imgPhoto, New Rectangle(0, 0, targetW, targetH), 0, 0, original.Width, original.Height, _
            GraphicsUnit.Pixel)
        bmPhoto.Save(lepathfichier, System.Drawing.Imaging.ImageFormat.Jpeg)
        original.Dispose()
        imgPhoto.Dispose()
        bmPhoto.Dispose()
        grPhoto.Dispose()

        Return ""
    End Function

    Protected Sub rbtnSexe_Init(sender As Object, e As EventArgs)
        Dim Homme As New ListItem
        Dim Femme As New ListItem
        Homme.Value = "H"
        Femme.Value = "F"

        Femme.Text = ModeleSentinellesHY.outils.obtenirLangue("Femme|Female")
        Homme.Text = ModeleSentinellesHY.outils.obtenirLangue("Homme|Male")

        CType(sender, RadioButtonList).Items.Add(Femme)
        CType(sender, RadioButtonList).Items.Add(Homme)
    End Sub
    Public Function getStatutUtilisateur() As IQueryable(Of ModeleSentinellesHY.Statut)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeStatutUtilisateur As New List(Of ModeleSentinellesHY.Statut)

        listeStatutUtilisateur = (From ca In leContexte.StatutJeu).ToList

        For Each statut As ModeleSentinellesHY.Statut In listeStatutUtilisateur
            statut.nomStatut = ModeleSentinellesHY.outils.obtenirLangue(statut.nomStatutFR & "|" & statut.nomStatutEN)
        Next

        Return listeStatutUtilisateur.AsQueryable
    End Function

    Protected Sub btnAnnulerInfos_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/Formulaires/FRMForum.aspx?view=4", False)
    End Sub

#End Region

#Region "Recherche Vue5"
    Protected Sub btnRecherche_Click(sender As Object, e As EventArgs)
        'Lorsqu'on clique, on change de vue, on vide la barre de recherche du haut et on met le texte recherché
        'dans la barre de recherche de la vue. Le ViewState mémorise le texte recherché afin que le bouton précédent
        'de la vue Publication+Enfant sache s'il doit redirigé vers la vue Catégorie ou la vue Résultat de recherche
        'et aussi pour permettre de faire la recherche dans la BD
        MultiViewForum.ActiveViewIndex = 5
        ViewState("Recherche") = tbRecherche.Text
        tbRechercheAvancee.Text = tbRecherche.Text
        tbRecherche.Text = ""
        lvResultatRecherche.DataBind()
    End Sub

    'Petite fonction afin de permettre l'autocomplétion sur la barre de recherche.
    <System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()>
    Public Shared Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer

        Dim autoCompleteList() As String = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Select pub.Categorie.nomCategorieEN).Union _
                                (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Select pub.Categorie.nomCategorieFR).ToArray.Union _
                                (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Select pub.titre).ToArray

        Return (
            From obj In autoCompleteList
            Where obj.ToLower.Contains(prefixText.ToLower)
            Select obj).Take(count).ToArray()
    End Function

    'On peut effectuer les recherches selon plusieurs critères
    Public Function getResultatRecherche() As IQueryable(Of ModeleSentinellesHY.Publication)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeResultat As New List(Of ModeleSentinellesHY.Publication)
        Dim texteRecherche = ViewState("Recherche")

        'On peut chercher par catégorie ou pour toutes les catégories
        Dim noCategorie = DDLRechercheAvancee.SelectedValue

        'On peut choisir une intervalle pour effectuer la recherche
        Dim dateDepart = tbDateDebut.Text
        Dim dateFin = tbDateFin.Text

        'On vérifie quels sont les endroits où l'usager souhaite effectuer sa recherche
        Dim rechercherTitre = CBLRechercheAvancee.Items(0).Selected
        Dim rechercherContenu = CBLRechercheAvancee.Items(1).Selected
        Dim rechercherUsager = CBLRechercheAvancee.Items(2).Selected

        lblQuantiteReponse.Text = 0
        lblReponse.Text = ModeleSentinellesHY.outils.obtenirLangue("RÉSULTAT|RESULT")

        If texteRecherche.ToString & "" <> "" Then
            Dim listeResultatTemp As New List(Of ModeleSentinellesHY.Publication)
            If rechercherTitre Then
                Dim listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.titre.Contains(texteRecherche)).ToList()
                listeResultatTemp.AddRange(listeResultatPartiel)
            End If
            If rechercherContenu Then
                Dim listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.contenu.Contains(texteRecherche)).ToList()
                listeResultatTemp.AddRange(listeResultatPartiel)
            End If
            If rechercherUsager Then
                Dim listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.Utilisateur.nomUtilisateur.Contains(texteRecherche)).ToList()
                listeResultatTemp.AddRange(listeResultatPartiel)
            End If

            'Comme on n'affiche que la publication parent dans les résultats de la recherche, on fait cette boucle
            For Each pub As ModeleSentinellesHY.Publication In listeResultatTemp
                If pub.idParent Is Nothing Then
                    listeResultat.Add(pub)
                Else
                    Dim parent = (From unePub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                  Where unePub.idPublication = pub.idParent).FirstOrDefault
                    listeResultat.Add(parent)
                End If
            Next

            'On élimine les doublons
            listeResultat = listeResultat.Distinct().ToList()

            Dim unedate As Date
            If Date.TryParse(dateDepart, unedate) Then
                Dim listeResultatPartiel = listeResultat.Where(Function(x) x.datePublication >= dateDepart).ToList
                listeResultat = listeResultatPartiel
            End If
            If Date.TryParse(dateFin, unedate) Then
                'On ajoute une journée dans la requête afin d'inclure la journée sélectionnée avec le calendrier jusqu'à minuit de cette journée
                Dim listeResultatPartiel = listeResultat.Where(Function(x) x.datePublication <= CType(dateFin, Date).AddDays(1)).ToList
                listeResultat = listeResultatPartiel
            End If

            If noCategorie <> 0 Then
                Dim listeResultatPartiel = listeResultat.Where(Function(x) x.idCategorie = noCategorie).ToList
                listeResultat = listeResultatPartiel
            End If

            lblQuantiteReponse.Text = listeResultat.Count
            If listeResultat.Count > 1 Then
                lblReponse.Text = ModeleSentinellesHY.outils.obtenirLangue("RÉSULTATS|RESULTS")
            End If
        Else
            'Cette section a été ajouter au cas ou la personne veut faire une recherche sur les critères au lieu du text
            'Effectue une recherche de catégorie et par date
            Dim listeResultatTemp As New List(Of ModeleSentinellesHY.Publication)
            Dim listeResultatPartiel As New List(Of ModeleSentinellesHY.Publication)
            If DDLRechercheAvancee.SelectedValue = 0 Then
                Dim dateDeDebut As Date
                Dim dateDeFin As Date

                If tbDateDebut.Text & "" <> "" Then
                    If tbDateFin.Text & "" <> "" Then
                        If Date.TryParse(tbDateDebut.Text, dateDeDebut) Or Date.TryParse(tbDateFin.Text, dateDeFin) Then
                            listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.datePublication >= dateDeDebut And pub.datePublication <= dateDeFin).ToList()
                        End If
                    Else
                        If Date.TryParse(tbDateDebut.Text, dateDeDebut) Then
                            listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.datePublication >= dateDeDebut).ToList()
                        End If
                    End If
                Else
                    listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu).ToList()
                End If
            Else
                Dim dateDeDebut As Date
                Dim dateDeFin As Date

                If tbDateDebut.Text & "" <> "" Then
                    If tbDateFin.Text & "" <> "" Then
                        If Date.TryParse(tbDateDebut.Text, dateDeDebut) Or Date.TryParse(tbDateFin.Text, dateDeFin) Then
                            listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.Categorie.idCategorie = DDLRechercheAvancee.SelectedValue And pub.datePublication >= dateDeDebut And pub.datePublication <= dateDeFin).ToList()
                        End If
                    Else
                        If Date.TryParse(tbDateDebut.Text, dateDeDebut) Then
                            listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.Categorie.idCategorie = DDLRechercheAvancee.SelectedValue And pub.datePublication >= dateDeDebut).ToList()
                        End If
                    End If
                Else
                    listeResultatPartiel = (From pub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu Where pub.Categorie.idCategorie = DDLRechercheAvancee.SelectedValue).ToList()
                End If

            End If

            listeResultatTemp.AddRange(listeResultatPartiel)

            For Each pub As ModeleSentinellesHY.Publication In listeResultatTemp
                If pub.idParent Is Nothing Then
                    listeResultat.Add(pub)
                Else
                    Dim parent = (From unePub As ModeleSentinellesHY.Publication In leContexte.PublicationJeu _
                                  Where unePub.idPublication = pub.idParent).FirstOrDefault
                    listeResultat.Add(parent)
                End If
            Next
        End If

        Return listeResultat.AsQueryable
    End Function

    Protected Sub btnRechercheAvancee_Click(sender As Object, e As EventArgs)
        ViewState("Recherche") = tbRechercheAvancee.Text
        lvResultatRecherche.DataBind()
    End Sub

    Protected Sub CBLRechercheAvancee_Init(sender As Object, e As EventArgs)
        Dim unTitre As New ListItem
        Dim unContenu As New ListItem
        Dim unUsager As New ListItem

        unTitre.Value = 0
        unContenu.Value = 1
        unUsager.Value = 2

        unTitre.Text = ModeleSentinellesHY.outils.obtenirLangue("Titre|Title")
        unContenu.Text = ModeleSentinellesHY.outils.obtenirLangue("Contenu|Content")
        unUsager.Text = ModeleSentinellesHY.outils.obtenirLangue("Nom d'usager|Username")

        CType(sender, CheckBoxList).Items.Add(unTitre)
        CType(sender, CheckBoxList).Items.Add(unContenu)
        CType(sender, CheckBoxList).Items.Add(unUsager)

        CType(sender, CheckBoxList).Items(0).Selected = True
        CType(sender, CheckBoxList).Items(1).Selected = True
        CType(sender, CheckBoxList).Items(2).Selected = False

    End Sub

    Protected Sub DDLRechercheAvancee_Init(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim toutesCategories As New ListItem

        toutesCategories.Text = ModeleSentinellesHY.outils.obtenirLangue("Toutes les catégories|All categories")

        toutesCategories.Value = 0
        CType(sender, DropDownList).Items.Add(toutesCategories)

        For Each cat As ModeleSentinellesHY.Categorie In leContexte.CategorieJeu
            Dim uneCategorie As New ListItem
            uneCategorie.Text = ModeleSentinellesHY.outils.obtenirLangue(cat.nomCategorieFR & "|" & cat.nomCategorieEN)

            uneCategorie.Value = cat.idCategorie
            CType(sender, DropDownList).Items.Add(uneCategorie)
        Next
    End Sub

    Protected Sub tbDateFin_Init(sender As Object, e As EventArgs)
        CType(sender, TextBox).Text = Left(Date.Now.ToString, 10)
    End Sub

    Protected Sub lvResultatRecherche_DataBound(sender As Object, e As EventArgs)
        DPResultatRechercheHaut.Visible = (DPResultatRechercheHaut.PageSize < DPResultatRechercheHaut.TotalRowCount)
        DPResultatRechercheBas.Visible = (DPResultatRechercheBas.PageSize < DPResultatRechercheBas.TotalRowCount)
    End Sub

    Private Sub lvResultatRecherche_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvResultatRecherche.ItemDataBound
        Dim lblPubliePar = CType(e.Item.FindControl("lblPubliePar"), Label)
        Dim imgAvatar = CType(e.Item.FindControl("imgAvatar"), System.Web.UI.WebControls.Image)
        Dim unePublication As ModeleSentinellesHY.Publication = CType(e.Item.DataItem, ModeleSentinellesHY.Publication)

        'On vérifie si l'utilisateur ayant publié la publication existe encore dans la BD
        If Not unePublication.idUtilisateur Is Nothing Then
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Publié par |Posted by ") & unePublication.Utilisateur.nomUtilisateur
            imgAvatar.ImageUrl = "../Upload/ImagesProfil/" & unePublication.Utilisateur.UrlAvatar
        Else
            lblPubliePar.Text = ModeleSentinellesHY.outils.obtenirLangue("Utilisateur supprimé|User deleted")
            imgAvatar.ImageUrl = "../Upload/ImagesProfil/default.png"
        End If
    End Sub
#End Region

End Class