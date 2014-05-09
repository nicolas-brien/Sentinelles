'Classe comportant toutes les propriétés des entités Categorie ainsi qu'un constructeur vide. 
Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(CategorieValidation))> _
Partial Public Class Categorie
    Implements IValidatableObject
    Public Sub New()
        nomCategorieFR = ""
        nomCategorieEN = ""
    End Sub
    Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
   Implements IValidatableObject.Validate
        'Liste d'erreurs(data annotations) outils validation

        Dim listeRetour = New List(Of ValidationResult)

        Return listeRetour
    End Function
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

Partial Public Class CategorieValidation
    <DisplayName("nomCategorieFR"), _
    Required(ErrorMessage:="Le nom de catégorie en français est requis|The french name of the category is required"), _
    StringLength(50, ErrorMessage:="Le nom de catégorie en français doit contenir moins de 50 caractères|The french name of the category must contain less than 50 characters")>
    Public Property nomCategorieFR As String

    <DisplayName("nomCategorieEN"), _
    Required(ErrorMessage:="Le nom de catégorie en anglais est requis|The english name of the category is required"), _
    StringLength(50, ErrorMessage:="Le nom de catégorie en anglais doit contenir moins de 50 caractères|The english name of the category must contain less than 50 characters")>
    Public Property nomCategorieEN As String
End Class