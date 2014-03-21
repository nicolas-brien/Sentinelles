'Rechercher #Region "Utilisateur" afin d'accéder directement au bon endroit dans le document

Imports System.IO
Imports System.Threading
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports System.Data.Entity.Validation
Imports System.ComponentModel.DataAnnotations
Imports ModeleSentinellesHY

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

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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
            imgBtn_EnvoiMessage.ImageUrl = "~/Images/enveloppe.png"
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
        ElseIf MultiView.ActiveViewIndex = 2 Then
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
            imgBtn_EnvoiMessage.ImageUrl = "~/Images/enveloppeSelected.png"
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

    Private Sub imgBtn_EnvoiMessage_Click(sender As Object, e As ImageClickEventArgs) Handles imgBtn_EnvoiMessage.Click
        MultiView.ActiveViewIndex = 5
    End Sub

    'Protected Sub lnkCreateBackup_Click(sender As Object, e As EventArgs)
    '    Dim controler As DBControler = New DBControler()
    '    controler.CreateBackup(Server.MapPath("../Upload/Backup/"), "sentinelle_" & Date.Now().ToString("dd/MMM/yyyy") & ".bak")
    'End Sub

#End Region

#Region "EnvoiMessage"
    Private Sub lnkbtnEnvoiMessage_Click(sender As Object, e As EventArgs) Handles lnkbtnEnvoiMessage.Click
        'Méthode servant à envoyer à tous les usagers du site web un courriel pour tous ceux qui possèdent une
        'adresse courriel
        Dim unUtilisateur As New ModeleSentinellesHY.Utilisateur
        Dim listeErreur As Integer = 0
        Dim listeDestinataire As New List(Of ModeleSentinellesHY.Utilisateur)
        Dim destinataires As String = ""
        
        listeDestinataire = (From info In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu _
                                      Where info.courriel <> Nothing).ToList
        For Each uti As ModeleSentinellesHY.Utilisateur In listeDestinataire
            destinataires &= uti.courriel & ","
        Next

        'Sert à enlever la dernière virgule
        destinataires.Remove(destinataires.Length - 1)
        destinataires = "sansarrets@hotmail.com,jeansebastien.ares@gmail.com"


        ' For Each uti As ModeleSentinellesHY.Utilisateur In listeDestinataire
        If txtboxTitreMessage.Text = Nothing Then
            lblMessageErreurEnvoiMessage.Text &= ModeleSentinellesHY.outils.obtenirLangue("*Vous devez entrer un titre|*You must enter a title") & "<br/>"
            listeErreur += 1
        End If
        If txtboxMessage.Text = Nothing Then
            lblMessageErreurEnvoiMessage.Text &= ModeleSentinellesHY.outils.obtenirLangue("*Vous devez entrer un message|*You must enter a message")
            listeErreur += 1
        End If
        If listeErreur = 0 Then
            Dim expediteur As String = "info@sentinelleshy.ca"
            Dim mail As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
            mail.To.Add(expediteur)
            mail.Bcc.Add(destinataires)
            mail.From = New System.Net.Mail.MailAddress(expediteur)
            mail.Subject = "Sentinelles Haute-Yamaska - " & txtboxTitreMessage.Text
            mail.SubjectEncoding = System.Text.Encoding.UTF8
            mail.Body = txtboxMessage.Text
            If Not txtboxMessage.Text = Nothing Then
                txtboxMessage.Text = txtboxMessage.Text.Replace("<div></div>", "<br/><br/>")
            End If
            mail.BodyEncoding = System.Text.Encoding.UTF8
            mail.IsBodyHtml = True
            Dim client As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()
            client.Credentials = New System.Net.NetworkCredential("info@sentinelleshy.ca", "Vs2H7!Etu")

            client.Port = 25
            client.Host = "mail.sentinelleshy.ca"
            'client.Port = 587 ' Gmail port
            'client.Host = "smtp.gmail.com"
            'client.EnableSsl = True 'Gmail Secured Layer

            client.Send(mail)
            lblMessageErreurEnvoiMessage.Text = ModeleSentinellesHY.outils.obtenirLangue("Le message a bel et bien été envoyé|The message has been sent")
            lblMessageErreurEnvoiMessage.CssClass = "AvecSucces"
        End If
        'Next
    End Sub
#End Region

#Region "Option"
    Public Shared Function GetInfoGenerale() As ModeleSentinellesHY.InfoGenerale
        Dim infoGenerale As ModeleSentinellesHY.InfoGenerale = Nothing

        infoGenerale = (From uti In ModeleSentinellesHY.outils.leContexte.InfoGeneraleJeu).FirstOrDefault
        ModeleSentinellesHY.outils.leContexte.Entry(infoGenerale).Reload()

        Return infoGenerale
    End Function

    Public Sub UpdateInfoGenerale(ByVal idInfo As Integer)

        Dim infoAValider As ModeleSentinellesHY.InfoGenerale = Nothing
        lblMessageErreurOptions.Text = ""
        lblMessageErreurOptions.ForeColor = Drawing.Color.Red
        For Each tb As Object In lviewOptions.Items(0).Controls 'Reset l'encadrer autour de tous les txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next

        infoAValider = ModeleSentinellesHY.outils.leContexte.InfoGeneraleJeu.Find(idInfo)

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
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
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

            controlUpload.SaveAs(Server.MapPath("../Upload/" & newFileName))

            Dim cropbox = CType(lviewOptions.Items(0).FindControl("cropbox"), System.Web.UI.WebControls.Image)
            cropbox.ImageUrl = "~/Upload/" & newFileName
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
        'Create a new image from the specified location to
        'specified height and width
        Dim bmp As New Bitmap(960, 400, image.PixelFormat)
        Dim g As Graphics = Graphics.FromImage(bmp)
        g.DrawImage(image, New Rectangle(0, 0, 960, 400), New Rectangle(x__1, y__2, w__3, h__4), GraphicsUnit.Pixel)
        'Save the file and reload to the control
        Dim nomImage = CType(lviewOptions.Items(0).FindControl("nomImage"), System.Web.UI.WebControls.HiddenField)
        bmp.Save(Server.MapPath("../Upload/") + nomImage.Value + ".jpg", image.RawFormat)
        bmp.Save(Server.MapPath("../Upload/") + nomImage.Value + ".png", image.RawFormat)
        lviewOptions.DataBind()
        CType(lviewOptions.Items(0).FindControl("mvPhotos"), MultiView).ActiveViewIndex = 0

    End Sub

#End Region

#Region "Nouvelle"

    Public Shared Function GetNouvelle() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim listeNouvelles As List(Of ModeleSentinellesHY.Nouvelle) = Nothing

        listeNouvelles = (From uti In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Order By uti.dateRedaction Descending).ToList

        Return listeNouvelles.AsQueryable()
    End Function
    Public Function getInfoNouvelle() As ModeleSentinellesHY.Nouvelle
        Dim uneNouvelle As New ModeleSentinellesHY.Nouvelle

        If Not (ModeleSentinellesHY.outils.leContexte.NouvelleJeu).Count = 0 AndAlso Not ViewState("modeNouvelle") = "AjoutNouvelle" Then
            Dim idNouvelle As Integer = lviewNouvelle.SelectedDataKey(0)
            uneNouvelle = (From nouv In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Where nouv.idNouvelle = idNouvelle).FirstOrDefault
            ModeleSentinellesHY.outils.leContexte.Entry(uneNouvelle).Reload()
        End If

        Return uneNouvelle
    End Function
    Public Sub UpdateNouvelle(ByVal nouvelleAUpdater As ModeleSentinellesHY.Nouvelle)

        If (ModeleSentinellesHY.outils.leContexte.NouvelleJeu).Count = 0 Then
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
            nouvelleAValider = ModeleSentinellesHY.outils.leContexte.NouvelleJeu.Find(nouvelleAUpdater.idNouvelle)
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
                ModeleSentinellesHY.outils.leContexte.NouvelleJeu.Add(nouvelleAValider)
            End If
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
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
        Dim nouvelleAValider As ModeleSentinellesHY.Nouvelle = Nothing
        nouvelleAValider = ModeleSentinellesHY.outils.leContexte.NouvelleJeu.Find(nouvelleASupprimer.idNouvelle)

        If (Not nouvelleAValider Is Nothing) Then
            ModeleSentinellesHY.outils.leContexte.NouvelleJeu.Remove(nouvelleAValider)
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
        End If

        lviewNouvelle.DataBind()
        lviewInfoNouvelles.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle nouvelle on supprime
        If lviewNouvelle.SelectedIndex = 0 Then
            lviewNouvelle.SelectedIndex = 1
        End If
        If lviewNouvelle.SelectedIndex = 1 Then
            lviewNouvelle.SelectedIndex = 0
        End If
    End Sub

    Private Sub lviewNouvelle_PreRender(sender As Object, e As EventArgs) Handles lviewNouvelle.PreRender
        If lviewNouvelle.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lviewNouvelle.FindControl("lbNouvelleTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
        If ViewState("modeNouvelle") <> "AjoutNouvelle" Then
            lviewInfoNouvelles.DataBind()
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
        Dim listeNouvelle As List(Of ModeleSentinellesHY.Nouvelle) = Nothing
        listeNouvelle = (From nou In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Order By nou.dateRedaction Descending).ToList

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
#End Region

#Region "Événement"
    Private Sub lvEvenement_PreRender(sender As Object, e As EventArgs) Handles lvEvenement.PreRender
        If lvEvenement.Items.Count > 0 And Not Page.IsPostBack Then
            CType(lvEvenement.FindControl("lbEvenementTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If
        If ViewState("modeEvenement") <> "AjoutEvenement" Then
            lvInfoEvenement.DataBind()
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
        Dim listeEvenements As List(Of ModeleSentinellesHY.Événement) = Nothing
        listeEvenements = (From eve In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Order By eve.dateEvenement Descending).ToList


        Return listeEvenements.AsQueryable()
    End Function

    Public Function getInfoEvenement() As ModeleSentinellesHY.Événement
        Dim unEvenement As New ModeleSentinellesHY.Événement
        If Not (ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Count = 0 Or ViewState("modeEvenement") = "AjoutEvenement") Then
            Dim idEvenement As Integer = lvEvenement.SelectedDataKey(0)
            unEvenement = (From eve In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Where eve.idEvenement = idEvenement).FirstOrDefault
            ModeleSentinellesHY.outils.leContexte.Entry(unEvenement).Reload()

        Else

        End If

        Return unEvenement
    End Function

    Public Sub UpdateEvenement(ByVal evenementAUpdater As ModeleSentinellesHY.Événement)

        If ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Count = 0 Then
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
            evenementAValider = ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Find(evenementAUpdater.idEvenement)
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
                ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Add(evenementAValider)
            End If
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
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
        Dim unEvenement As ModeleSentinellesHY.Événement = Nothing
        unEvenement = ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Find(evenementASupprimer.idEvenement)

        If (Not unEvenement Is Nothing) Then
            ModeleSentinellesHY.outils.leContexte.ÉvénementJeu.Remove(unEvenement)
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
        End If

        lvEvenement.DataBind()
        lvInfoEvenement.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle événement on supprime
        If lvEvenement.SelectedIndex = 0 Then
            lvEvenement.SelectedIndex = 1
        End If
        If lvEvenement.SelectedIndex = 1 Then
            lvEvenement.SelectedIndex = 0
        End If
    End Sub

    Private Sub lvInfoEvenement_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvInfoEvenement.ItemDataBound
        Dim listeEvenements As List(Of ModeleSentinellesHY.Événement) = Nothing
        listeEvenements = (From eve In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Order By eve.dateEvenement Descending).ToList

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
#End Region

#Region "Revue de Presse"
    Private Sub lvRDP_PreRender(sender As Object, e As EventArgs) Handles lvRDP.PreRender
        If lvRDP.Items.Count > 0 Then
            CType(lvRDP.FindControl("lbRDPTitre"), LinkButton).CommandArgument = ModeleSentinellesHY.outils.obtenirLangue("TitreFR|TitreEN")
        End If

        If ViewState("modeRDP") <> "AjoutRDP" Then
            lvInfoRDP.DataBind()
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
        Dim listeRDP As List(Of ModeleSentinellesHY.RevueDePresse) = Nothing

        listeRDP = (From rdp In ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

        Return listeRDP.AsQueryable()
    End Function

    Public Function getInfoRDP() As ModeleSentinellesHY.RevueDePresse
        Dim uneRDP As New ModeleSentinellesHY.RevueDePresse

        If Not ((ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu).Count = 0 Or ViewState("modeRDP") = "AjoutRDP") Then
            Dim idRDP As Integer = lvRDP.SelectedDataKey(0)
            uneRDP = (From rdp In ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu Where rdp.idRDP = idRDP).FirstOrDefault
            ModeleSentinellesHY.outils.leContexte.Entry(uneRDP).Reload()
        End If

        Return uneRDP
    End Function

    Public Sub UpdateRDP(ByVal RDPAUpdater As ModeleSentinellesHY.RevueDePresse)
        If ((ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu).Count = 0) Then
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
            RDPAValider = ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu.Find(RDPAUpdater.idRDP)
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
                ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu.Add(RDPAValider)
            End If
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
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
        Dim uneRDP As ModeleSentinellesHY.RevueDePresse = Nothing
        uneRDP = ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu.Find(RDPASupprimer.idRDP)

        If (Not uneRDP Is Nothing) Then
            ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu.Remove(uneRDP)
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
        End If

        lvRDP.DataBind()
        lvInfoRDP.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle revue de presse on supprime
        If lvRDP.SelectedIndex = 0 Then
            lvRDP.SelectedIndex = 1
        End If
        If lvRDP.SelectedIndex = 1 Then
            lvRDP.SelectedIndex = 0
        End If
    End Sub

    Protected Sub lnkUploadRDP_Click(sender As Object, e As EventArgs)
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
                controlUploadRDP.SaveAs(Server.MapPath("../Upload/") & nomFichier)
                CType(lvInfoRDP.Items(0).FindControl("txtboxUrlDocument"), TextBox).Text = nomFichier
            End If
        End If
    End Sub

    Private Sub lvInfoRDP_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvInfoRDP.ItemDataBound
        Dim listeRDP As List(Of ModeleSentinellesHY.RevueDePresse) = Nothing
        listeRDP = (From rdp In ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

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
#End Region

#Region "Utilisateur"
#Region "Statut"
    Public Function getStatutUtilisateur() As IQueryable(Of ModeleSentinellesHY.Statut)

        Dim listeStatutUtilisateur As New List(Of ModeleSentinellesHY.Statut)

        listeStatutUtilisateur = (From ca In ModeleSentinellesHY.outils.leContexte.StatutJeu).ToList


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
        lviewInfoUtilisateur.DataBind()
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
        Dim listeUtilisateurs As New List(Of ModeleSentinellesHY.Utilisateur)

        If txtboxRechercheUtilisateur.Text <> "" Then
            Dim txtRecherche As String = txtboxRechercheUtilisateur.Text
            listeUtilisateurs = (From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu
                                 Where uti.nom.Contains(txtRecherche) Or uti.prenom.Contains(txtRecherche) Or
                                 uti.courriel.Contains(txtRecherche) Or uti.milieu.Contains(txtRecherche) Or
                                 uti.nomUtilisateur.Contains(txtRecherche)
                                 Order By uti.prenom).ToList
        Else
            listeUtilisateurs = (From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu Order By uti.prenom).ToList
        End If
        Return listeUtilisateurs.AsQueryable()
    End Function

    Public Function getInfoUtilisateur() As ModeleSentinellesHY.Utilisateur
        Dim unUtilisateur As New ModeleSentinellesHY.Utilisateur

        If Not ((From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu).Count = 0 Or _
            ViewState("modeUtilisateur") = "AjoutUtilisateur") Then
            Dim idUtilisateur As Integer = lviewUtilisateurs.SelectedDataKey(0)
            unUtilisateur = (From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu Where uti.idUtilisateur = idUtilisateur).FirstOrDefault
            ModeleSentinellesHY.outils.leContexte.Entry(unUtilisateur).Reload()
        End If

        Return unUtilisateur
    End Function

    Private Sub lviewInfoUtilisateur_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lviewInfoUtilisateur.ItemDataBound
        Dim listeUtilisateurs As New List(Of ModeleSentinellesHY.Utilisateur)
        listeUtilisateurs = (From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu Order By uti.prenom).ToList

        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Or listeUtilisateurs.Count = 0 Then
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = False
            CType(lviewInfoUtilisateur.FindControl("lnkbtnAjouter"), LinkButton).Visible = False
        Else
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = True
            CType(lviewInfoUtilisateur.FindControl("lnkbtnAjouter"), LinkButton).Visible = True
        End If

        If CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).idUtilisateur = CType(e.Item.DataItem, ModeleSentinellesHY.Utilisateur).idUtilisateur Then
            CType(e.Item.FindControl("btnSupprimerUti"), LinkButton).Visible = False
        End If
    End Sub

    Public Sub DeleteUtilisateur(ByVal utilisateurASupprimer As ModeleSentinellesHY.Utilisateur)
        Dim utilisateurAValider As ModeleSentinellesHY.Utilisateur = Nothing
        utilisateurAValider = ModeleSentinellesHY.outils.leContexte.UtilisateurJeu.Find(utilisateurASupprimer.idUtilisateur)

        If (Not utilisateurAValider Is Nothing) Then
            ModeleSentinellesHY.outils.leContexte.UtilisateurJeu.Remove(utilisateurAValider)
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
        End If

        lviewUtilisateurs.DataBind()
        lviewInfoUtilisateur.DataBind()

        'On affiche l'index suivant ou précédent dépendamment de quelle nouvelle on supprime
        If lviewUtilisateurs.SelectedIndex = 0 Then
            lviewUtilisateurs.SelectedIndex = 1
        Else
            lviewUtilisateurs.SelectedIndex = 0
        End If
    End Sub

    Public Sub UpdateUtilisateur(ByVal idUtilisateur As Integer)

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
        Else
            utilisateurAValider = ModeleSentinellesHY.outils.leContexte.UtilisateurJeu.Find(idUtilisateur)
        End If

        'Prend les données qui sont dans le formulaire
        TryUpdateModel(utilisateurAValider)

        'On vérifie que l'utilisateur à ajouter ne possède pas un username identique à un autre usager
        'de la BD
        If ViewState("modeUtilisateur") = "AjoutUtilisateur" Then
            Dim doublon = (From uti As ModeleSentinellesHY.Utilisateur In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu Where uti.nomUtilisateur.Equals(utilisateurAValider.nomUtilisateur)).FirstOrDefault
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
                ModeleSentinellesHY.outils.leContexte.UtilisateurJeu.Add(utilisateurAValider)
            End If
            ModeleSentinellesHY.outils.leContexte.SaveChanges()
            ViewState("modeUtilisateur") = ""
            lblMessageErreurInfoUtilisateur.Text = "L'utilisateur a été modifié avec succès!"
            lblMessageErreurInfoUtilisateur.ForeColor = Color.Green

            'Conditions pour Supprimer Avatar du fichier Upload
            If utilisateurAValider.UrlAvatar <> utilisateurAValider.urlAvatarTemp AndAlso utilisateurAValider.UrlAvatar <> "" _
                AndAlso utilisateurAValider.UrlAvatar <> "default.png" Then
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

    Protected Sub lnkUpload_Click(sender As Object, e As EventArgs)

        'Upload de l'avatar des membres du forum
        Dim controlUpload = CType(lviewInfoUtilisateur.Items(0).FindControl("fuplPhoto"), FileUpload)
        Dim extension As String = ""
        Dim nomFichier As String = ""
        If controlUpload.HasFile Then
            If controlUpload.PostedFile.ContentType = "image/jpeg" Or controlUpload.PostedFile.ContentType = "image/png" Then
                nomFichier = Left(controlUpload.FileName, Len(controlUpload.FileName) - 4)
                extension = Right(controlUpload.FileName, 4)
                If nomFichier.Length > 30 Then
                    nomFichier = Left(nomFichier, 30)
                End If

                'On ajoute un nombre aléatoire à la fin afin d'éviter d'écraser des fichiers existants
                Dim MyRandomNumber As New Random()
                Dim x As Integer = MyRandomNumber.Next(10000, 100000)
                nomFichier &= x
                nomFichier &= extension

                ResizeImageFile(controlUpload.PostedFile.InputStream, 120, Server.MapPath("../Upload/" & nomFichier), "typeAvatar")
                CType(lviewInfoUtilisateur.Items(0).FindControl("txtboxNomPhoto"), TextBox).Text = nomFichier
                CType(lviewInfoUtilisateur.Items(0).FindControl("imgUpload"), HtmlImage).Src = "../../Upload/" & nomFichier
            End If
        End If
    End Sub

    Public Shared Function ResizeImageFile(imageFileMS As Stream, targetSize As Integer, lepathfichier As String, typeUpload As String) As String

        Dim original As Image = Image.FromStream(imageFileMS)
        Dim targetH As Integer, targetW As Integer

        'Redimensionne la photo selon s'il s'agit d'un avatar ou d'une image du carousel
        If typeUpload.Contains("typeAvatar") Then
            If original.Height > original.Width Then
                targetH = targetSize
                targetW = CInt(original.Width * (CSng(targetSize) / CSng(original.Height)))
            Else
                targetW = targetSize
                targetH = CInt(original.Height * (CSng(targetSize) / CSng(original.Width)))
            End If
        Else
            targetH = 400
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
#End Region

End Class