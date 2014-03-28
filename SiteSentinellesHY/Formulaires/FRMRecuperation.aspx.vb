Public Class FRMRecuperation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lbtnEnvoyer_Click(sender As Object, e As EventArgs)
        Dim courriel = tbCourriel.Text
        Dim usager = (From util In ModeleSentinellesHY.outils.leContexte.UtilisateurJeu
                      Where util.courriel = courriel
                      Select util).ToList.FirstOrDefault
        If usager Is Nothing Then
            lblErreur.Text = "Il n'y a aucun usager associé à cet adresse courriel!"
        Else

        End If
    End Sub
End Class