'Classe contenant les outils utilisés dans toute l'application.
'LeContexte, ValidationFormulaire, ValidationUtilisateur, 
'obtenirLangue, encryptage, SecureRandom, SupprimerFichierUpload,
'FindChildControls, VerifierMotDePasse


Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel
Imports System.Threading
Imports System.Web
Imports System.Web.UI
Imports System.Security.Cryptography
Imports System.Text
Imports System.IO

Public Class outils
    'Fonction partagée qui crée et utilise le contexte de la base de donnée
    Public Shared Function leContexte() As ModeleSentinellesHY.model_sentinelleshyContainer
        Static ctxtLeContexte As ModeleSentinellesHY.model_sentinelleshyContainer = Nothing
        If ctxtLeContexte Is Nothing Then
            ctxtLeContexte = New ModeleSentinellesHY.model_sentinelleshyContainer
        End If

        Return ctxtLeContexte
    End Function

    'Fonction qui sert à valider un formulaire avec son type de validation, son contenant
    'ainsi que la liste d'erreur
    Public Shared Function validationFormulaire(ByRef formulaireAValider As Object, _
                                                ByRef typeValidation As Object, _
                                                ByRef contenant As Control, _
                                                ByRef listeErreur As List(Of clsErreur)) As Boolean

        Dim valide As Boolean = True

        Dim descriptionProvider As New AssociatedMetadataTypeTypeDescriptionProvider(formulaireAValider.GetType, typeValidation.GetType)
        TypeDescriptor.AddProviderTransparent(descriptionProvider, formulaireAValider.GetType)

        Dim ctxt = New ValidationContext(formulaireAValider, Nothing, Nothing)
        Dim results = New List(Of ValidationResult)
        Validator.TryValidateObject(formulaireAValider, ctxt, results, True)

        'Parcours les résultats de validation et les ajoute à la liste sortante d'erreur en type classe erreur
        If results.Count > 0 Then
            For Each uneErreur As ValidationResult In results
                listeErreur.Add(New clsErreur With {.contenant = contenant, .nomPropriete = uneErreur.MemberNames(0), .errorMessage = obtenirLangue(uneErreur.ErrorMessage)})
            Next
            valide = False
        End If
        Return valide
    End Function

    'Fonction qui sert à valider un utilisateur avec son type de validation, son contenant
    'ainsi que la liste d'erreur
    Public Shared Function validationUtilisateur(ByRef utilisateurAValider As Object, _
                                            ByRef typeValidation As Object, _
                                            ByRef contenant As Control, _
                                            ByRef listeErreur As List(Of clsErreur)) As Boolean

        Dim valide As Boolean = True

        Dim descriptionProvider As New AssociatedMetadataTypeTypeDescriptionProvider(utilisateurAValider.GetType, typeValidation.GetType)
        TypeDescriptor.AddProviderTransparent(descriptionProvider, utilisateurAValider.GetType)

        Dim ctxt = New ValidationContext(utilisateurAValider, Nothing, Nothing)

        'On effectue les deux types de validation dans deux listes différentes et on enlève ensuite les doublons
        Dim results1 = New List(Of ValidationResult)
        Validator.TryValidateObject(utilisateurAValider, ctxt, results1, True)
        Dim results2 = New List(Of ValidationResult)
        results2 = utilisateurAValider.Validate(ctxt)

        Dim i
        Dim j
        For i = 0 To results1.Count - 1
            For j = 0 To results2.Count - 1
                If results2.Item(j).ErrorMessage.Equals(results1.Item(i).ErrorMessage) Then
                    results2.RemoveAt(j)
                End If
            Next j
        Next i

        results1.AddRange(results2)

        'Parcours les résultats de validation et les ajoute à la liste sortante d'erreur en type classe erreur
        If results1.Count > 0 Then
            For Each uneErreur As ValidationResult In results1
                listeErreur.Add(New clsErreur With {.contenant = contenant, .nomPropriete = uneErreur.MemberNames(0), .errorMessage = obtenirLangue(uneErreur.ErrorMessage)})
            Next
            valide = False
        End If
        Return valide
    End Function

    'Fonction servant à séparer un string contenant les deux langues afin de retourner que la bonne langue
    Public Shared Function obtenirLangue(ByVal sender As String) As String
        Dim deuxLangues() = sender.Split("|")

        If Thread.CurrentThread.CurrentCulture.EnglishName.ToString.Contains("English") Then
            Return deuxLangues.Last
        Else
            Return deuxLangues.First
        End If

    End Function

    'Fonction qui encrypte le mot de passe afin de le stocké dans la BD et qui le retourne
    Public Shared Function encryptage(ByRef motDePassePlusSel As String) As String
        Dim sha256 As SHA256 = SHA256Managed.Create()

        Dim bytes As Byte() = sha256.ComputeHash(Encoding.UTF8.GetBytes(motDePassePlusSel))

        Dim resultat As String = Convert.ToBase64String(bytes)

        Return resultat
    End Function

    'Fonction qui sert à générer notre SelDeMer pour l'ajouter au mot de passe avant de l'encrypter
    Public Shared Function SecureRandom(quantity) As String

        Dim validchars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

        Dim sb As New StringBuilder()
        Dim rand As New Random()
        For i As Integer = 1 To quantity
            Dim idx As Integer = rand.Next(0, validchars.Length)
            Dim randomChar As Char = validchars(idx)
            sb.Append(randomChar)
        Next i

        Return sb.ToString
    End Function

    'Fonction qui supprime un fichier
    Public Shared Function SupprimerFichierUpload(ByVal fichierADelete As String) As Boolean
        Dim path = HttpContext.Current.Server.MapPath("../Upload/" & fichierADelete)
        System.IO.File.Delete(path)
        Return True
    End Function

    'Fonction qui cherche de manière récursive le controle du type désiré avec le ID désiré
    Public Shared Function FindChildControls(Of T As Control)(ByVal startingControl As Control, ByVal id As String) As T
        Dim found As T = Nothing
        For Each activeControl As Control In startingControl.Controls
            found = TryCast(activeControl, T)
            If found Is Nothing OrElse (String.Compare(id, found.ID, True) <> 0) Then
                found = FindChildControls(Of T)(activeControl, id)
            End If
            If found IsNot Nothing Then
                Exit For
            End If
        Next
        Return found
    End Function

    'Fonction qui sert à vérifier le mot de passe de l'usager lors de son authentification
    Public Shared Function VerifierMotDePasse(unUtilisateur As ModeleSentinellesHY.Utilisateur, motDePasseUtilisateur As String) As Boolean
        Dim hash As String = encryptage(motDePasseUtilisateur & unUtilisateur.SelDeMer)

        If unUtilisateur.motDePasse.Equals(hash) Then
            Return True
        End If

        Return False
    End Function
End Class
