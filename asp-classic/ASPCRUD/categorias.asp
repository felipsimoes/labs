<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<%
	Dim erro
	erro = Request.QueryString("e")

	if erro <> "" then
		SELECT Case erro
			Case "1"
			Response.Write "Problema ao alterar/criar uma categoria."
			Case "2"
			Response.Write "Categoria alterada."
			Case "3"
			Response.Write "Não pode deixar o nome da categoria em branco."
			Case "4"
			Response.Write "Tentou excluir uma categoria inexistente."
			Case "5"
			Response.Write "Tentou excluir uma categoria inexistente ou não permitida."
			Case "6"
			Response.Write "Ocorreu um erro na tentativa de excluir a categoria."
			Case "7"
			Response.Write "A categoria foi excluida com sucesso."
			Case "8"
			Response.Write "A categoria foi criada com sucesso."
		End SELECT
	end if

%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Categorias</title>
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

	sql = "SELECT * FROM tb_categoria"
	Set resul = buscarSQL(sql)
	if resul.RecordCount > 0 then
%>
	<h2>Listagem de Categorias</h2>

	<div id="novacategoria">
		<a href="criarcategoria.asp">Criar nova categoria</a>
	</div>
	<table border="1" style="width:800px">
	<thead>
		<tr>
			<td>Nome</td>
			<td>Alterar</td>
			<td>Excluir</td>
		</tr>
	</thead>
	<tbody>
	<% 
		do until resul.EOF
			Response.Write "<tr>"

			Dim nome_categoria, id_categoria
		    id_categoria = resul.Fields("cd_id").Value
		    id_categoria = CInt(id_categoria)
            nome_categoria = resul.Fields("nm_nome").Value
                Response.Write "<td>" & nome_categoria & "</td>"
                Response.Write "<td><a href='alterarcategoria.asp?id="& id_categoria & "'> X </a> </td>"
               	if id_categoria <> 1 then
               		Response.Write "<td><a href='actions/excluircategoria.asp?id=" & id_categoria & "'> X </a> </td>"   
               	else
               		Response.Write "<td> - </td>"
               	end if

			Response.Write "</tr>"
			resul.MoveNext
		loop %>
	</tbody>
	</table>

<%
	else
		Response.Write "Problema na busca por categorias."
	end if
%>

</body>
</html>