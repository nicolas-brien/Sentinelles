Imports System.Threading
Public Class FRMhistorique
    Inherits ModeleSentinellesHY.FRMdeBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub temoignageHistorique_Init(sender As Object, e As EventArgs)
        'On va chercher les infos dans la BD et on les affiche
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lesInfos = (From inf In leContexte.InfoGeneraleJeu).FirstOrDefault
        CType(sender, Label).Text = ModeleSentinellesHY.outils.obtenirLangue(lesInfos.temoignageFR & "|" & lesInfos.temoignageEN)
    End Sub

    Protected Sub texteHistorique_Init(sender As Object, e As EventArgs)
        'On va chercher les infos dans la BD et on les affiche
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lesInfos = (From inf In leContexte.InfoGeneraleJeu).FirstOrDefault
        CType(sender, Label).Text = ModeleSentinellesHY.outils.obtenirLangue(lesInfos.historiqueFR & "|" & lesInfos.historiqueEN)
    End Sub
End Class