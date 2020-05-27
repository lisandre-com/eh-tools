'------------------------------------------------------------------------------
' Description : Script to connect to a Microsoft SQL Server database and run queries.
' Author      : Lisandre.com
' Date        : 2019-02-12
'------------------------------------------------------------------------------
Option Explicit

Dim strQuery
Dim strColumns
Dim strResults
Dim rs
Dim cn
Dim i
Dim rowNum
Dim Field
Dim strDBServer
Dim strDBName
Dim strUsername
Dim strPassword

' DB connection information
strDBServer = "server\instance"
strDBName   = "dbname"
'strUsername = "username"
'strPassword = InputBox("User password:",,"")

' Establish database connection
Set cn = CreateObject("ADODB.Connection")
'cn.Open "PROVIDER=SQLOLEDB;SERVER=" & strDBServer & ";DATABASE=" & strDBName & ";", strUsername, strPassword

' Connect with Windows NT security
cn.Open "PROVIDER=SQLOLEDB;SERVER=" & strDBServer & ";DATABASE=" & strDBName & ";integrated security=SSPI"

' Open a file to write results
Dim objFSO
Dim objFile
Set objFSO=CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile("C:\query.log",True)

' Run queries until the Cancel button is pressed
Do 
    strResults = ""
    strColumns = ""
    strQuery = InputBox("Query",,"")
    Set rs = cn.Execute(strQuery)
    rowNum = 0
    
    If strQuery <> "" Then
        ' Loop through the query results and display them, if it's a SELECT statement
        If rs.State <> 0 And Not(rs Is Nothing) Then
            While Not rs.EOF
                i = 0
                For Each Field In rs.Fields
                    If rowNum = 0 Then
                        strColumns = strColumns & rs.Fields(i).Name & vbTab
                    End if
                    
                    strResults = strResults & rs.Fields(i).Value & vbTab
                    i = i + 1
                Next
                strResults = strResults & Chr(13) & Chr(10)
            
                rowNum = rowNum + 1
                rs.MoveNext
            Wend
        End If
    End If

    ' Write results to file
    'WScript.Echo strQuery &  Chr(13) & Chr(10) & strColumns & Chr(13) & Chr(10) & strResults & vbCrLf
    objFile.Write strQuery &  Chr(13) & Chr(10) & strColumns & Chr(13) & Chr(10) & strResults & vbCrLf
    
    rs.Close
    Set rs = Nothing
Loop Until strQuery = ""

' Close file and DB connection
objFile.Close
cn.Close
Set objFile = Nothing
Set cn = Nothing
