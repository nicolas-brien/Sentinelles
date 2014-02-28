'Classe comportant toutes les propriétés des entités Publication ainsi qu'un constructeur vide. 

Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel
<MetadataType(GetType(PublicationValidation))> _
Partial Public Class Publication
    Implements IValidatableObject

    Public Sub New()
        idPublication = 1
        titre = ""
        epinglee = False
        consulteParIntervenant = False
        idUtilisateur = 1
        idParent = Nothing
        contenu = ""
        datePublication = Date.Now()
        idCategorie = 0
    End Sub
    Function Validate(ValidationContext As ValidationContext) As IEnumerable(Of ValidationResult) _
          Implements IValidatableObject.Validate
        'Liste d'erreurs(data annotations) outils validation
        Dim listeRetour = New List(Of ValidationResult)
        Return listeRetour
    End Function
End Class
Partial Public Class PublicationValidation
    <DisplayName("titre"), _
    Required(ErrorMessage:="Le titre est requis|The title is required"), _
    StringLength(75, ErrorMessage:="Le titre doit contenir moins de 75 caractères|The title must contain less than 75 characters")> _
    Public Property titre As String
    <DisplayName("contenu"), _
    Required(ErrorMessage:="Vous devez poser une question|You must ask a question")> _
    Public Property contenu As String
    <DisplayName("categorie"), _
    Required(ErrorMessage:="Vous devez choisir une catégorie|You must choose a category")> _
    Public Property idCategorie As String
End Class