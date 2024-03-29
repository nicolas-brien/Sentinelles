﻿Public Class FRMevenements
    Inherits ModeleSentinellesHY.FRMdeBase
    Public Shared Function getEvenements() As IQueryable(Of ModeleSentinellesHY.Événement)
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeEvenements As New List(Of ModeleSentinellesHY.Événement)

        listeEvenements = (From nou In leContexte.ÉvénementJeu Order By nou.idEvenement Descending).ToList

        Return listeEvenements.AsQueryable
    End Function

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Sert à ordonner les événements du plus récent au plus ancien
        lvEvenements.Sort("dateRedaction", SortDirection.Descending)
        lvEvenements.DataBind()
    End Sub
End Class