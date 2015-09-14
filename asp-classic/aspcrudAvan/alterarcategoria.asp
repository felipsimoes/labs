<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<!-- #include file="sys/configPath.asp" -->
<%
    Dim id, erro
    id = Request.QueryString("id")
    erro = Request.QueryString("e")


if id <> "" then
    catsql = "SELECT * FROM tb_categoria WHERE cd_id = " & id
    set resul = buscarSQL(catsql)
    if resul.RecordCount > 0 then
        do until resul.EOF
            Dim id_categoria, nome_categoria
            id_categoria = resul.Fields("cd_id").Value
            nome_categoria = resul.Fields("nm_nome").Value                        
        resul.MoveNext
        loop
    else
        Response.Write "Erro na busca pelo id da categoria"
    end if

else
    Response.Redirect "categorias.asp"

end if

%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Alterar Categoria</title>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="js/actions.js"> </script>
</head>
<body>
<!-- #include file="includes/menu.asp" --> 

<h3>Alterar Categoria</h3>
    <form name="alteracao" id="alteracao_form" method="post" action="actions/alterarcategoria.asp?id=<%= id %>" >
        <p>Nome da categoria:</p>
        <input type="text" name="categoryname" placeholder="Nome da categoria..." maxlength="50" value='<% Response.Write nome_categoria %>' >
       
        <br>
        <input type="submit" value="Alterar Categoria">       
    </form>
	
	<div id="erro">
		
	</div>
</body>
</html>