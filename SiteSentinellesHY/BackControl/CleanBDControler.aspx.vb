Imports System.IO

Public Class CleanBDControler
    Inherits System.Web.UI.Page

    'Il faut avoir le bon path de backups pour que cela fonctionne
    'TODO: Le dossiers backups sur le serveur est avant la racine, donc faut voir comment l'atteindre.
    Public backPath As String = "/backups"
    Public fileMax As Integer = 14
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim user As String = Request.QueryString("user")
        Dim pass As String = Request.QueryString("pass")

        If (user.Equals("cleanBD") And pass.Equals("WrT185!r")) Then
            DataLog.Text = "LOG SUCCES<br />"
            If Directory.Exists(Server.MapPath(backPath)) Then
                Dim di As New IO.DirectoryInfo(Server.MapPath(backPath))
                Dim files As IO.FileInfo() = di.GetFiles()

                Dim count As Integer = 0

                Dim fileCount As Integer = files.Length
                Dim nbrFileToDelete As Integer = fileCount - fileMax

                DataLog.Text += "Fichier effacé: <br />"
                For Each file As FileInfo In files
                    If nbrFileToDelete > 0 Then
                        If count < nbrFileToDelete Then
                            file.Delete()
                            DataLog.Text += file.Name & "<br />"
                        End If
                    End If
                    count = count + 1
                Next
            End If
        End If
    End Sub

End Class
