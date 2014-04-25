Imports System.IO
Imports System.Net.Mail
Imports ModeleSentinellesHY

Public Class EmailSendRoutine
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim user = Request.QueryString("user")
        Dim pass = Request.QueryString("pass")

        Dim isMailSending As Boolean = False
        Dim isFileEmpty As Boolean = False
        Dim isSendDone As Boolean = False
        Dim isRoutineDone As Boolean = False
        Dim folder As String = ""
        Dim filename As String = "emailsending.txt"

        Dim filePropertiesName As String = "properties.txt"
        Dim fileMail As String = "mailmsg.txt"
        Dim maxEmailSend As Integer = 50

        Dim mailList As List(Of Utilisateur) = New List(Of Utilisateur)

        Dim lastEmail As String = String.Empty

        Dim lastID As Integer = 0

        If user.Equals("cleanBD") And pass.Equals("WrT185!r") Then
            Try
                If File.Exists(Server.MapPath(folder + filePropertiesName)) Then
                    Using sr As New StreamReader(Server.MapPath(folder + filePropertiesName))
                        Dim line As String
                        line = sr.ReadToEnd()
                        Dim tok = line.Split("=")
                        If tok(0).Equals("EmailSend") Then
                            isMailSending = Convert.ToBoolean(tok(1))
                        End If
                    End Using

                Else
                    isMailSending = False
                End If
            Catch ex As Exception

            End Try

            If isMailSending Then
                Try
                    If Not File.Exists(Server.MapPath(folder + filename)) Then
                        isFileEmpty = True

                        Using fs As FileStream = File.Create(Server.MapPath(folder + filename))
                            Dim info As [Byte]() = New UTF8Encoding(True).GetBytes("[BEGIN]")
                            fs.Write(info, 0, info.Length)
                        End Using
                    End If

                    If File.Exists(Server.MapPath(folder + filename)) Then
                        If isFileEmpty Then
                            mailList = New List(Of Utilisateur)
                            mailList = (
                                From m In leContexte.UtilisateurJeu
                                Select m
                            ).ToList()
                        End If

                        Using sr As New StreamReader(Server.MapPath(folder + filename))
                            Dim s As String = sr.ReadLine
                            If s.Equals("[DONE]") Then
                                isSendDone = True

                                If File.Exists(Server.MapPath(folder + filePropertiesName)) Then
                                    File.Delete(Server.MapPath(folder + filePropertiesName))
                                End If

                                Using fs As FileStream = File.Create(Server.MapPath(folder + filePropertiesName))
                                    Dim info As [Byte]() = New UTF8Encoding(True).GetBytes("EmailSend=false")
                                    fs.Write(info, 0, info.Length)
                                End Using
                            Else
                                If Not isFileEmpty Then
                                    mailList = New List(Of Utilisateur)
                                    Dim id As Integer = 0
                                    If Integer.TryParse(s.Trim(), id) Then
                                        mailList = (
                                        From m In leContexte.UtilisateurJeu
                                        Where m.idUtilisateur > Integer.Parse(id)
                                        Select m
                                    ).ToList()
                                    End If
                                    
                                End If

                                Dim count As Integer = 0
                                Dim listLength = mailList.Count
                                For Each item In mailList
                                    If Not isRoutineDone Then
                                        If count = maxEmailSend Or count = listLength - 1 Then
                                            If count < maxEmailSend Then
                                                lastEmail = "[DONE]"
                                                If File.Exists(Server.MapPath(folder + filePropertiesName)) Then
                                                    File.Delete(Server.MapPath(folder + filePropertiesName))
                                                End If

                                                Using fs As FileStream = File.Create(Server.MapPath(folder + filePropertiesName))
                                                    Dim info As [Byte]() = New UTF8Encoding(True).GetBytes("EmailSend=false")
                                                    fs.Write(info, 0, info.Length)
                                                End Using
                                            Else
                                                lastEmail = item.courriel
                                            End If

                                            lastID = item.idUtilisateur
                                            isRoutineDone = True
                                        End If

                                        Try
                                            Dim subject As String = String.Empty
                                            Dim message As String = String.Empty

                                            If File.Exists(Server.MapPath(folder + fileMail)) Then
                                                Dim countLine As Integer = 0
                                                Using srM As New StreamReader(Server.MapPath(folder + fileMail))
                                                    Do While srM.Peek <> -1
                                                        Dim line As String
                                                        line = srM.ReadLine()

                                                        Dim tok = line.Split("=")
                                                        If countLine = 0 Then
                                                            subject = tok(1)
                                                        Else
                                                            message = tok(1)
                                                        End If
                                                        countLine = countLine + 1
                                                    Loop
                                                End Using
                                            End If
                                            Dim mail As New MailMessage
                                            mail.Subject = subject
                                            mail.From = New MailAddress("info@sentinelleshy.ca")
                                            mail.To.Add(item.courriel)
                                            mail.Body = message
                                            mail.BodyEncoding = System.Text.Encoding.UTF8
                                            mail.IsBodyHtml = True

                                            Dim client As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()
                                            client.Credentials = New System.Net.NetworkCredential("info@sentinelleshy.ca", "Vs2H7!Etu")
                                            client.Timeout = 1000
                                            client.Port = 25
                                            client.Host = "mail.sentinelleshy.ca"
                                            'client.EnableSsl = True 'Gmail Secured Layer

                                            client.Send(mail)
                                            Response.Write(item.courriel & "<br/>")
                                        Catch ex As Exception
                                            Using fs As FileStream = File.Create(Server.MapPath(folder + "log.txt"))
                                                Dim info As [Byte]()
                                                info = New UTF8Encoding(True).GetBytes(ex.Message)
                                                fs.Write(info, 0, info.Length)
                                            End Using
                                        End Try
                                        count = count + 1
                                    End If

                                Next
                            End If
                        End Using
                        If Not isSendDone Then
                            If File.Exists(Server.MapPath(folder + filename)) Then
                                File.Delete(Server.MapPath(folder + filename))
                            End If

                            Using fs As FileStream = File.Create(Server.MapPath(folder + filename))
                                Dim info As [Byte]()
                                If lastEmail.Equals("[DONE]") Then
                                    info = New UTF8Encoding(True).GetBytes(lastEmail)
                                Else
                                    info = New UTF8Encoding(True).GetBytes(lastID.ToString())
                                End If
                                fs.Write(info, 0, info.Length)
                            End Using
                        Else
                            If File.Exists(Server.MapPath(folder + filename)) Then
                                File.Delete(Server.MapPath(folder + filename))
                            End If
                        End If
                    End If
                Catch ex As Exception
                    Using fs As FileStream = File.Create(Server.MapPath(folder + "log.txt"))
                        Dim st As StackTrace = New StackTrace(New StackFrame(True))
                        Dim sf As StackFrame = st.GetFrame(0)
                        Dim errors = "************************\nNom du fichier: " & sf.GetFileName & Environment.NewLine & "\nMéthode: " & sf.GetMethod().Name & Environment.NewLine & "\nLigne d'erreur: " & sf.GetFileLineNumber() & Environment.NewLine & "\nColonne en erreur: " & sf.GetFileColumnNumber & Environment.NewLine & ex.Message & "\n******************"
                        Dim info As [Byte]()
                        info = New UTF8Encoding(True).GetBytes(errors)
                        fs.Write(info, 0, info.Length)
                    End Using
                    Console.WriteLine(ex.Message)
                End Try
            End If
        End If

    End Sub

    Public Shared Function leContexte() As ModeleSentinellesHY.model_sentinelleshyContainer
        Static ctxtLeContexte As ModeleSentinellesHY.model_sentinelleshyContainer = Nothing
        If ctxtLeContexte Is Nothing Then
            ctxtLeContexte = New ModeleSentinellesHY.model_sentinelleshyContainer
        End If

        Return ctxtLeContexte
    End Function

End Class