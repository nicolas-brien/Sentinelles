'Classe comportant toutes les propriétés des entités Revue de Presse ainsi qu'un constructeur vide. 

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(RevueDePresseValidation))> _
Partial Public Class RevueDePresse
    Implements IValidatableObject

    'Propriété servant à vérifier si l'utilisateur à changer l'url du document et qu'il ne l'a pas encore sauvegarder
    'dans la méthode update de la revue de presse
    Private _urlDocumentTemp As String
    Public Property urlDocumentTemp As String
        Get
            Return _urlDocumentTemp
        End Get
        Set(value As String)
            _urlDocumentTemp = value
        End Set
    End Property

    Public Sub New()
        titreFR = ""
        titreEN = ""
        contenuEN = ""
        contenuFR = ""
        urlDocument = ""
    End Sub

    Public Property DateRedactionDo() As String
        Get
            Return Me.dateRedaction.ToLongDateString()
        End Get
        Set(value As String)
            Dim laDate As New DateTime()
            If DateTime.TryParse(value, laDate) Then
                Me.dateRedaction = laDate
            End If
        End Set
    End Property

    Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
       Implements IValidatableObject.Validate
        'Liste d'erreurs(data annotations) outils validation

        Dim listeRetour = New List(Of ValidationResult)

        Return listeRetour
    End Function
End Class

Partial Public Class RevueDePresseValidation

    <DisplayName("TitreFR"), _
    Required(ErrorMessage:="Le titre en français est requis|The french title is required"), _
    StringLength(75, ErrorMessage:="Le titre en français doit contenir moins de 75 caractères|The french title must contain less than 75 characters")>
    Public Property titreFR As String

    <DisplayName("TitreEN"), _
    Required(ErrorMessage:="Le titre en anglais est requis|The english title is required"), _
    StringLength(75, ErrorMessage:="Le titre en anglais doit contenir moins de 75 caractères|The english title must contain less than 75 characters")>
    Public Property titreEN As String

    <DisplayName("ContenuFR"), _
    Required(ErrorMessage:="Le contenu en français est requis|The french content is required")>
    Public Property contenuFR As String

    <DisplayName("ContenuEN"), _
    Required(ErrorMessage:="Le contenu en anglais est requis|The english content is required")>
    Public Property contenuEN As String

    <DisplayName("UrlDocument"), _
    Required(ErrorMessage:="Un fichier ou un lien vers la revue de presse est requis|A file or a link to the press review is required"), _
    StringLength(4000, ErrorMessage:="L'hyperlien doit contenir moins de 4000 caractères... Sans exagération!|The hyperlink must contain less than 4000 characters")>
    Public Property urlDocument As String

End Class
