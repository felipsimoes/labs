<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<%
	Dim e
	e = Request.QueryString("e")

	SELECT case e
		Case "41"
		Response.Write "Usuario nao identificado."
		Case "42"
		Response.Write "Usuario notificado."
	end SELECT
%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Listagem</title>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="js/actions.js"> </script>
    <style>
    table,td {
    	border: 1px solid black;
    	text-align: center;
    	margin-top: 30px;
    	margin-left: 20px;
    }
    </style>
</head>
<body>
<!-- #include file="includes/menu.asp" -->

<%

	sql = "SELECT nm_nome, cd_id FROM tb_cadastro"
	Set resul = buscarSQL(sql)
	if resul.RecordCount > 0 then
%>
	<h2>Listagem de usuários</h2>
	<table border="1" style="width:800px">
	<thead>
		<tr>
			<td>Nome</td>
			<td>Alterar</td>
			<td>Visualizar</td>
			<td>Excluir</td>
			<td>Notificar</td>
		</tr>
	</thead>
	<tbody>
	<% 
		do until resul.EOF
			Response.Write "<tr>"
			for each field in resul.Fields
				if field.name = "nm_nome" then
					Response.Write "<td>"
					Response.Write field.value
					Response.Write "</td>"
				elseif field.name = "cd_id" then
					Response.Write "<td>"
					Response.Write "<a href='alterar.asp?id="
					Response.Write field.value
					Response.Write "'> X </a>"
					Response.Write "</td>"
					Response.Write "<td>"
					Response.Write "<a href='visualizar.asp?id="
					Response.Write field.value
					Response.Write "'> X </a>"
					Response.Write "</td>"
					Response.Write "<td>"
					Response.Write "<a href='actions/excluir.asp?id="
					Response.Write field.value
					Response.Write "'> X </a>"
					Response.Write "</td>"
					Response.Write "<td>"
					Response.Write "<a href='actions/notificar.asp?id="
					Response.Write field.value
					Response.Write "'> X </a>"
					Response.Write "</td>"
				end if
			next
			Response.Write "</tr>"
			resul.MoveNext
		loop %>
	</tbody>
	</table>
<%
	else
		Response.Write "Sem usuários cadastrados."
	end if
%>


</body>
</html>