Public Class FRMnouvelles
    Inherits ModeleSentinellesHY.FRMdeBase

    Public Shared Function getFRMNouvelles() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In leContexte.NouvelleJeu Order By nou.idNouvelle Descending).ToList

        Return listeNouvelles.AsQueryable
    End Function

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        lvNouvelles.Sort("dateRedaction", SortDirection.Descending)
        lvNouvelles.DataBind()
    End Sub
End Class