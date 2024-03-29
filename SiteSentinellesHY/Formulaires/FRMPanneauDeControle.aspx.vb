﻿'Rechercher #Region "Utilisateur" afin d'accéder directement au bon endroit dans le document

Imports System.IO
Imports System.Threading
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports System.Data.Entity.Validation
Imports System.ComponentModel.DataAnnotations
Imports ModeleSentinellesHY
Imports AjaxControlToolkit

Public Class FRMPanneauDeControle
    Inherits ModeleSentinellesHY.FRMdeBase

    Dim listeErreur As New List(Of ModeleSentinellesHY.clsErreur)

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init

        'On vérifie que l'usager qui tente d'accéder à la page est authentifier et qu'il ne s'agit
        'pas d'un Sentinelle
        If Not Session("Autorisation") = 1 AndAlso Not Session("Autorisation") = 2 Then
            Response.Redirect("index.aspx")
        End If

        imgbtnLogo.ImageUrl = ModeleSentinellesHY.outils.obtenirLangue("~/Images/LogoOfficielHYSmallFR.png|~/Images/LogoOfficielHYSmallEN.png")
        If Request.QueryString("error") <> "" Then
            lblMessageErreurEnvoiMessage.Text = Request.QueryString("error")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        If Not ViewState("vue") Is Nothing Then
            If Page.IsPostBack Then
                'On affiche la bonne vue qui est mémorisé dans le Viewstate
                MultiView.ActiveViewIndex = ViewState("vue")
            End If
        Else
            MultiView.ActiveViewIndex = 0
        End If

        If Not Page.IsPostBack Then
            lviewNouvelle.SelectedIndex = 0
            lvEvenement.SelectedIndex = 0
            lvRDP.SelectedIndex = 0
            lviewUtilisateurs.SelectedIndex = 0
        End If

        'On affiche le nom de l'usager et l'icone du panneau de controle pour les usagers qui ne 
        'sont pas sentinelles
        If Not Session("Utilisateur") Is Nothing Then
            divLogin.Visible = True
            If CType(Session("Autorisation"), Integer) < 3 Then
                iconSetting.Visible = True
            End If

            lblInfoUtilisateur.InnerText = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).nomUtilisateur
        End If

        If Not Page.IsPostBack Then
            Dim di As New DirectoryInfo(Server.MapPath("../Upload/ImagesCarrousel/"))
            For Each fi As FileInfo In di.GetFiles()
                If (fi.Name.IndexOf("AvantCrop") > -1) Then
                    Try
                        File.Delete(fi.FullName)
                        'le lorsque le fichier est utilisé par un autre process nous ne pouvons le suprimier alors le catch le capt.
                    Catch
                    End Try
                End If
            Next

        End If

    End Sub

    Private Sub MultiView_ActiveViewChanged(sender As Object, e As EventArgs) Handles MultiView.ActiveViewChanged
        If MultiView.ActiveViewIndex <> -1 Then
            ViewState("vue") = MultiView.ActiveViewIndex

            'On réinitialise les styles avant de mettre le style à l'onglet actif
            lnkButton_nouvelle.CssClass = "lnkBtn_menuConfig lnkBtn_menuConfig:hover"
            lnkButton_evenement.CssClass = "lnkBtn_menuConfig lnkBtn_menuConfig:hover"
            lnkButton_revueDePresse.CssClass = "lnkBtn_menuConfig lnkBtn_menuConfig:hover"
            lnkButton_utilisateur.CssClass = "lnkBtn_menuConfig lnkBtn_menuConfig:hover"
            lnkButton_accueil.CssClass = "lnkBtn_menuConfig lnkBtn_menuConfig:hover"
            lnkBtn_EnvoiMessage.CssClass = "lnkBtn_EnvoiMessage lnkBtn_EnvoiMessage:hover"
        End If

        'Paquet de condition pour mettre un effet sur l'onglet actif
        If MultiView.ActiveViewIndex = 0 Then
            lnkButton_accueil.CssClass = "lnkBtn_menuConfig_active lnkBtn_menuConfig"
            lblMessageErreurOptions.Text = ""
            lviewOptions.DataBind()
        ElseIf MultiView.ActiveViewIndex = 1 Then
            lnkButton_nouvelle.CssClass = "lnkBtn_menuConfig_active lnkBtn_menuConfig"
            lblMessageErreurNouvelle.Text = ""
            ViewNouvelle.DataBind()
        ElseIf MultiView.ActiveViewIndex = 2 Then 'view évènement
            lnkButton_evenement.CssClass = "lnkBtn_menuConfig_active lnkBtn_menuConfig"
            lblMessageErreurEvenement.Text = ""
            ViewEvenement.DataBind()
        ElseIf MultiView.ActiveViewIndex = 3 Then
            lnkButton_revueDePresse.CssClass = "lnkBtn_menuConfig_active lnkBtn_menuConfig"
            lblMessageErreurRDP.Text = ""
            ViewRevueDePresse.DataBind()
        ElseIf MultiView.ActiveViewIndex = 4 Then
            lnkButton_utilisateur.CssClass = "lnkBtn_menuConfig_active lnkBtn_menuConfig"
            lblMessageErreurInfoUtilisateur.Text = ""
            ViewUtilisateur.DataBind()
        ElseIf MultiView.ActiveViewIndex = 5 Then
            lnkBtn_EnvoiMessage.CssClass = "lnkBtn_EnvoiMessage_active lnkBtn_EnvoiMessage"
            lblMessageErreurEnvoiMessage.Text = ""
        End If
    End Sub

#Region "Liens_Click"
    Protected Sub lnkAnglais_Click(sender As Object, e As EventArgs)
        Dim culture As String = ""

        culture = ModeleSentinellesHY.outils.obtenirLangue("EN|FR")

        'On ajoute un cookie contenant le choix de l'utilisateur pour la langue du site web
        Dim aCookie As New HttpCookie("SentinellesHY")
        aCookie.Values("langue") = culture
        aCookie.Expires = System.DateTime.Now.AddDays(3650)
        Response.Cookies.Add(aCookie)

        Response.Redirect(Request.Url.AbsoluteUri, True)
    End Sub

    Protected Sub lnkbtnLogout_Click(sender As Object, e As EventArgs)
        Session("Utilisateur") = Nothing
        Session("Autorisation") = Nothing
        Response.Redirect("index.aspx")
    End Sub

    Private Sub lnkButton_accueil_Click(sender As Object, e As EventArgs) Handles lnkButton_accueil.Click
        MultiView.ActiveViewIndex = 0
    End Sub

    Private Sub lnkButton_nouvelle_Click(sender As Object, e As EventArgs) Handles lnkButton_nouvelle.Click
        MultiView.ActiveViewIndex = 1
    End Sub

    Private Sub lnkButton_evenement_Click(sender As Object, e As EventArgs) Handles lnkButton_evenement.Click
        MultiView.ActiveViewIndex = 2
    End Sub

    Private Sub lnkButton_revueDePresse_Click(sender As Object, e As EventArgs) Handles lnkButton_revueDePresse.Click
        MultiView.ActiveViewIndex = 3
    End Sub

    Private Sub lnkButton_utilisateur_Click(sender As Object, e As EventArgs) Handles lnkButton_utilisateur.Click
        MultiView.ActiveViewIndex = 4
    End Sub

    Private Sub imgBtn_EnvoiMessage_Click(sender As Object, e As EventArgs) Handles lnkBtn_EnvoiMessage.Click
        MultiView.ActiveViewIndex = 5
    End Sub

    'Protected Sub lnkCreateBackup_Click(sender As Object, e As EventArgs)
    '    Dim controler As DBControler = New DBControler()
    '    controler.CreateBackup(Server.MapPath("../Upload/Backup/"), "sentinelle_" & Date.Now().ToString("dd/MMM/yyyy") & ".bak")
    'End Sub

#End Region

#Region "EnvoiMessage"
    Private Sub lnkbtnEnvoiMessage_Click(sender As Object, e As EventArgs) Handles lnkbtnEnvoiMessage.Click
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim isMailSending = False
        If Not File.Exists(Server.MapPath("/BackControl/properties.txt")) Then
            Using fs As FileStream = File.Create(Server.MapPath("/BackControl/properties.txt"))
                Dim info As [Byte]() = New UTF8Encoding(True).GetBytes("EmailSend=true")
                fs.Write(info, 0, info.Length)
                isMailSending = True
            End Using
        Else
            Try
                File.Delete(Server.MapPath("/BackControl/properties.txt"))
                Using fs As FileStream = File.Create(Server.MapPath("/BackControl/properties.txt"))
                    Dim info As [Byte]() = New UTF8Encoding(True).GetBytes("EmailSend=true")
                    fs.Write(info, 0, info.Length)
                    isMailSending = True
                End Using
            Catch ex As Exception
                Dim err = ex.Message
            End Try

        End If

        'Controle si le fichier d'envoie existe, sinon sa commence une nouvele routine
        CreateEmailFile("Sentinelles Haute-Yamaska - " & txtboxTitreMessage.Text, txtboxMessage.Text)

        Response.Redirect("FRMPanneauDeControle.aspx")

    End Sub

    'Cette methode inscrit les informations envoyées dans un fichier texte pour être repris par la routine de courriel.
    Public Sub CreateEmailFile(subject As String, msg As String)
        If Not File.Exists(Server.MapPath("/BackControl/mailmsg.txt")) Then

            Using fs As FileStream = File.Create(Server.MapPath("/BackControl/mailmsg.txt"))
                Dim sw As New StreamWriter(fs)
                sw.WriteLine("SUBJECT=" & subject)
                sw.WriteLine("MESSAGE=" & msg)
                sw.Close()
            End Using
        Else
            File.Delete(Server.MapPath("/BackControl/mailmsg.txt"))

            Using fs As FileStream = File.Create(Server.MapPath("/BackControl/mailmsg.txt"))
                Dim sw As New StreamWriter(fs)
                sw.WriteLine("SUBJECT=" & subject)
                sw.WriteLine("MESSAGE=" & msg)
                sw.Close()
            End Using
        End If
    End Sub
#End Region

#Region "Option"
    Public Shared Function GetInfoGenerale() As ModeleSentinellesHY.InfoGenerale
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim infoGenerale As ModeleSentinellesHY.InfoGenerale = Nothing

        infoGenerale = (From uti In leContexte.InfoGeneraleJeu).FirstOrDefault
        leContexte.Entry(infoGenerale).Reload()

        Return infoGenerale
    End Function

    Public Sub UpdateInfoGenerale(ByVal idInfo As Integer)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim infoAValider As ModeleSentinellesHY.InfoGenerale = Nothing
        lblMessageErreurOptions.Text = ""
        lblMessageErreurOptions.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewOptions.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next

        infoAValider = leContexte.InfoGeneraleJeu.Find(idInfo)

        'Prend les données qui sont dans le textbox
        TryUpdateModel(infoAValider)

        'On adapte le texte à cause de ce que le HtmlEditorExtender met comme balise
        If Not infoAValider.historiqueFR = Nothing Then
            infoAValider.historiqueFR = infoAValider.historiqueFR.Replace("<div", "<p")
            infoAValider.historiqueFR = infoAValider.historiqueFR.Replace("</div>", "</p>")
        End If
        If Not infoAValider.historiqueEN = Nothing Then
            infoAValider.historiqueEN = infoAValider.historiqueEN.Replace("<div", "<p")
            infoAValider.historiqueEN = infoAValider.historiqueEN.Replace("</div>", "</p>")
        End If
        If Not infoAValider.maltraitanceFR = Nothing Then
            infoAValider.maltraitanceFR = infoAValider.maltraitanceFR.Replace("<div", "<p")
            infoAValider.maltraitanceFR = infoAValider.maltraitanceFR.Replace("</div>", "</p>")
        End If
        If Not infoAValider.maltraitanceEN = Nothing Then
            infoAValider.maltraitanceEN = infoAValider.maltraitanceEN.Replace("<div", "<p")
            infoAValider.maltraitanceEN = infoAValider.maltraitanceEN.Replace("</div>", "</p>")
        End If


        ModeleSentinellesHY.outils.validationFormulaire(infoAValider, New ModeleSentinellesHY.InfoGeneraleValidation(), lviewOptions, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurOptions.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If

        If ModelState.IsValid Then
            leContexte.SaveChanges()
            lblMessageErreurOptions.Text = ModeleSentinellesHY.outils.obtenirLangue("Les changements ont été affectés avec succès!|The changes were affected successfully!")
            lblMessageErreurOptions.ForeColor = Color.Green
            lviewOptions.DataBind()
        End If

        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            CType(lviewOptions.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
        Next

    End Sub
#End Region

#Region "Carouselle"
    Protected Sub lnkUploadPhotoCarrousel_Click(sender As Object, e As EventArgs)

        Dim nomImage = CType(lviewOptions.Items(0).FindControl("nomImage"), System.Web.UI.WebControls.HiddenField)
        Dim nonFileUpdatege = CType(lviewOptions.Items(0).FindControl("nonFileUpdate"), System.Web.UI.WebControls.HiddenField)
        nomImage.Value = sender.text
        If nomImage.Value = "Carrousel1" Then
            nonFileUpdatege.Value = "fuplPhotoCarrousel1"
        ElseIf nomImage.Value = "Carrousel2" Then
            nonFileUpdatege.Value = "fuplPhotoCarrousel2"
        ElseIf nomImage.Value = "Carrousel3" Then
            nonFileUpdatege.Value = "fuplPhotoCarrousel3"
        End If
        CType(lviewOptions.Items(0).FindControl("mvPhotos"), MultiView).ActiveViewIndex = 1

    End Sub
    Protected Sub vCrop_Activate(sender As Object, e As EventArgs)
        Dim nonFileUpdatege = CType(lviewOptions.Items(0).FindControl("nonFileUpdate"), System.Web.UI.WebControls.HiddenField)
        Dim controlUpload = CType(lviewOptions.Items(0).FindControl(nonFileUpdatege.Value), FileUpload)


        If controlUpload.PostedFile.ContentType = "image/jpeg" Then
            Dim newFileName As String = ""
            Dim nomFichier As String = Path.GetFileName(controlUpload.FileName)
            'Save it in the server images folder
            Dim random As New Random()
            Dim rndnbr As Integer = 0
            rndnbr = random.[Next](0, 99999)
            newFileName = "AvantCrop-" + rndnbr.ToString + nomFichier

            controlUpload.SaveAs(Server.MapPath("../Upload/ImagesCarrousel/" & newFileName))

            Dim cropbox = CType(lviewOptions.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
            cropbox.ImageUrl = "~/Upload/ImagesCarrousel/" & newFileName

        End If

    End Sub

    Protected Sub imageRotateLeft_Click(sender As Object, e As EventArgs)
        Dim cropbox = CType(lviewOptions.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim path As [String] = Server.MapPath(cropbox.ImageUrl)
        Dim img As System.Drawing.Image = System.Drawing.Image.FromFile(path)
        img.RotateFlip(RotateFlipType.Rotate270FlipNone)
        img.Save(path)
    End Sub

    Protected Sub imageRotateRght_Click(sender As Object, e As EventArgs)
        Dim cropbox = CType(lviewOptions.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim path As [String] = Server.MapPath(cropbox.ImageUrl)
        Dim img As System.Drawing.Image = System.Drawing.Image.FromFile(path)
        img.RotateFlip(RotateFlipType.Rotate90FlipNone)
        img.Save(path)
    End Sub
    Protected Sub btCropGo_Click(sender As Object, e As EventArgs)
        'Load the Image from the location
        Dim cropbox = CType(lviewOptions.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
        Dim image As System.Drawing.Image = Bitmap.FromFile(Server.MapPath(cropbox.ImageUrl))
        Dim unFichier As String = Server.MapPath(cropbox.ImageUrl)
        Dim ratio As Double = image.Width / 800.0

        'Get the Cordinates
        Dim X = CType(lviewOptions.Items(0).FindControl("X"), System.Web.UI.WebControls.HiddenField)
        Dim Y = CType(lviewOptions.Items(0).FindControl("Y"), System.Web.UI.WebControls.HiddenField)
        Dim W = CType(lviewOptions.Items(0).FindControl("W"), System.Web.UI.WebControls.HiddenField)
        Dim H = CType(lviewOptions.Items(0).FindControl("H"), System.Web.UI.WebControls.HiddenField)

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
        Dim bmp As New Bitmap(960, 400, image.PixelFormat)
        Dim g As Graphics = Graphics.FromImage(bmp)
        g.DrawImage(image, New Rectangle(0, 0, 960, 400), New Rectangle(x__1, y__2, w__3, h__4), GraphicsUnit.Pixel)
        'Save the file and reload to the control
        Dim nomImage = CType(lviewOptions.Items(0).FindControl("nomImage"), System.Web.UI.WebControls.HiddenField)
        bmp.Save(Server.MapPath("../Upload/ImagesCarrousel/") + nomImage.Value + ".jpg", image.RawFormat)
        lviewOptions.DataBind()
        CType(lviewOptions.Items(0).FindControl("mvPhotos"), MultiView).ActiveViewIndex = 0

    End Sub

#End Region

#Region "Nouvelle"

    Public Shared Function GetNouvelle() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeNouvelles As List(Of ModeleSentinellesHY.Nouvelle) = Nothing

        listeNouvelles = (From uti In leContexte.NouvelleJeu Order By uti.dateRedaction Descending).ToList

        Return listeNouvelles.AsQueryable()
    End Function
    Public Function getInfoNouvelle() As ModeleSentinellesHY.Nouvelle
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim uneNouvelle As New ModeleSentinellesHY.Nouvelle

        If Not (leContexte.NouvelleJeu).Count = 0 AndAlso Not ViewState("modeNouvelle") = "AjoutNouvelle" Then
            Dim idNouvelle As Integer = lviewNouvelle.SelectedDataKey(0)
            uneNouvelle = (From nouv In leContexte.NouvelleJeu Where nouv.idNouvelle = idNouvelle).FirstOrDefault
            leContexte.Entry(uneNouvelle).Reload()
        End If

        Return uneNouvelle
    End Function
    Public Sub UpdateNouvelle(ByVal nouvelleAUpdater As ModeleSentinellesHY.Nouvelle)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        If (leContexte.NouvelleJeu).Count = 0 Then
            ViewState("modeNouvelle") = "AjoutNouvelle"
        End If
        Dim nouvelleAValider As ModeleSentinellesHY.Nouvelle = Nothing
        lblMessageErreurNouvelle.Text = ""
        lblMessageErreurNouvelle.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewInfoNouvelles.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        If ViewState("modeNouvelle") = "AjoutNouvelle" Then
            nouvelleAValider = New ModeleSentinellesHY.Nouvelle()
        Else
            nouvelleAValider = leContexte.NouvelleJeu.Find(nouvelleAUpdater.idNouvelle)
        End If
        'Prend les données qui sont dans le textbox
        TryUpdateModel(nouvelleAValider)
        'Ajoute une nouvelle avec le texte saisi dans le textbox

        'Remplace les div par des p pour un retour à la ligne
        If Not nouvelleAValider.contenuFR = Nothing Then
            nouvelleAValider.contenuFR = nouvelleAValider.contenuFR.Replace("<div", "<p")
            nouvelleAValider.contenuFR = nouvelleAValider.contenuFR.Replace("</div>", "</p>")
        End If
        If Not nouvelleAValider.contenuEN = Nothing Then
            nouvelleAValider.contenuEN = nouvelleAValider.contenuEN.Replace("<div", "<p")
            nouvelleAValider.contenuEN = nouvelleAValider.contenuEN.Replace("</div>", "</p>")
        End If

        If ViewState("modeNouvelle") = "AjoutNouvelle" Then
            nouvelleAValider.dateRedaction = Date.Now()
        End If
        ModeleSentinellesHY.outils.validationFormulaire(nouvelleAValider, New ModeleSentinellesHY.NouvelleValidation(), lviewInfoNouvelles, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurNouvelle.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If
        If ModelState.IsValid Then
            If ViewState("modeNouvelle") = "AjoutNouvelle" Then
                leContexte.NouvelleJeu.Add(nouvelleAValider)
            End If
            leContexte.SaveChanges()
            ViewState("modeNouvelle") = ""
            lblMessageErreurNouvelle.Text = ModeleSentinellesHY.outils.obtenirLangue("La nouvelle a été modifié avec succès!|The news has been succesfully updated!")
            lblMessageErreurNouvelle.ForeColor = Color.Green
            lviewNouvelle.DataBind()
            lviewInfoNouvelles.DataBind()
        End If
        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            CType(lviewInfoNouvelles.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
        Next

    End Sub
    Public Sub DeleteNouvelle(ByVal nouvelleASupprimer As ModeleSentinellesHY.Nouvelle)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim nouvelleAValider As ModeleSentinellesHY.Nouvelle = Nothing
        nouvelleAValider = leContexte.NouvelleJeu.Find(nouvelleASupprimer.idNouvelle)

        If (Not nouvelleAValider Is Nothing) Then
            leContexte.NouvelleJeu.Remove(nouvelleAValider)
            leContexte.SaveChanges()
        End If

        lviewNouvelle.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle nouvelle on supprime
        If lviewNouvelle.SelectedIndex = -1 Then
            lviewNouvelle.SelectedIndex = 0
        ElseIf lviewNouvelle.SelectedIndex = 0 Then
            lviewNouvelle.SelectedIndex = 1
        ElseIf lviewNouvelle.SelectedIndex = 1 Then
            lviewNouvelle.SelectedIndex = 0
        End If

        lviewInfoNouvelles.DataBind()
    End Sub

    Private Sub lviewNouvelle_PreRender(sender As Object, e As EventArgs) Handles lviewNouvelle.PreRender
        If lviewNouvelle.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lviewNouvelle.FindControl("lbNouvelleTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
    End Sub
    Private Sub lviewNouvelle_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lviewNouvelle.SelectedIndexChanged
        ViewState("modeNouvelle") = ""
        lblMessageErreurNouvelle.Text = ""
        lviewInfoNouvelles.DataBind()
    End Sub
    Protected Sub lnkBtnAjoutNouvelle_Click(sender As Object, e As EventArgs)
        ViewState("modeNouvelle") = "AjoutNouvelle"
        lblMessageErreurNouvelle.Text = ""
        lviewInfoNouvelles.DataBind()
    End Sub
    Private Sub lviewInfoNouvelles_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewInfoNouvelles.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeNouvelle As List(Of ModeleSentinellesHY.Nouvelle) = Nothing
        listeNouvelle = (From nou In leContexte.NouvelleJeu Order By nou.dateRedaction Descending).ToList

        If ViewState("modeNouvelle") = "AjoutNouvelle" Or listeNouvelle.Count = 0 Then
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = False
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = False
            CType(lviewInfoNouvelles.FindControl("lnkBtnAjoutNouvelle"), LinkButton).Visible = False
        Else
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = True
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = True
            CType(lviewInfoNouvelles.FindControl("lnkBtnAjoutNouvelle"), LinkButton).Visible = True
        End If
    End Sub
    Protected Sub lnkbtnAnnulerNouvelle_Click(sender As Object, e As EventArgs)
        If ViewState("modeNouvelle") = "AjoutNouvelle" Then
            ViewState("modeNouvelle") = Nothing
        End If
        lviewInfoNouvelles.DataBind()
    End Sub
#End Region

#Region "Événement"
    Private Sub lvEvenement_PreRender(sender As Object, e As EventArgs) Handles lvEvenement.PreRender
        If lvEvenement.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lvEvenement.FindControl("lbEvenementTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
    End Sub

    Private Sub lvEvenement_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lvEvenement.SelectedIndexChanged
        ViewState("modeEvenement") = ""
        lblMessageErreurEvenement.Text = ""
        lvInfoEvenement.DataBind()
    End Sub

    Protected Sub lnkBtnAjoutEvenement_Click(sender As Object, e As EventArgs)
        ViewState("modeEvenement") = "AjoutEvenement"
        lblMessageErreurEvenement.Text = ""
        lvInfoEvenement.DataBind()
        CType(lvInfoEvenement.Items(0).FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = False
    End Sub

    Public Shared Function GetEvenement() As IQueryable(Of ModeleSentinellesHY.Événement)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeEvenements As List(Of ModeleSentinellesHY.Événement) = Nothing
        listeEvenements = (From eve In leContexte.ÉvénementJeu Order By eve.dateEvenement Descending).ToList


        Return listeEvenements.AsQueryable()
    End Function

    Public Function getInfoEvenement() As ModeleSentinellesHY.Événement
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unEvenement As New ModeleSentinellesHY.Événement
        If Not (leContexte.ÉvénementJeu.Count = 0 Or ViewState("modeEvenement") = "AjoutEvenement") Then
            Dim idEvenement As Integer = lvEvenement.SelectedDataKey(0)

            unEvenement = (From eve In leContexte.ÉvénementJeu Where eve.idEvenement = idEvenement).FirstOrDefault
            leContexte.Entry(unEvenement).Reload()
        End If

        Return unEvenement
    End Function

    Public Sub UpdateEvenement(ByVal evenementAUpdater As ModeleSentinellesHY.Événement)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer

        If leContexte.ÉvénementJeu.Count = 0 Then
            ViewState("modeEvenement") = "AjoutEvenement"
        End If
        Dim evenementAValider As ModeleSentinellesHY.Événement = Nothing
        lblMessageErreurEvenement.Text = ""
        lblMessageErreurEvenement.ForeColor = Drawing.Color.Red
        For Each tb As Object In lvInfoEvenement.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        If ViewState("modeEvenement") = "AjoutEvenement" Then
            evenementAValider = New ModeleSentinellesHY.Événement()
        Else
            evenementAValider = leContexte.ÉvénementJeu.Find(evenementAUpdater.idEvenement)
        End If
        'Prend les données qui sont dans le textbox
        TryUpdateModel(evenementAValider)
        'Ajoute une nouvelle avec le texte saisi dans le textbox

        'Remplace les div par des p pour un retour à la ligne
        If Not evenementAValider.contenuFR = Nothing Then
            evenementAValider.contenuFR = evenementAValider.contenuFR.Replace("<div", "<p")
            evenementAValider.contenuFR = evenementAValider.contenuFR.Replace("</div>", "</p>")
        End If
        If Not evenementAValider.contenuEN = Nothing Then
            evenementAValider.contenuEN = evenementAValider.contenuEN.Replace("<div", "<p")
            evenementAValider.contenuEN = evenementAValider.contenuEN.Replace("</div>", "</p>")
        End If

        If ViewState("modeEvenement") = "AjoutEvenement" Then
            evenementAValider.dateRedaction = Date.Now()
        End If
        ModeleSentinellesHY.outils.validationFormulaire(evenementAValider, New ModeleSentinellesHY.ÉvénementValidation(), lvInfoEvenement, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurEvenement.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If
        If ModelState.IsValid Then
            If ViewState("modeEvenement") = "AjoutEvenement" Then
                leContexte.ÉvénementJeu.Add(evenementAValider)
            End If
            leContexte.SaveChanges()
            lblMessageErreurEvenement.Text = ModeleSentinellesHY.outils.obtenirLangue("L'événement a été modifié avec succès!|The event has been succesfully updated!")
            lblMessageErreurEvenement.ForeColor = Color.Green
            ViewState("modeEvenement") = ""
            lvEvenement.DataBind()
            lvInfoEvenement.DataBind()
        End If
        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            CType(lvInfoEvenement.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
        Next

    End Sub

    Public Sub DeleteEvenement(ByVal evenementASupprimer As ModeleSentinellesHY.Événement)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unEvenement As ModeleSentinellesHY.Événement = Nothing
        unEvenement = leContexte.ÉvénementJeu.Find(evenementASupprimer.idEvenement)

        If (Not unEvenement Is Nothing) Then
            leContexte.ÉvénementJeu.Remove(unEvenement)
            leContexte.SaveChanges()
        End If

        lvEvenement.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle événement on supprime
        If lvEvenement.SelectedIndex = -1 Then
            lvEvenement.SelectedIndex = 0
        ElseIf lvEvenement.SelectedIndex = 0 Then
            lvEvenement.SelectedIndex = 1
        ElseIf lvEvenement.SelectedIndex = 1 Then
            lvEvenement.SelectedIndex = 0
        End If

        lvInfoEvenement.DataBind()
    End Sub

    Private Sub lvInfoEvenement_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvInfoEvenement.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeEvenements As List(Of ModeleSentinellesHY.Événement) = Nothing
        listeEvenements = (From eve In leContexte.ÉvénementJeu Order By eve.dateEvenement Descending).ToList

        If ViewState("modeEvenement") = "AjoutEvenement" Or listeEvenements.Count = 0 Then
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = False
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = False
            CType(lvInfoEvenement.FindControl("lnkBtnAjoutEvenement"), LinkButton).Visible = False
        Else
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = True
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = True
            CType(lvInfoEvenement.FindControl("lnkBtnAjoutEvenement"), LinkButton).Visible = True
        End If
    End Sub
    Protected Sub lnkbtnAnnulerEvenement_Click(sender As Object, e As EventArgs)
        If ViewState("modeEvenement") = "AjoutEvenement" Then
            ViewState("modeEvenement") = Nothing
        End If
        lvInfoEvenement.DataBind()
    End Sub
#End Region

#Region "Revue de Presse"
    Private Sub lvRDP_PreRender(sender As Object, e As EventArgs) Handles lvRDP.PreRender
        If lvRDP.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lvRDP.FindControl("lbRDPTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
    End Sub

    Private Sub lvRDP_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lvRDP.SelectedIndexChanged
        ViewState("modeRDP") = ""
        lblMessageErreurRDP.Text = ""
        lvInfoRDP.DataBind()
    End Sub

    Protected Sub lnkBtnAjoutRDP_Click(sender As Object, e As EventArgs)
        ViewState("modeRDP") = "AjoutRDP"
        lblMessageErreurRDP.Text = ""
        lvInfoRDP.DataBind()
        CType(lvInfoRDP.Items(0).FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = False
    End Sub

    Public Shared Function GetRDP() As IQueryable(Of ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRDP As List(Of ModeleSentinellesHY.RevueDePresse) = Nothing

        listeRDP = (From rdp In leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

        Return listeRDP.AsQueryable()
    End Function

    Public Function getInfoRDP() As ModeleSentinellesHY.RevueDePresse
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim uneRDP As New ModeleSentinellesHY.RevueDePresse

        If Not ((leContexte.RevueDePresseJeu).Count = 0 Or ViewState("modeRDP") = "AjoutRDP") Then
            Dim idRDP As Integer = lvRDP.SelectedDataKey(0)
            uneRDP = (From rdp In leContexte.RevueDePresseJeu Where rdp.idRDP = idRDP).FirstOrDefault
            leContexte.Entry(uneRDP).Reload()
        End If

        Return uneRDP
    End Function

    Public Sub UpdateRDP(ByVal RDPAUpdater As ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        If ((leContexte.RevueDePresseJeu).Count = 0) Then
            ViewState("modeRDP") = "AjoutRDP"
        End If
        Dim RDPAValider As ModeleSentinellesHY.RevueDePresse = Nothing
        lblMessageErreurRDP.Text = ""
        lblMessageErreurRDP.ForeColor = Drawing.Color.Red
        For Each tb As Object In lvInfoRDP.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next
        If ViewState("modeRDP") = "AjoutRDP" Then
            RDPAValider = New ModeleSentinellesHY.RevueDePresse()
        Else
            RDPAValider = leContexte.RevueDePresseJeu.Find(RDPAUpdater.idRDP)
        End If
        'Prend les données qui sont dans le textbox
        TryUpdateModel(RDPAValider)
        'Ajoute une nouvelle avec le texte saisi dans le textbox
        RDPAValider.urlDocumentTemp = RDPAValider.urlDocument
        'Remplace les div par des p pour un retour à la ligne
        If Not RDPAValider.contenuFR = Nothing Then
            RDPAValider.contenuFR = RDPAValider.contenuFR.Replace("<div", "<p")
            RDPAValider.contenuFR = RDPAValider.contenuFR.Replace("</div>", "</p>")
        End If
        If Not RDPAValider.contenuEN = Nothing Then
            RDPAValider.contenuEN = RDPAValider.contenuEN.Replace("<div", "<p")
            RDPAValider.contenuEN = RDPAValider.contenuEN.Replace("</div>", "</p>")
        End If

        If ViewState("modeRDP") = "AjoutRDP" Then
            RDPAValider.dateRedaction = Date.Now()
        End If
        ModeleSentinellesHY.outils.validationFormulaire(RDPAValider, New ModeleSentinellesHY.RevueDePresseValidation(), lvInfoRDP, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurRDP.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If
        If ModelState.IsValid Then
            If ViewState("modeRDP") = "AjoutRDP" Then
                leContexte.RevueDePresseJeu.Add(RDPAValider)
            End If
            leContexte.SaveChanges()
            lblMessageErreurRDP.Text = ModeleSentinellesHY.outils.obtenirLangue("La revue de presse a été modifié avec succès!|The press review has been succesfully updated!")
            lblMessageErreurRDP.ForeColor = Color.Green
            ViewState("modeRDP") = ""
            'Conditions pour Supprimer Avatar du fichier Upload
            If RDPAValider.urlDocument <> RDPAValider.urlDocument AndAlso RDPAValider.urlDocument <> "" _
                AndAlso Not RDPAValider.urlDocument.Contains("http://") Then
                ModeleSentinellesHY.outils.SupprimerFichierUpload(RDPAValider.urlDocumentTemp)
            End If
            lvRDP.DataBind()
            lvInfoRDP.DataBind()
        End If
        For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
            CType(lvInfoRDP.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
        Next

    End Sub

    Public Sub DeleteRDP(ByVal RDPASupprimer As ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim uneRDP As ModeleSentinellesHY.RevueDePresse = Nothing
        uneRDP = leContexte.RevueDePresseJeu.Find(RDPASupprimer.idRDP)

        If (Not uneRDP Is Nothing) Then
            leContexte.RevueDePresseJeu.Remove(uneRDP)
            leContexte.SaveChanges()
        End If

        lvRDP.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle revue de presse on supprime
        If lvRDP.SelectedIndex = -1 Then
            lvRDP.SelectedIndex = 0
        ElseIf lvRDP.SelectedIndex = 0 Then
            lvRDP.SelectedIndex = 1
        ElseIf lvRDP.SelectedIndex = 1 Then
            lvRDP.SelectedIndex = 0
        End If

        lvInfoRDP.DataBind()
    End Sub

    Protected Sub lnkUploadPDF_Click(sender As Object, e As EventArgs)
        'Upload pour les fichiers pdf pour les revues de presse
        Dim controlUploadRDP = CType(lvInfoRDP.Items(0).FindControl("fuplRDP"), FileUpload)
        Dim extension As String = ""
        Dim nomFichier As String = ""
        If controlUploadRDP.HasFile Then
            If controlUploadRDP.PostedFile.ContentType = "application/pdf" Then
                nomFichier = Left(controlUploadRDP.FileName, Len(controlUploadRDP.FileName) - 4)
                'On trim la longueur du nom
                If nomFichier.Length > 30 Then
                    nomFichier = Left(nomFichier, 30)
                End If
                nomFichier &= ".pdf"
                controlUploadRDP.SaveAs(Server.MapPath("../Upload/PDF/") & nomFichier)
                CType(lvInfoRDP.Items(0).FindControl("txtboxUrlDocument"), TextBox).Text = nomFichier
            End If
        End If
    End Sub

    Private Sub lvInfoRDP_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvInfoRDP.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRDP As List(Of ModeleSentinellesHY.RevueDePresse) = Nothing
        listeRDP = (From rdp In leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

        If ViewState("modeRDP") = "AjoutRDP" Or listeRDP.Count = 0 Then
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = False
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = False
            CType(lvInfoRDP.FindControl("lnkBtnAjoutRDP"), LinkButton).Visible = False
        Else
            CType(e.Item.FindControl("divDateRedaction"), HtmlControl).Visible = True
            CType(e.Item.FindControl("lnkbtnSupprimerNouvelle"), LinkButton).Visible = True
            CType(lvInfoRDP.FindControl("lnkBtnAjoutRDP"), LinkButton).Visible = True
        End If
    End Sub
    Protected Sub lnkbtnAnnulerRDP_Click(sender As Object, e As EventArgs)
        If ViewState("modeRDP") = "AjoutRDP" Then
            ViewState("modeRDP") = Nothing
        End If
        lvInfoRDP.DataBind()
    End Sub
#End Region

#Region "Utilisateur"
#Region "Statut"
    Public Function getStatutUtilisateur() As IQueryable(Of ModeleSentinellesHY.Statut)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeStatutUtilisateur As New List(Of ModeleSentinellesHY.Statut)

        listeStatutUtilisateur = (From ca In leContexte.StatutJeu).ToList


        For Each statut As ModeleSentinellesHY.Statut In listeStatutUtilisateur
            If Thread.CurrentThread.CurrentCulture.EnglishName.ToString.Contains("English") Then
                statut.nomStatut = statut.nomStatutEN
            Else
                statut.nomStatut = statut.nomStatutFR
            End If
        Next

        Return listeStatutUtilisateur.AsQueryable
    End Function
#End Region

    Private Sub lviewUtilisateurs_PreRender(sender As Object, e As EventArgs) Handles lviewUtilisateurs.PreRender
        If lviewUtilisateurs.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lviewUtilisateurs.FindControl("lblUtilisateurUsername"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
    End Sub

    'PreRender des astérisques dans le listview pour ne les afficher que lorsqu'on est en mode Ajout... Idéalement,
    'il faudrait mettre un EditTemplate dans le listview, ce serait plus propre
    Protected Sub asterisque_PreRender(sender As Object, e As EventArgs)
        If Not ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
            Dim asterisque As System.Web.UI.WebControls.Label = CType(sender, System.Web.UI.WebControls.Label)
            asterisque.Visible = False
        End If
    End Sub
    Private Sub lviewUtilisateurs_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lviewUtilisateurs.SelectedIndexChanged
        ViewState("modeUtilisateur") = ""
        lblMessageErreurInfoUtilisateur.Text = ""
        lviewInfoUtilisateur.DataBind()
    End Sub

    Private Sub btnRechercheUtilisateur_Click(sender As Object, e As EventArgs) Handles btnRechercheUtilisateur.Click
        lviewUtilisateurs.DataBind()
    End Sub

    Public Function GetUtilisateurs() As IQueryable(Of ModeleSentinellesHY.Utilisateur)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeUtilisateurs As New List(Of ModeleSentinellesHY.Utilisateur)

        If txtboxRechercheUtilisateur.Text <> "" Then
            Dim txtRecherche As String = txtboxRechercheUtilisateur.Text
            listeUtilisateurs = (From uti In leContexte.UtilisateurJeu
                                 Where uti.nom.Contains(txtRecherche) Or uti.prenom.Contains(txtRecherche) Or
                                 uti.courriel.Contains(txtRecherche) Or uti.milieu.Contains(txtRecherche) Or
                                 uti.nomUtilisateur.Contains(txtRecherche)
                                 Order By uti.prenom).ToList
        Else
            listeUtilisateurs = (From uti In leContexte.UtilisateurJeu Order By uti.prenom).ToList
        End If
        Return listeUtilisateurs.AsQueryable()
    End Function

    Public Function getInfoUtilisateur() As ModeleSentinellesHY.Utilisateur
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unUtilisateur As New ModeleSentinellesHY.Utilisateur

        If Not ((From uti In leContexte.UtilisateurJeu).Count = 0 Or _
            ViewState("modeUtilisateur") = "AjoutUtilisateur") Then
            Dim idUtilisateur As Integer = lviewUtilisateurs.SelectedDataKey(0)
            unUtilisateur = (From uti In leContexte.UtilisateurJeu Where uti.idUtilisateur = idUtilisateur).FirstOrDefault
            leContexte.Entry(unUtilisateur).Reload()
        End If

        Return unUtilisateur
    End Function

    Private Sub lviewInfoUtilisateur_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewInfoUtilisateur.ItemDataBound
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeUtilisateurs As New List(Of ModeleSentinellesHY.Utilisateur)

        listeUtilisateurs = (From uti In leContexte.UtilisateurJeu Order By uti.prenom).ToList

        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Or listeUtilisateurs.Count = 0 Then
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = False
            CType(lviewInfoUtilisateur.FindControl("lnkbtnAjouter"), LinkButton).Visible = False
            CType(e.Item.FindControl("btnImgDefaut"), Button).Visible = False
        Else
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = True
            CType(lviewInfoUtilisateur.FindControl("lnkbtnAjouter"), LinkButton).Visible = True
            CType(e.Item.FindControl("btnImgDefaut"), Button).Visible = True
        End If

        If CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).idUtilisateur = CType(e.Item.DataItem, ModeleSentinellesHY.Utilisateur).idUtilisateur Then
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = False
        End If
    End Sub

    Public Sub DeleteUtilisateur(ByVal utilisateurASupprimer As ModeleSentinellesHY.Utilisateur)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim utilisateurAValider As ModeleSentinellesHY.Utilisateur = Nothing

        utilisateurAValider = leContexte.UtilisateurJeu.Find(utilisateurASupprimer.idUtilisateur)

        If (Not utilisateurAValider Is Nothing) Then
            leContexte.UtilisateurJeu.Remove(utilisateurAValider)
            leContexte.SaveChanges()
        End If

        lviewUtilisateurs.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle nouvelle on supprime
        If lviewUtilisateurs.SelectedIndex = -1 Then
            lviewUtilisateurs.SelectedIndex = 0
        ElseIf lviewUtilisateurs.SelectedIndex = 0 Then
            lviewUtilisateurs.SelectedIndex = 1
        ElseIf lviewUtilisateurs.SelectedIndex = 1 Then
            lviewUtilisateurs.SelectedIndex = 0
        End If

        lviewInfoUtilisateur.DataBind()
    End Sub

    Public Sub UpdateUtilisateur(ByVal idUtilisateur As Integer)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim utilisateurAValider As ModeleSentinellesHY.Utilisateur = Nothing
        Dim tbMotDePasse As String = CType(lviewInfoUtilisateur.Items(0).FindControl("txtboxmotDePasse"), TextBox).Text
        Dim tbConfirmation As String = CType(lviewInfoUtilisateur.Items(0).FindControl("txtboxConfirmer"), TextBox).Text

        lblMessageErreurInfoUtilisateur.Text = ""
        lblMessageErreurInfoUtilisateur.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewInfoUtilisateur.Items(0).Controls 'Reset l'encadrer autour de tout txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next

        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
            utilisateurAValider = New ModeleSentinellesHY.Utilisateur()
            utilisateurAValider.UrlAvatar = "default.png"
        Else
            utilisateurAValider = leContexte.UtilisateurJeu.Find(idUtilisateur)
        End If

        'Prend les données qui sont dans le formulaire
        TryUpdateModel(utilisateurAValider)

        'On vérifie que l'utilisateur à ajouter ne possède pas un username identique à un autre usager
        'de la BD
        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
            Dim doublon = (From uti As ModeleSentinellesHY.Utilisateur In leContexte.UtilisateurJeu Where uti.nomUtilisateur.Equals(utilisateurAValider.nomUtilisateur)).FirstOrDefault
            If Not doublon Is Nothing Then
                listeErreur.Add(New ModeleSentinellesHY.clsErreur With {.contenant = lviewInfoUtilisateur, .nomPropriete = "nomUtilisateur", .errorMessage = ModeleSentinellesHY.outils.obtenirLangue("Le nom d'utilisateur existe déjà.|This username already exists.")})
                ModelState.AddModelError("nomUtilisateur", ModeleSentinellesHY.outils.obtenirLangue("Le nom d'utilisateur existe déjà.|This username already exists."))
            End If
        End If
        'Url Avatar
        utilisateurAValider.urlAvatarTemp = utilisateurAValider.UrlAvatar

        ModeleSentinellesHY.outils.validationUtilisateur(utilisateurAValider, New ModeleSentinellesHY.UtilisateurValidation(), lviewInfoUtilisateur, listeErreur)
        If listeErreur.Count > 0 Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblMessageErreurInfoUtilisateur.Text += "*" & erreur.errorMessage & "<br/>"
            Next
        End If

        If ModelState.IsValid Then
            ViewState("idUtilisateur") = utilisateurAValider.idUtilisateur
            If ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
                leContexte.UtilisateurJeu.Add(utilisateurAValider)
            End If
            leContexte.SaveChanges()
            ViewState("modeUtilisateur") = ""
            lblMessageErreurInfoUtilisateur.Text = "L'utilisateur a été modifié avec succès!"
            lblMessageErreurInfoUtilisateur.ForeColor = Color.Green

            'Conditions pour Supprimer Avatar du fichier Upload
            If utilisateurAValider.UrlAvatar <> utilisateurAValider.urlAvatarTemp AndAlso utilisateurAValider.UrlAvatar <> "" _
                AndAlso utilisateurAValider.UrlAvatar = "default.png" Then
                ModeleSentinellesHY.outils.SupprimerFichierUpload(utilisateurAValider.urlAvatarTemp)
            End If
            lviewUtilisateurs.DataBind()
            lviewInfoUtilisateur.DataBind()
        Else
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                If Not erreur.nomPropriete Is Nothing Then
                    CType(lviewInfoUtilisateur.Items(0).FindControl("txtbox" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
                ElseIf erreur.errorMessage.ToString.Contains("pass") Then
                    CType(lviewInfoUtilisateur.Items(0).FindControl("txtboxmotDePasse"), TextBox).BorderColor = Drawing.Color.Red
                    CType(lviewInfoUtilisateur.Items(0).FindControl("txtboxConfirmer"), TextBox).BorderColor = Drawing.Color.Red
                End If
            Next
        End If
        utilisateurAValider.motDePasseTemp = ""
        utilisateurAValider.confirmationMotDePasse = ""

    End Sub

    Protected Sub lnkbtnAjouter_Click(sender As Object, e As EventArgs)
        ViewState("modeUtilisateur") = "AjoutUtilisateur"
        lblMessageErreurInfoUtilisateur.Text = ""
        lviewInfoUtilisateur.DataBind()
    End Sub

    Protected Sub btnImgDefaut_Click(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        CType(lviewInfoUtilisateur.Items(0).FindControl("lblNomPhoto"), Label).Text = "default.png"
        CType(lviewInfoUtilisateur.Items(0).FindControl("imgUpload"), HtmlImage).Src = "../Upload/ImagesProfil/default.png"

        Dim newUtilisateurTemp As Utilisateur = leContexte.UtilisateurJeu.Find(lviewUtilisateurs.SelectedDataKey(0))
        newUtilisateurTemp.UrlAvatar = "default.png"
        leContexte.SaveChanges()
    End Sub

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
    Protected Sub lnkbtnAnnulerUtilisateur_Click(sender As Object, e As EventArgs)
        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
            ViewState("modeUtilisateur") = Nothing
        End If
        lviewInfoUtilisateur.DataBind()
    End Sub
#End Region

End Class