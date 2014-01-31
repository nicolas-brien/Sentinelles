'Classe comportant toutes les propriétés de l'entité Info Générale ainsi qu'un constructeur vide. 
'Cette classe sert à aller chercher toutes les informations uniques qui s'affiche sur le site web.
'Il n'y a qu'une seule entité de ce type. Elle contient la pensée qui s'affiche à l'accueil, le témoignage,
'l'historique des Sentinelles, un bref texte sur la maltraitance ainsi que le courriel auquel sont redirigés
'les demandes afin de devenir sentinelle. Les textes sont présent dans les deux langues dans cette entité.
Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(InfoGeneraleValidation))> _
Partial Public Class InfoGenerale
    Implements IValidatableObject

    Public Sub New()
        idInfo = 0
        penseeFR = ""
        penseeEN = ""
        temoignageFR = ""
        temoignageEN = ""
        historiqueFR = ""
        historiqueEN = ""
        maltraitanceFR = ""
        maltraitanceEN = ""
        courrielFormulaire = ""
        idUtilisateur = 0
    End Sub

    Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
       Implements IValidatableObject.Validate
        'Liste d'erreurs(data annotations) outils validation

        Dim listeRetour = New List(Of ValidationResult)

        Return listeRetour
    End Function
End Class

Partial Public Class InfoGeneraleValidation

    <DisplayName("courrielFormulaire"), _
    Required(ErrorMessage:="Le courriel de l'administrateur est requis|The administrator's email is required"), _
    RegularExpression("^(\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3})$", ErrorMessage:="L'adresse courriel doit être valide!|The email must be valid!")> _
    Public Property courrielFormulaire As String

    <DisplayName("penseeFR"), _
    Required(ErrorMessage:="La pensée en français ne doit pas être vide|The french thought can't be empty")>
    Public Property penseeFR As String

    <DisplayName("penseeEN"), _
    Required(ErrorMessage:="La pensée en anglais ne doit pas être vide|The english thought can't be empty")>
    Public Property penseeEN As String

    <DisplayName("historiqueFR"), _
    Required(ErrorMessage:="L'historique en français ne doit pas être vide|The french history area can't be empty")>
    Public Property historiqueFR As String

    <DisplayName("historiqueEN"), _
    Required(ErrorMessage:="L'historique en anglais ne doit pas être vide|The english history area can't be empty")>
    Public Property historiqueEN As String

    <DisplayName("maltraitanceFR"), _
    Required(ErrorMessage:="La maltraitance en français ne doit pas être vide|The french elder abuse area can't be empty")>
    Public Property maltraitanceFR As String

    <DisplayName("maltraitanceEN"), _
    Required(ErrorMessage:="La maltraitance en anglais ne doit pas être vide|The english elder abuse area can't be empty")>
    Public Property maltraitanceEN As String

    <DisplayName("temoignageFR"), _
    Required(ErrorMessage:="Le témoignage en français ne doit pas être vide|The french testimony can't be empty")>
    Public Property temoignageFR As String

    <DisplayName("temoignageEN"), _
    Required(ErrorMessage:="Le témoignage en anglais ne doit pas être vide|The english testimony can't be empty")>
    Public Property temoignageEN As String


End Class
