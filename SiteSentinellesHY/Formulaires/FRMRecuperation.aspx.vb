Public Class FRMRecuperation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lbtnEnvoyer_Click(sender As Object, e As EventArgs)
        Try
            Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
            Dim courriel = tbCourriel.Text
            Dim usager = (From util In leContexte.UtilisateurJeu
                          Where util.courriel = courriel
                          Select util).ToList.FirstOrDefault
            If usager Is Nothing Then
                lblErreur.Text = "Il n'y a aucun usager associé à cet adresse courriel!"
                lblSucces.Visible = False
            Else
                Dim nouveauSel = ModeleSentinellesHY.outils.SecureRandom(3)
                Dim nouveauMotDePasse = ModeleSentinellesHY.outils.SecureRandom(8)

                usager.SelDeMer = nouveauSel
                usager.motDePasse = ModeleSentinellesHY.outils.encryptage(nouveauMotDePasse & nouveauSel)

                leContexte.SaveChanges()
                lblSucces.Text = "Un courriel vient de vous être envoyé avec un nouveau mot de passe!"
                lblErreur.Visible = False

                Dim expediteur As String = "info@sentinelleshy.ca"
                Dim mail As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
                mail.To.Add(courriel)
                mail.From = New System.Net.Mail.MailAddress(expediteur, "Récupération de mot de passe", System.Text.Encoding.UTF8)
                mail.Subject = "Sentinelles Haute-Yamaska - Récupération de mot de passe"
                mail.SubjectEncoding = System.Text.Encoding.UTF8
                mail.Body = "Bonjour " & usager.prenom & " " & usager.nom & "!<br/><br/>"
                mail.Body &= "Voici vos informations de connexion pour le site web des Sentinelles Haute-Yamaksa :"
                mail.Body &= "<br/>USAGER : <b>" & usager.nomUtilisateur & "</b><br/>"
                mail.Body &= "<br/>MOT DE PASSE : <b>" & nouveauMotDePasse & "</b><br/>"
                mail.Body &= "<br/><br/>Veuillez vous connecter au http://www.sentinelleshy.ca pour aller sur votre profil et ainsi changer de mot de passe.<br/>"
                mail.Body &= "<br/>Au plaisir de vous revoir bientôt sur le site web des Sentinelles Haute-Yamaska!"

                mail.BodyEncoding = System.Text.Encoding.UTF8
                mail.IsBodyHtml = True
                mail.Priority = System.Net.Mail.MailPriority.High
                Dim client As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()

                client.Credentials = New System.Net.NetworkCredential("info@sentinelleshy.ca", "Vs2H7!Etu")

                client.Port = 25
                client.Host = "mail.sentinelleshy.ca"

                client.Send(mail)
            End If
        Catch ex As Exception

        End Try
    End Sub
End Class