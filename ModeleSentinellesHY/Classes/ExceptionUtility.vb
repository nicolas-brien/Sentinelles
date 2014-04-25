'Classe intéressante servant au log des erreurs.

Imports System
Imports System.IO
Imports System.IO.Compression
Imports System.Web

' Create our own utility for exceptions
Public NotInheritable Class ExceptionUtility

    ' All methods are static, so this can be private
    Private Sub New()
        MyBase.New()
    End Sub

    'Fonction partagée qui effectue le log des erreurs dans un fichier en ordre chronologique
    'de l'erreur la plus récente à l'erreur la plus vieille
    Public Shared Sub LogException(ByVal exc As Exception, ByVal source As String)
        ' Include enterprise logic for logging exceptions
        ' Get the absolute path to the log file
        Dim logFile = "~/Log/ErrorLog.txt"
        logFile = HttpContext.Current.Server.MapPath(logFile)

        'Construit le message d'erreur
        Dim newError = String.Empty
        newError += "**** " & DateTime.Now & " ****"

        If exc.InnerException IsNot Nothing Then
            newError += "Inner Exception Type: "
            newError += exc.InnerException.GetType.ToString() & "\n"
            newError += "Inner Exception: "
            newError += exc.InnerException.Message & "\n"
            newError += "Inner Source: "
            newError += exc.InnerException.Source & "\n"
            If exc.InnerException.StackTrace IsNot Nothing Then
                newError += "Inner Stack Trace: "
                newError += exc.InnerException.StackTrace & "\n"
            End If
        End If
        newError += "Exception Type: "
        newError += exc.GetType.ToString() + "\n"
        newError += "Exception: " & exc.Message & "\n"
        newError += "Source: " & source & "\n"
        If exc.StackTrace IsNot Nothing Then
            newError += "Stack Trace: " & exc.StackTrace & "\n"
        End If
        newError += "*******************************************"

        'Vérifie si le fichier log existe, sinon le créer
        If Not File.Exists(logFile) Then
            File.Create(logFile).Dispose()
        End If

        Dim logText = String.Empty
        If File.Exists(logFile) Then
            'Va chercher le stream du fichier
            Dim stream = New FileStream(logFile, FileMode.Append, FileAccess.ReadWrite)
            Dim gzip = New GZipStream(stream, CompressionMode.Compress)

            'Ajoute le nouveau message au avant la lecture du fichier
            Dim reader = New StreamReader(logFile, True)
            logText += newError & "\n"
            logText += reader.ReadToEnd()

            'Efface le fichier
            System.IO.File.WriteAllText(@logFile,string.Empty)

            'Réempli le fichier log
            Dim objTempWriter = New StreamWriter(gzip)
            objTempWriter.Write(logText)
            objTempWriter.Close()
        End If
    End Sub

    ' Notify System Operators about an exception
    Public Shared Sub NotifySystemOps(ByVal exc As Exception)
        ' Include code for notifying IT system operators
    End Sub
End Class