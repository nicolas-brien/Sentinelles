Public Class FRMPageErreur
    Inherits System.Web.UI.Page
    Public errorMessage As String

    'Comme c'est la page d'erreur, on traite ici à peu près toutes les erreurs possibles d'obtenir au niveau de la page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' Create safe error messages.
        Dim generalErrorMsg As String = ModeleSentinellesHY.outils.obtenirLangue("Un problème s'est produit. Si l'erreur persiste, contacter le support.|A problem has occurred on this web site. Please try again. If this error continues, please contact support.")
        Dim httpErrorMsg As String = ModeleSentinellesHY.outils.obtenirLangue("Une erreur HTTP s'est produite. Veuillez réessayez.|An HTTP error occurred. Page Not found. Please try again.")
        Dim unhandledErrorMsg As String = ModeleSentinellesHY.outils.obtenirLangue("L'erreur n'a pas été gérée par le code de l'application.|The error was unhandled by application code.")

        ' Display safe error message.
        FriendlyErrorMsg.Text = generalErrorMsg

        ' Determine where error was handled.
        Dim errorHandler__1 As String = Request.QueryString("handler")
        If errorHandler__1 Is Nothing Then
            errorHandler__1 = "Error Page"
        End If

        ' Get the last error from the server.
        Dim ex As Exception = Server.GetLastError()

        ' Get the error number passed as a querystring value.
        Dim errorMsg As String = Request.QueryString("msg")
        If errorMsg = "404" Then
            ex = New HttpException(404, httpErrorMsg, ex)
            FriendlyErrorMsg.Text = ex.Message
        End If

        ' If the exception no longer exists, create a generic exception.
        If ex Is Nothing Then
            ex = New Exception(unhandledErrorMsg)
            FriendlyErrorMsg.Text = ex.Message
        End If

        errorMessage = ""

        If ex.InnerException IsNot Nothing Then
            errorMessage += "Inner Exception Type: " & ex.InnerException.GetType.ToString & vbCrLf
            errorMessage += "Inner Exception: " & ex.InnerException.Message & vbCrLf
            errorMessage += "Inner Source: " & ex.InnerException.Source & vbCrLf
            If ex.InnerException.StackTrace IsNot Nothing Then
                errorMessage += "Inner Stack Trace: " & ex.InnerException.StackTrace & vbCrLf
            End If
        End If
        errorMessage += "Exception Type: " & ex.GetType.ToString & vbCrLf
        errorMessage += "Exception: " & ex.Message & vbCrLf
        If Not ex.TargetSite Is Nothing Then
            errorMessage += "Source: " & ex.TargetSite.ReflectedType.ToString() & vbCrLf
        End If

        If ex.StackTrace IsNot Nothing Then
            errorMessage += "Stack Trace: " & ex.StackTrace & vbCrLf
        End If

        ' Log the exception.
        ModeleSentinellesHY.ExceptionUtility.LogException(ex, errorHandler__1)

        ' Clear the error from the server.
        Server.ClearError()
    End Sub
End Class