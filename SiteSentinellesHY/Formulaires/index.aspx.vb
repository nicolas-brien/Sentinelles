Imports System.Threading

Public Class index
    Inherits ModeleSentinellesHY.FRMdeBase

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        lvPremiereNouvellesAccueil.DataBind()
        lvPremierEvenementAccueil.DataBind()
        lvPremiereRDPAccueil.DataBind()
    End Sub

#Region "Pensée"
    Protected Sub lblPenseeAccueil_Init(sender As Object, e As EventArgs)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim lesInfos = (From inf In leContexte.InfoGeneraleJeu).FirstOrDefault
        CType(sender, Label).Text = ModeleSentinellesHY.outils.obtenirLangue(lesInfos.penseeFR & "|" & lesInfos.penseeEN)

    End Sub
#End Region

#Region "Nouvelles"
    Public Function getPremiereNouvelle() As ModeleSentinellesHY.Nouvelle
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In leContexte.NouvelleJeu Order By nou.dateRedaction Descending).ToList

        If listeNouvelles.Count = 0 Then
            divContantNouvelles.Visible = False
        End If

        Return listeNouvelles.FirstOrDefault
    End Function

    Public Shared Function getNouvelles() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In leContexte.NouvelleJeu Order By nou.dateRedaction Descending).Take(3).ToList

        If listeNouvelles.Count > 0 Then
            listeNouvelles.RemoveAt(0)
        End If

        Return listeNouvelles.AsQueryable
    End Function
#End Region

#Region "Evenements"
    Public Function getPremierEvenement() As ModeleSentinellesHY.Événement
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From eve In leContexte.ÉvénementJeu Order By eve.dateRedaction Descending).ToList

        If listeEvenements.Count = 0 Then
            divContenantEvenement.Visible = False
        End If

        Return listeEvenements.FirstOrDefault
    End Function

    Public Shared Function getEvenements() As IQueryable(Of ModeleSentinellesHY.Événement)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From eve In leContexte.ÉvénementJeu Order By eve.dateRedaction Descending).Take(3).ToList

        If listeEvenements.Count > 0 Then
            listeEvenements.RemoveAt(0)
        End If

        Return listeEvenements.AsQueryable
    End Function
#End Region

#Region "Revue de Presse"
    Public Function getPremiereRDP() As ModeleSentinellesHY.RevueDePresse
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRevuesDePresse As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRevuesDePresse = (From rdp In leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

        If listeRevuesDePresse.Count = 0 Then
            divContenantRDP.Visible = False
        End If

        Return listeRevuesDePresse.FirstOrDefault
    End Function

    Public Shared Function getRDP() As IQueryable(Of ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRevuesDePresse As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRevuesDePresse = (From rdp In leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).Take(3).ToList

        If listeRevuesDePresse.Count > 0 Then
            listeRevuesDePresse.RemoveAt(0)
        End If

        Return listeRevuesDePresse.AsQueryable
    End Function
#End Region
End Class