'------------------------------------------------------------------------------
' <auto-generated>
'    Ce code a été généré à partir d'un modèle.
'
'    Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
'    Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class Publication
    Public Property idPublication As Integer
    Public Property titre As String
    Public Property datePublication As Date
    Public Property epinglee As Boolean
    Public Property consulteParIntervenant As Boolean
    Public Property idCategorie As Nullable(Of Integer)
    Public Property idUtilisateur As Nullable(Of Integer)
    Public Property idParent As Nullable(Of Integer)
    Public Property contenu As String

    Public Overridable Property Categorie As Categorie
    Public Overridable Property Utilisateur As Utilisateur

End Class
