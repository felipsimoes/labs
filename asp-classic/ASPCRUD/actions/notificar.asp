<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<%
Dim id
id = Request.QueryString("id")

if id = "" then
	Response.Redirect "../listagem.asp?e=41"
else 
	Dim sql, email
	'Realiza busca pelo id
	sql = "SELECT nm_email FROM tb_cadastro WHERE cd_id = " & id
	Set resul = buscarSQL(sql)
	'Caso tenha retorno positivo
	if resul.RecordCount > 0 then
		do until resul.EOF
			'Iteracao por campo'
			for each field in resul.Fields 
				email = field.value
			next
			resul.MoveNext
		loop
		copia = "felipe.lima@kbrtec.com.br"
		status = EnviarEmail("felipe.lima@kbrtec.com.br", "Notificação", email, copia, "Notificando usuário", "Você está sendo notificado.")

		Response.Redirect "../listagem.asp?e=42"

	end if
end if
%>