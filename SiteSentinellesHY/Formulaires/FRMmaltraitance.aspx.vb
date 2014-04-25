Imports System.Threading
Public Class FRMmaltraitance
    Inherits ModeleSentinellesHY.FRMdeBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub textMaltraitance_Init(sender As Object, e As EventArgs)
        'On va chercher les infos dans la BD et on les affiche
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lesInfos = (From inf In leContexte.InfoGeneraleJeu).FirstOrDefault
        CType(sender, Label).Text = ModeleSentinellesHY.outils.obtenirLangue(lesInfos.maltraitanceFR & "|" & lesInfos.maltraitanceEN)
    End Sub
End Class