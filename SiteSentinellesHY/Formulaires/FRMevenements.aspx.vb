Public Class FRMevenements
    Inherits ModeleSentinellesHY.FRMdeBase
    Public Shared Function getEvenements() As IQueryable(Of ModeleSentinellesHY.Événement)
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From nou In ModeleSentinellesHY.outils.leContexte.ÉvénementJeu Order By nou.idEvenement Descending).ToList

        Return listeEvenements.AsQueryable
    End Function
    Private Sub lvEvenements_DataBound(sender As Object, e As EventArgs) Handles lvEvenements.DataBound
        'Cache les datapager si le nombre de page est de 1
        dataPagerHaut.Visible = (dataPagerHaut.PageSize < dataPagerHaut.TotalRowCount)
        dataPagerBas.Visible = (dataPagerBas.PageSize < dataPagerBas.TotalRowCount)
    End Sub

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Sert à ordonner les événements du plus récent au plus ancien
        lvEvenements.Sort("dateRedaction", SortDirection.Descending)
        lvEvenements.DataBind()
    End Sub
End Class