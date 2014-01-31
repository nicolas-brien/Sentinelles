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
        Dim lesInfos = (From inf In ModeleSentinellesHY.outils.leContexte.InfoGeneraleJeu).FirstOrDefault
        CType(sender, Label).Text = ModeleSentinellesHY.outils.obtenirLangue(lesInfos.penseeFR & "|" & lesInfos.penseeEN)

    End Sub
#End Region

#Region "Nouvelles"
    Public Shared Function getPremiereNouvelle() As ModeleSentinellesHY.Nouvelle
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Order By nou.dateRedaction Descending).ToList

        If listeNouvelles.Count > 0 Then
            Return listeNouvelles.FirstOrDefault
        End If
        Return Nothing
    End Function

    Public Shared Function getNouvelles() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Order By nou.dateRedaction Descending).Take(3).ToList
        listeNouvelles.RemoveAt(0)

        Return listeNouvelles.AsQueryable
    End Function
#End Region

#Region "Evenements"
    Public Shared Function getPremierEvenement() As ModeleSentinellesHY.Événement
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From eve In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Order By eve.dateRedaction Descending).ToList

        Return listeEvenements.FirstOrDefault
    End Function

    Public Shared Function getEvenements() As IQueryable(Of ModeleSentinellesHY.Événement)
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From eve In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Order By eve.dateRedaction Descending).Take(3).ToList
        listeEvenements.RemoveAt(0)

        Return listeEvenements.AsQueryable
    End Function
#End Region

#Region "Revue de Presse"
    Public Shared Function getPremiereRDP() As ModeleSentinellesHY.RevueDePresse
        Dim listeRevuesDePresse As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRevuesDePresse = (From rdp In ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).ToList

        Return listeRevuesDePresse.FirstOrDefault
    End Function

    Public Shared Function getRDP() As IQueryable(Of ModeleSentinellesHY.RevueDePresse)
        Dim listeRevuesDePresse As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRevuesDePresse = (From rdp In ModeleSentinellesHY.outils.leContexte.RevueDePresseJeu Order By rdp.dateRedaction Descending).Take(3).ToList
        If listeRevuesDePresse.Count > 0 Then
            listeRevuesDePresse.RemoveAt(0)
        End If

        Return listeRevuesDePresse.AsQueryable
    End Function
#End Region
End Class