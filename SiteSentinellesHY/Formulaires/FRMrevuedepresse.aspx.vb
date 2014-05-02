Public Class FRMrevuedepresse
    Inherits ModeleSentinellesHY.FRMdeBase
    Public Shared Function getRevueDePresse() As IQueryable(Of ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRDP As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRDP = (From nou In leContexte.RevueDePresseJeu Order By nou.idRDP Descending).ToList

        Return listeRDP.AsQueryable
    End Function
    Private Sub lvRevueDePresse_DataBound(sender As Object, e As EventArgs) Handles lvRevueDePresse.DataBound
        'On cache le datapager s'il n'y a qu'une seule page
        dataPagerHaut.Visible = (dataPagerHaut.PageSize < dataPagerHaut.TotalRowCount)
        dataPagerBas.Visible = (dataPagerBas.PageSize < dataPagerBas.TotalRowCount)
    End Sub

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        lvRevueDePresse.Sort("dateRedaction", SortDirection.Descending)
        lvRevueDePresse.DataBind()
    End Sub
End Class