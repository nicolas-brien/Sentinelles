Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Configuration

Public Class DBControler

    Dim con As SqlConnection = New SqlConnection()
    Dim cmd As SqlCommand = New SqlCommand()
    Dim da As SqlDataAdapter = New SqlDataAdapter()

    Private conString = ""
    Public Sub New()
        conString = "Data Source=sqlinfo.cegepgranby.qc.ca;Initial Catalog=AreslambA2013;User ID=AreslambA2013;Password=AreslambA2013KWRY;"
        Dim today = Date.Now

        Try
            con = New SqlConnection(conString)
            'cmd = New SqlCommand("backup database AreslambA2013 to disk='\\server\path\filename.bak'", con)
            'cmd = New SqlCommand("restore database AreslambA2013 from disk='\\server\path\filename.bak'", con)
            con.Open()
            'Dim quey = cmd.ExecuteNonQuery()
        Catch ex As Exception
            Dim errTxt As String = ex.Message
        End Try
    End Sub

    Public Function CreateBackup(path As String, filename As String) As Boolean
        Try
            If (Not System.IO.Directory.Exists(path)) Then
                System.IO.Directory.CreateDirectory(path)
            End If

            cmd = New SqlCommand("backup database AreslambA2013 to disk='" & path & filename & "'", con)
            Dim query = cmd.ExecuteNonQuery()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

End Class
