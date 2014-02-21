'Classe intéressante servant au log des erreurs.

Imports System
Imports System.IO
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
        Dim logFile = "~/Upload/ErrorLog.txt"
        Dim logTemp = "~/Upload/ErrorTemp.txt"
        logFile = HttpContext.Current.Server.MapPath(logFile)
        logTemp = HttpContext.Current.Server.MapPath(logTemp)

        Dim objTempEmptyWriter = New StreamWriter(logTemp) 'Not appending to clear last tempory list of entries 
        objTempEmptyWriter.WriteLine("**** " & DateTime.Now & " ****")
        If exc.InnerException IsNot Nothing Then
            objTempEmptyWriter.Write("Inner Exception Type: ")
            objTempEmptyWriter.WriteLine(exc.InnerException.GetType.ToString)
            objTempEmptyWriter.Write("Inner Exception: ")
            objTempEmptyWriter.WriteLine(exc.InnerException.Message)
            objTempEmptyWriter.Write("Inner Source: ")
            objTempEmptyWriter.WriteLine(exc.InnerException.Source)
            If exc.InnerException.StackTrace IsNot Nothing Then
                objTempEmptyWriter.WriteLine("Inner Stack Trace: ")
                objTempEmptyWriter.WriteLine(exc.InnerException.StackTrace)
            End If
        End If
        objTempEmptyWriter.Write("Exception Type: ")
        objTempEmptyWriter.WriteLine(exc.GetType.ToString)
        objTempEmptyWriter.WriteLine("Exception: " & exc.Message)
        objTempEmptyWriter.WriteLine("Source: " & source)
        If exc.StackTrace IsNot Nothing Then
            objTempEmptyWriter.WriteLine("Stack Trace: ")
            objTempEmptyWriter.WriteLine(exc.StackTrace)
        End If
        objTempEmptyWriter.WriteLine("")
        objTempEmptyWriter.WriteLine("")
        objTempEmptyWriter.Close()

        Dim objWriter As New System.IO.StreamWriter(logFile)
        objWriter.Close()

        Dim objTempWriter = New StreamWriter(logTemp, True) 'Appening to add the current entries to this tempory list
        Dim objReader = New StreamReader(logFile, True)
        objTempWriter.Write(objReader.ReadToEnd) 'Write to stop excess empty lines at end of file
        objTempWriter.Close()
        objReader.Close()
        Dim objTempReader As New System.IO.StreamReader(logTemp, True)
        Dim objWriter2 As New System.IO.StreamWriter(logFile)
        objWriter2.Write(objTempReader.ReadToEnd)
        objTempReader.Close()
        objWriter2.Close()
        System.IO.File.Delete(logTemp)
    End Sub

    ' Notify System Operators about an exception
    Public Shared Sub NotifySystemOps(ByVal exc As Exception)
        ' Include code for notifying IT system operators
    End Sub
End Class