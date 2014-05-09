'Classe comportant toutes les propriétés des entités Événement ainsi qu'un constructeur vide. 

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(ÉvénementValidation))> _
Partial Public Class Événement
    Implements IValidatableObject

    Public Sub New()
        titreFR = ""
        titreEN = ""
        contenuEN = ""
        contenuFR = ""
        dateEvenement = Date.Now
    End Sub

    Public Property DateEvenementDo() As String
        Get
            Return Me.dateEvenement.ToLongDateString()
        End Get
        Set(value As String)
            Dim laDate As New DateTime()
            If DateTime.TryParse(value, laDate) Then
                Me.dateEvenement = laDate
            End If
        End Set
    End Property
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

Partial Public Class ÉvénementValidation
    <DisplayName("TitreFR"), _
    Required(ErrorMessage:="Le titre en français est requis|The french title is required"), _
    StringLength(75, ErrorMessage:="Le titre en français doit contenir moins de 75 caractères|The french title must contain less than 75 characters")>
    Public Property titreFR As String

    <DisplayName("TitreEN"), _
    Required(ErrorMessage:="Le titre en anglais est requis|The english title is required"), _
    StringLength(75, ErrorMessage:="Le titre en français doit contenir moins de 75 caractères|The french title must contain less than 75 characters")>
    Public Property titreEN As String

    <DisplayName("ContenuFR"), _
    Required(ErrorMessage:="Le contenu en français est requis|The french content is required")>
    Public Property contenuFR As String

    <DisplayName("ContenuEN"), _
    Required(ErrorMessage:="Le contenu en anglais est requis|The english content is required")>
    Public Property contenuEN As String
    
    <DisplayName("dateEvenement"), _
    Required(ErrorMessage:="La date de l'événement est requise|The event date is required")>
    Public Property dateEvenement As String
End Class
