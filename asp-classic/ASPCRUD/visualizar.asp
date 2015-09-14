<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<!-- #include file="sys/configPath.asp" -->
<%
Dim id
id = Request.QueryString("id")

if id = "" then
	Response.Write "Sem usuario"
else 
	'Realiza busca pelo id
	sql = "SELECT nm_nome, nm_email, dt_nascimento, nm_url_foto FROM tb_cadastro WHERE cd_id = " & id
	On Error Resume Next
	Set resul = buscarSQL(sql)
	'Caso tenha retorno positivo
	if resul.RecordCount > 0 then

%>

<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Visualização</title>
<head>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<style type="text/css">
		#foto_usuario {
			width: 30%;
		}
	</style>
</head>
<body>
	<!-- #include file="includes/menu.asp" -->	
<h2>Dados do usuário:</h2>
<%
		'Iteracao por linha de resultado
		do until resul.EOF
			'Iteracao por campo'
			for each field in resul.Fields 
				SELECT case field.name
					Case "nm_nome"
						Response.Write "Nome: " & field.value & "<br>"
					Case "nm_email"
						Response.Write "Email: " & field.value & "<br>"
					Case "dt_nascimento"
						Response.Write "Data de Nascimento: " & field.value & "<br>"
					Case "nm_url_foto"
						if field.value <> "" then
							Response.Write "<img src='files/images/usuarios/" & id & "/" & field.value & "' id='foto_usuario'><br>"
							Response.Write "<img src='files/images/usuarios/" & id & "/thumb/" & field.value & "' id='foto_thumb_usuario'><br>"
						else 
							Response.Write "Usuario sem foto"
						end if
				END SELECT
			next
			resul.MoveNext
		loop
			
	else 
		Response.Write "Usuário inexistente"
	end if
	If Err.Number <> 0 Then
		Response.Write "Problema de busca dos dados"
	End If
	On Error GoTo 0
end if

%>
</body>
</html>