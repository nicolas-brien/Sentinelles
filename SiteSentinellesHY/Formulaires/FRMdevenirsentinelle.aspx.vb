Partial Class FRMdevenirsentinelle
    Inherits ModeleSentinellesHY.FRMdeBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Javascript pour le nombre de caractères restants du Textbox Multiline A Propos
        tbaPropos.Attributes.Add("onKeyUp", String.Format("countDown('{0}','{1}', 500) ", tbaPropos.ClientID, lblCharRestant.ClientID))

        'Javascript pour bloquer le TextBox Multiline A Propos à 500 caractères
        tbaPropos.Attributes.Add("onkeyDown", "return checkTextAreaMaxLength(this,event,'500');")

    End Sub


    'Bouton d'envoi du formulaire Devenir Sentinelle
    Protected Sub btnEnvoi_Click(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim unFormulaire As New ModeleSentinellesHY.FormulaireSentinelle
        Dim listeErreur As New List(Of ModeleSentinellesHY.clsErreur)
        Dim contenant As Control = divFormulaire

        unFormulaire.nom = tbnom.Text
        unFormulaire.noTelephone = tbnoTelephone.Text
        unFormulaire.courriel = tbcourriel.Text
        unFormulaire.aPropos = tbaPropos.Text

        For Each tb As Object In divFormulaire.Controls 'Reset l'encadrer autour de tout txtBox
            If TypeOf (tb) Is TextBox Then
                CType(tb, TextBox).BorderColor = Nothing
            End If
        Next

        lblErreurSentinelle.Text = ""

        'Condition qui vérifie si le formulaire est valide. S'il ne l'est pas, on affiche les erreurs et on encadre en rouge
        'les Textbox qui doivent être corrigé.
        If ModeleSentinellesHY.outils.validationFormulaire(unFormulaire, New ModeleSentinellesHY.FormulaireSentinelleValidation, _
            divFormulaire, listeErreur) = False Then
            For Each erreur As ModeleSentinellesHY.clsErreur In listeErreur
                lblErreurSentinelle.Text += "*" & erreur.errorMessage & "<br/>"
                CType(ModeleSentinellesHY.outils.FindChildControls(Of TextBox)(divFormulaire, "tb" & erreur.nomPropriete), TextBox).BorderColor = Drawing.Color.Red
            Next
            'Puisque le formulaire est valide, on procède à l'envoi du courriel
        Else
            Dim destinataire As String = (From info In leContexte.InfoGeneraleJeu).FirstOrDefault.courrielFormulaire
            Dim expediteur As String = "info@sentinelleshy.ca"
            Dim mail As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
            mail.To.Add(destinataire)
            mail.From = New System.Net.Mail.MailAddress(expediteur, "Inscription de " & tbnom.Text, System.Text.Encoding.UTF8)
            mail.Subject = "Sentinelles Haute-Yamaska - Inscription de " & tbnom.Text
            mail.SubjectEncoding = System.Text.Encoding.UTF8
            mail.Body = "L'utilisateur suivant souhaiterait que vous le contactiez afin de compléter son inscription en tant que sentinelle. <br/><br/>"
            mail.Body &= "<br/>NOM : <b>" & tbnom.Text & "</b><br/>"
            mail.Body &= "<br/>NUMÉRO DE TÉLÉPHONE : <b>" & tbnoTelephone.Text & "</b><br/>"
            mail.Body &= "<br/>COURRIEL : <b>" & tbcourriel.Text & "</b><br/>"
            mail.Body &= "<br/>À PROPOS : <b>" & tbaPropos.Text & "</b><br/>"

            mail.BodyEncoding = System.Text.Encoding.UTF8
            mail.IsBodyHtml = True
            mail.Priority = System.Net.Mail.MailPriority.High
            Dim client As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()

            client.Credentials = New System.Net.NetworkCredential("info@sentinelleshy.ca", "Vs2H7!Etu")

            client.Port = 25
            client.Host = "mail.sentinelleshy.ca"
            'client.EnableSsl = True 'Gmail Secured Layer
            'client.Port = 587 ' Gmail port
            'client.Host = "smtp.gmail.com"
            'client.EnableSsl = True 'Gmail Secured Layer

            client.Send(mail)
            Response.Redirect("~/Formulaires/FRMConfirmation.aspx", False)
        End If
    End Sub
End Class

