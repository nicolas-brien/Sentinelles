Public Class FRMrevuedepresse
    Inherits ModeleSentinellesHY.FRMdeBase
    Public Shared Function getRevueDePresse() As IQueryable(Of ModeleSentinellesHY.RevueDePresse)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRDP As New List(Of ModeleSentinellesHY.RevueDePresse)

        listeRDP = (From nou In leContexte.RevueDePresseJeu Order By nou.idRDP Descending).ToList

        Return listeRDP.AsQueryable
    End Function

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        lvRevueDePresse.Sort("dateRedaction", SortDirection.Descending)
        lvRevueDePresse.DataBind()
    End Sub
End Class