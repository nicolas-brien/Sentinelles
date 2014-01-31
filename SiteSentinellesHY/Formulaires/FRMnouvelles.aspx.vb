Public Class FRMnouvelles
    Inherits ModeleSentinellesHY.FRMdeBase

    Public Shared Function getFRMNouvelles() As IQueryable(Of ModeleSentinellesHY.Nouvelle)
        Dim listeNouvelles As New List(Of ModeleSentinellesHY.Nouvelle)

        listeNouvelles = (From nou In ModeleSentinellesHY.outils.leContexte.NouvelleJeu Order By nou.idNouvelle Descending).ToList

        Return listeNouvelles.AsQueryable
    End Function

    'On cache le datapager s'il n'y a qu'une seule page
    Private Sub lvNouvelles_DataBound(sender As Object, e As EventArgs) Handles lvNouvelles.DataBound
        dataPagerHaut.Visible = (dataPagerHaut.PageSize < dataPagerHaut.TotalRowCount)
        dataPagerBas.Visible = (dataPagerBas.PageSize < dataPagerBas.TotalRowCount)
    End Sub

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        lvNouvelles.Sort("dateRedaction", SortDirection.Descending)
        lvNouvelles.DataBind()
    End Sub
End Class