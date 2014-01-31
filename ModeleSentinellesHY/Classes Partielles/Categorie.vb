'Classe comportant toutes les propriétés des entités Categorie ainsi qu'un constructeur vide. 

Partial Public Class Categorie

    Public Sub New()
        nomCategorieFR = ""

        nomCategorieEN = ""
    End Sub

    'Propriété tampon qui sert à stocker le nom de la categorie dans la langue appropriée
    'On affiche ensuite cette propriété ci
    Private _nomCategorie As String
    Public Property nomCategorie
        Set(value)
            _nomCategorie = value
        End Set
        Get
            Return _nomCategorie
        End Get
    End Property
End Class