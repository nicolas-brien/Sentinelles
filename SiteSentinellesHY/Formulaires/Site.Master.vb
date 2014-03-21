Imports System.Threading

Partial Class Site
    Inherits System.Web.UI.MasterPage

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        If Thread.CurrentThread.CurrentCulture.EnglishName.ToString.Contains("English") Then
            Banniere.ImageUrl = "~/Images/BanniereEN.png"
            imgbtnLogo.ImageUrl = "~/Images/LogoOfficielHYSmallEN.png"
            pastilleInfo.ImageUrl = "~/Images/PastilleDevenirSentinelleEN.png"
            pastilleSuicide.ImageUrl = "~/Images/PastilleInfoSuicideEN.png"
            pastilleMaltraitance.ImageUrl = "~/Images/PastilleInfoMaltraitanceEN.png"

        Else
            Banniere.ImageUrl = "~/Images/BanniereFR.png"
            imgbtnLogo.ImageUrl = "~/Images/LogoOfficielHYSmallFR.png"
            pastilleInfo.ImageUrl = "~/Images/PastilleDevenirSentinelleFR.png"
            pastilleSuicide.ImageUrl = "~/Images/PastilleInfoSuicideFR.png"
            pastilleMaltraitance.ImageUrl = "~/Images/PastilleInfoMaltraitanceFR.png"
        End If

        If Request.Url.ToString.Contains("index") Then
            divAccueil.Attributes("class") = "barreNavigationDivCourant pull-right"
            lnkbtnAccueil.Attributes("class") = "pull-right barreNavigationMenuCurrent"
        ElseIf Request.Url.ToString.Contains("historique") Then
            divHistorique.Attributes("class") = "barreNavigationDivCourant pull-right"
            lnkbtnHistorique.Attributes("class") = "pull-right barreNavigationMenuCurrent"
        ElseIf Request.Url.ToString.Contains("nouvelles") Then
            divNouvelles.Attributes("class") = "barreNavigationDivCourant pull-right"
            lnkbtnNouvelles.Attributes("class") = "pull-right barreNavigationMenuCurrent"
        ElseIf Request.Url.ToString.Contains("evenements") Then
            divEvenements.Attributes("class") = "barreNavigationDivCourant pull-right"
            lnkbtnEvenements.Attributes("class") = "pull-right barreNavigationMenuCurrent"
        ElseIf Request.Url.ToString.Contains("revuedepresse") Then
            divRevueDePresse.Attributes("class") = "barreNavigationDivCourant pull-right"
            lnkbtnRevueDePresse.Attributes("class") = "pull-right barreNavigationMenuCurrent"
        End If

        If Session("Utilisateur") IsNot Nothing Then
            divLogin.Visible = True
            If CType(Session("Autorisation"), Integer) < 3 Then
                iconSetting.Visible = True
            End If

            CType(lnkConnexion, HtmlControl).Attributes("href") = "../Formulaires/FRMForum.aspx"
            lblInfoUtilisateur.InnerText = CType(Session("Utilisateur"), ModeleSentinellesHY.Utilisateur).nomUtilisateur
        End If
    End Sub


    Protected Sub lnkAnglais_Click(sender As Object, e As EventArgs)
        Dim culture As String = ""

        culture = ModeleSentinellesHY.outils.obtenirLangue("EN|FR")

        Dim aCookie As New HttpCookie("SentinellesHY")
        aCookie.Values("langue") = culture
        aCookie.Expires = System.DateTime.Now.AddDays(3650)
        Response.Cookies.Add(aCookie)

        Response.Redirect(Request.Url.AbsoluteUri, False)
    End Sub

    Private Function UtilALL() As Object
        Throw New NotImplementedException
    End Function

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        lblLoginErrorMessage.Text = ""

        If Not (tbLoginPassword.Text = "" Or tbLoginUsername.Text = "") Then
            Dim unUtilisateur As New ModeleSentinellesHY.Utilisateur
            unUtilisateur = (From uti In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu Where uti.nomUtilisateur = tbLoginUsername.Text).FirstOrDefault
            If unUtilisateur Is Nothing Then
                lblLoginErrorMessage.Text = ModeleSentinellesHY.outils.obtenirLangue("Le nom d'utilisateur ou le mot de passe est incorrecte. |The username or the password is incorrect.")
            Else
                If ModeleSentinellesHY.outils.VerifierMotDePasse(unUtilisateur, tbLoginPassword.Text) Then
                    'On mémorise ces informations dans des objets session afin de les utiliser plus tard
                    Session("Utilisateur") = unUtilisateur
                    Session("Autorisation") = unUtilisateur.idStatut
                    Response.Redirect("FRMForum.aspx")
                Else
                    lblLoginErrorMessage.Text = ModeleSentinellesHY.outils.obtenirLangue("Le nom d'utilisateur ou le mot de passe est incorrecte. |The username or the password is incorrect.")
                End If
            End If
        Else
            lblLoginErrorMessage.Text = ModeleSentinellesHY.outils.obtenirLangue("Le nom d'utilisateur et le mot de passe sont requis.|The username and the password are required.")
        End If
    End Sub

    Protected Sub lnkbtnLogout_Click(sender As Object, e As EventArgs)
        Session("Utilisateur") = Nothing
        Session("Autorisation") = Nothing
        Response.Redirect("index.aspx")
    End Sub
End Class