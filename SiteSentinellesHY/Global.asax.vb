﻿Imports System.Web.SessionState
Imports System.Globalization
Imports System.Threading

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Se déclenche lorsque l'application est démarrée
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Se déclenche lorsque la session est démarrée
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        Dim aCookie As HttpCookie = Request.Cookies("SentinellesHY")
        Dim langue As String = "FR"
        If aCookie IsNot Nothing Then
            langue = aCookie.Values("langue")
        End If
        Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo(langue & "-ca")
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(langue & "-ca")




    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Se déclenche lors d'une tentative d'authentification de l'utilisation
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        Dim exc As Exception = Server.GetLastError
        Dim unType = exc.GetType

        'Gestion d'erreur au niveau de l'application qui retourne de l'information à la page d'erreur
        If TypeOf exc Is HttpCompileException Then
            ModeleSentinellesHY.ExceptionUtility.LogException(exc, "BaseDeDonnée")
        End If

        If TypeOf exc Is HttpUnhandledException Then
            If Not exc.InnerException Is Nothing Then
                exc = New Exception(exc.InnerException.Message)
            End If
        End If
        Server.Transfer("FRMPageErreur.aspx?handler=Application_Error%20-%20Global.asax", True)
        Server.ClearError()
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Se déclenche lorsque la session se termine
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Se déclenche lorsque l'application se termine
    End Sub

End Class