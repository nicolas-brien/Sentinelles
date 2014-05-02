'Classe comportant toutes les propriétés des entités Utilisateurs. Contient aussi de la validation dans
'la fonction Validate ainsi qu'un constructeur vide.

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel

<MetadataType(GetType(UtilisateurValidation))> _
Partial Public Class Utilisateur
    Implements IValidatableObject

    'Mot de passe du formulaire
    Private _motDePasseTemp As String
    Public Property motDePasseTemp
        Set(value)
            _motDePasseTemp = value
        End Set
        Get
            Return _motDePasseTemp
        End Get
    End Property

    'Confirmation du mot de passe du formulaire
    Private _confirmationMotDePasse As String
    Public Property confirmationMotDePasse
        Set(value)
            _confirmationMotDePasse = value
        End Set
        Get
            Return _confirmationMotDePasse
        End Get
    End Property

    'Propriété servant à vérifier si l'utilisateur à changer d'avatar et qu'il ne l'a pas encore sauvegarder
    'dans la méthode update de l'utilisateur
    Private _urlAvatarTemp As String
    Public Property urlAvatarTemp As String
        Get
            Return _urlAvatarTemp
        End Get
        Set(value As String)
            _urlAvatarTemp = value
        End Set
    End Property
    Public Sub New()
        SelDeMer = ""
        UrlAvatar = "default.png"
        motDePasse = ""
        nom = ""
        prenom = ""
        nomUtilisateur = ""
        courriel = ""
        noTelephone = ""
        sexe = "F"
        milieu = ""
        idStatut = 2
        dateInscription = Date.Now.Date
    End Sub

    'La fonction validate contient plusieurs validations pour les mots de passes.
    Public Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
    Implements IValidatableObject.Validate
        Dim leContexte As New ModeleSentinellesHY.model_sentinelleshyContainer
        Dim listeRetour = New List(Of ValidationResult)

        'Si le mot de passe du formulaire est nul et que mon mot de passe de la bd contient quelque chose, je suis en train de garder
        'mon mot de passe que j'avais déjà
        'Sinon, le mot de passe du formulaire est nul et doit contenir quelque chose
        'Sinon, le mot de passe du formulaire et la confirmation du mot de passe du formulaire doivent être identiques
        'Sinon, le mot de passe du formulaire doit contenir entre 6 et 16 caractères
        'À la suite de toutes ces vérifications, les mots de passe sont corrects.
        If Me.motDePasseTemp = "" AndAlso Me.motDePasse <> "" Then
            Me.motDePasse = leContexte.UtilisateurJeu.Find(Me.idUtilisateur).motDePasse
            Me.SelDeMer = leContexte.UtilisateurJeu.Find(Me.idUtilisateur).SelDeMer
        ElseIf Me.motDePasseTemp = "" Then
            listeRetour.Add(New ValidationResult("Le mot de passe ne doit pas être vide|The password can't be empty"))
        ElseIf Me.motDePasseTemp <> Me.confirmationMotDePasse Then
            listeRetour.Add(New ValidationResult("Les mots de passes doivent être identiques|The passwords must be the same"))
        ElseIf Me.motDePasseTemp.ToString.Count > 16 Or Me.motDePasseTemp.ToString.Count < 6 Then
            listeRetour.Add(New ValidationResult("Le mot de passe doit contenir entre 6 et 16 caractères|The password must contains between 6 and 16 characters"))
        Else
            Me.SelDeMer = ModeleSentinellesHY.outils.SecureRandom(3)
            Me.motDePasse = ModeleSentinellesHY.outils.encryptage(_motDePasseTemp & Me.SelDeMer)
        End If

        Return listeRetour
    End Function
End Class

Partial Public Class UtilisateurValidation

    <DisplayName("Nom d'utilisateur"), _
    Required(ErrorMessage:="Le nom d'utilisateur est requis|The username is required"), _
    StringLength(50, ErrorMessage:="Le nom d'utilisateur doit contenir moins de 50 caractères|The username must contains less than 50 characters")> _
    Public Property nomUtilisateur As String

    <DisplayName("Prénom"), _
    Required(ErrorMessage:="Le prénom est requis|The first name is required"), _
    StringLength(25, ErrorMessage:="Le prénom doit contenir moins de 25 caractères|The first name must contains less than 25 characters")> _
    Public Property prenom As String

    <DisplayName("Nom"), _
    Required(ErrorMessage:="Le nom est requis|The last name is required"), _
    StringLength(25, ErrorMessage:="Le nom doit contenir moins de 25 caractères|The last name must contains less than 25 characters")> _
    Public Property nom As String

    <DisplayName("Milieu"), _
    Required(ErrorMessage:="Le milieu est requis|The work place is required"), _
    StringLength(75, ErrorMessage:="Le milieu doit contenir moins de 75 caractères|The work place must contains less than 75 characters")> _
    Public Property milieu As String

    <DisplayName("Adresse courriel"), _
    RegularExpression("^(\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3})$", ErrorMessage:="L'adresse courriel doit être valide|The email must be valid"), _
    StringLength(100, ErrorMessage:="L'adresse courriel doit contenir moins de 100 caractères|The email must contains less than 100 characters")> _
    Public Property courriel As String

    <DisplayName("Téléphone"), _
    Required(ErrorMessage:="Le numéro de téléphone est requis|The phone number is required"), _
    RegularExpression("\(?(\d{3})\)?-?(\d{3})-(\d{4})", ErrorMessage:="Le numéro de téléphone doit être valide|The phone number must be valid")> _
    Public Property noTelephone As String

    <DisplayName("Mot de Passe")>
    Public Property motDePasse As String

End Class
