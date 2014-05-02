'Classe comportant toutes les propriétés des entités Nouvelle ainsi qu'un constructeur vide. 

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(NouvelleValidation))> _
Partial Public Class Nouvelle
    Implements IValidatableObject

    Public Sub New()
        titreFR = ""
        titreEN = ""
        contenuEN = ""
        contenuFR = ""
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

Partial Public Class NouvelleValidation

    <DisplayName("TitreFR"), _
    Required(ErrorMessage:="Le titre en français est requis|The french title is required")>
    Public Property titreFR As String

    <DisplayName("TitreEN"), _
    Required(ErrorMessage:="Le titre en anglais est requis|The english title is required")>
    Public Property titreEN As String

    <DisplayName("ContenuFR"), _
    Required(ErrorMessage:="Le contenu en français est requis|The french content is required")>
    Public Property contenuFR As String

    <DisplayName("ContenuEN"), _
    Required(ErrorMessage:="Le contenu en anglais est requis|The english content is required")>
    Public Property contenuEN As String


End Class
