'Classe comportant une propriété tampon pour l'entité Statut.

Partial Public Class Statut

    'Propriété tampon qui sert à stocker le nom du statut dans la langue appropriée
    'On affiche ensuite cette propriété ci
    Private _nomStatut As String
    Public Property nomStatut
        Set(value)
            _nomStatut = value
        End Set
        Get
            Return _nomStatut
        End Get
    End Property

End Class
