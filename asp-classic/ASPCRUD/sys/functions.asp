<%
'Functions retornam valores

Function buscarSQL(byVal strSQL)
	On Error Resume Next
		'cria objeto de conexão
		Set conn = Server.CreateObject("ADODB.Connection") 

		conn.CursorLocation = 3
		'passa parametros para conectar ao banco
		conn.Open strConexao

		If Err.Number <> 0 Then
				response.write "<b><font color='red'> Conexão com o banco  falhou !</font></b>"
				response.write "<BR><BR>"
				response.write "<b>Erro.Description:</b> " & Err.Description & "<br>"
				response.write "<b>Erro.Number:</b> " & Err.Number & "<br>"
				response.write "<b>Erro.Source:</b> " & Err.Source & "<br>"
		End If

		'cria recordset para recuperar dados de uma query
		Set res = Server.CreateObject("ADODB.recordset")

		res.Open strSQL, conn, 3, 1

		res.ActiveConnection = Nothing
		'retorna o valor da funcao
		Set buscarSQL = res

		If Err.Number <> 0 Then
				response.write "<b><font color='red'> Busca da Query falhou !</font></b>"
				response.write "<BR><BR>"
				response.write "<b>Erro.Description:</b> " & Err.Description & "<br>"
				response.write "<b>Erro.Number:</b> " & Err.Number & "<br>"
				response.write "<b>Erro.Source:</b> " & Err.Source & "<br>"
		End If

		
	 	'fechar a conexao
		conn.Close
		'limpa o objeto da memória
		Set conn = Nothing
	On Error Goto 0	
End Function


Function CreUpSQL(byVal strSQL)
	On Error Resume Next
		'cria objeto de conexão
		Set conn = Server.CreateObject("ADODB.Connection") 

		conn.CursorLocation = 3
		'passa parametros para conectar ao banco
		conn.Open strConexao

		If Err.Number <> 0 Then
				response.write "<b><font color='red'> Conexão com o banco  falhou !</font></b>"
				response.write "<BR><BR>"
				response.write "<b>Erro.Description:</b> " & Err.Description & "<br>"
				response.write "<b>Erro.Number:</b> " & Err.Number & "<br>"
				response.write "<b>Erro.Source:</b> " & Err.Source & "<br>"
		End If

		'cria recordset para recuperar dados de uma query
		Set res = Server.CreateObject("ADODB.recordset")

		Set conn = conn.Execute(strSQL)

		'executa o comando sql
		res.Open strSQL, conn, 3 , 1

		res.ActiveConnection = Nothing

		'Verificando se a query foi executada'
			If res.EOF <> -1 Then
				CreUpSQL = true
			Else
				CreUpSQL = false
			End If

		conn.Close

		Set conn = Nothing
	On Error Goto 0
End Function

Function ExcluirSQL(byVal strSQL)
	On Error Resume Next
		'cria objeto de conexão
		Set conn = Server.CreateObject("ADODB.Connection") 

		conn.CursorLocation = 3
		'passa parametros para conectar ao banco
		conn.Open strConexao

		conn.Execute strSQL

		If Err.Number <> 0 Then
			ExcluirSQL = false
		Else 
			ExcluirSQL = true
		End If

		conn.Close

	On Error Goto 0
End Function

Function CriarDiretorio(path, diretorio)
	On Error Resume Next
		Dim objFS
        
        Set objFS = Server.CreateObject("Scripting.FileSystemObject")
        
        If Not objFS.FolderExists( path & diretorio)  Then
        	objFS.CreateFolder( path & diretorio )
        	CriarDiretorio = true
        Else
        	CriarDiretorio = false
        End If

        Set objFS = Nothing
	On Error Goto 0	
End Function

Function EnviarEmail(remetente, remetente_nome, destino, copia, assunto, corpo)
	On Error Resume Next

		Set Mail = Server.CreateObject("Persits.MailSender")

		Mail.Host = "smtp.kbrtec.com.br"
		Mail.Port = 587
		Mail.Username = "felipe.lima@kbrtec.com.br"
		Mail.Password = "felipe2015sl"
		Mail.From = remetente
		Mail.FromName = remetente_nome
		Mail.AddAddress destino
		Mail.AddBcc copia
		Mail.Subject = assunto
		Mail.Body = corpo
		Mail.IsHTML = True
		Mail.Send

		If err <> 0 Then
			EnviarEmail = false
			Set Mail = Nothing
		Else
			EnviarEmail = true
			Set Mail = Nothing
		End If
	On Error Goto 0
End Function

Function ConvertInputDateTime(varDateTime)

	If (Len(Trim(varDateTime)) > 0) Then
		DateTimeArray=Split(CStr(varDateTime)," ")

		varDate = DateTimeArray(0)


		If (Len(Trim(varDate)) > 0) Then
			DateArray=Split(CStr(varDate),"/")

			IF Len(Trim(DateArray(0))) < 2 Then
				DateArray(0) = "0" & DateArray(0)
			End If

			If Len(Trim(DateArray(1))) < 2 Then
				DateArray(1) = "0" & DateArray(1)
			End If

			If Len(Trim(DateArray(2))) < 4 Then 
				DateArray(2) = "20" & DateArray(2)
			End If

			varDate = DateArray(2) & "-" & DateArray(1) & "-" & DateArray(0)

		End If

	varDateTime = varDate

	End If

	ConvertInputDateTime = varDateTime

End Function

Function validaEmail(ByVal strEmail)
		Dim regEx
		Dim ResultadoHum
		Dim ResultadoDois 
		Dim ResultadoTres
		Set regEx = New RegExp          
		regEx.IgnoreCase = True        
		regEx.Global = True             
		
		regEx.Pattern	= "[^@\-\.\w]|^[_@\.\-]|[@\.]{2}|(@)[^@]*\1"
		ResultadoHum	= RegEx.Test(strEmail)
		
		regEx.Pattern	= "@[\w\-]+\."        
		ResultadoDois	= RegEx.Test(strEmail)
		
		regEx.Pattern	= "\.[a-zA-Z]{2,3}$"  
		ResultadoTres	= RegEx.Test(strEmail)
		Set regEx = Nothing
		
		If Not (ResultadoHum) And ResultadoDois And ResultadoTres Then
			validaEmail = True
		Else
			validaEmail = False
		End If
End Function

Function validaData(strData)
		Dim regEx
		Dim Resultado
		Set regEx = New RegExp          
		regEx.IgnoreCase = True        
		regEx.Global = True             
		
		regEx.Pattern	= "(^(((0[1-9]|[12][0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)"
		Resultado = regEx.Test(strData)
		
		Set regEx = Nothing
		
		If Resultado = true Then
			validaData = True
		Else
			validaData = False
		End If
End Function

Function FormataData(Data, tipo)
	If Data <> "" Then 
	
		Select Case tipo
			Case 1 'CONVERTE DD/MM/YYYY PARA YYYY/MM/DD'
				FormataData = DatePart("yyyy", Data) &  "-" & Right("0" & DatePart("m", Data),2) & "-" &  Right("0" & DatePart("d", Data),2)
			Case 2 'CONVERTE YYYY-MM-DD PARA DD/MM/YYYY'
				FormataData = Right("0" & DatePart("d", Data),2) & "/" & Right("0" & DatePart("m", Data),2) & "/" & DatePart("yyyy", Data)
		End Select
   	end if

End Function

Function ConvertInputDate(varDate)

	If (Len(Trim(varDate)) > 0) Then
		DateArray=Split(CStr(varDate),"/")

		If Len(Trim(DateArray(0))) < 2 Then
			DateArray(0) = "0" & DateArray(0)
		End If

		If Len(Trim(DateArray(1))) < 2 Then
			DateArray(1) = "0" & DateArray(1)
		End If

		If Len(Trim(DateArray(2))) < 4 Then 
			DateArray(2) = "20" & DateArray(2)
		End If
	End If

	varDate = DateArray(2) & "-" & DateArray(1) & "-" & DateArray(0)

	ConvertInputDate = varDate

End Function

%>