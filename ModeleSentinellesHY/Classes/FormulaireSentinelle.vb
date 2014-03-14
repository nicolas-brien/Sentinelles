'Classe utilisé pour le formulaire "Devenir Sentinelle"
'Elle contient les propriétés requises ainsi que les validations
'

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel
<MetadataType(GetType(UtilisateurValidation))> _
Public Class FormulaireSentinelle
    Implements IValidatableObject

    Public Property nom As String
    Public Property noTelephone As String
    Public Property courriel As String
    Public Property aPropos As String
    Public Sub New()
        nom = ""
        noTelephone = ""
        courriel = ""
        aPropos = ""
    End Sub
    Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
    Implements IValidatableObject.Validate
        Dim listeRetour = New List(Of ValidationResult)
        Return listeRetour
    End Function
End Class

'Validation de chacun des champs du formulaire
Public Class FormulaireSentinelleValidation

    <DisplayName("Nom d'utilisateur"), _
    Required(ErrorMessage:="Votre nom est requis.|Name is required."), _
    StringLength(50, ErrorMessage:="Votre nom doit contenir moins de 50 caractères.|Name must contains less than 50 characters.")> _
    Public Property nom As String

    <DisplayName("Téléphone"), _
    Required(ErrorMessage:="Le numéro de téléphone est requis.|Phone number is required."), _
    RegularExpression("\(?(\d{3})\)?-?(\d{3})-(\d{4})", ErrorMessage:="Votre numéro de téléphone doit être valide.|Your phone number must be valid.")> _
    Public Property noTelephone As String

    <DisplayName("Adresse courriel"), _
    RegularExpression("^(\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3})$", ErrorMessage:="Votre adresse courriel doit être valide.|Your email address must be valid.")> _
    Public Property courriel As String

    <DisplayName("À Propos"), _
    Required(ErrorMessage:="Veuillez remplir le champ 'À Propos'|The field 'More About You' must contains something."), _
    StringLength(500, ErrorMessage:="Le champ 'À Propos' doit contenir moins de 500 caractères.|The field 'More About You' must contains less than 500 characters.")>
    Public Property aPropos As String
End Class
