<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<!-- #include file="sys/configPath.asp" -->
<%
    Dim erro
    erro = Request.QueryString("e")


if erro <> "" then
    Response.Write "Houve um erro não identificado"
end if

%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Criar Categoria</title>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="js/actions.js"> </script>
</head>
<body>
<!-- #include file="includes/menu.asp" --> 

<h3>Criar Categoria</h3>
    <form name="alteracao" id="alteracao_form" method="post" action="actions/criarcategoria.asp" onSubmit="return ValidarNovaCategoria()">
        <p>Nome da categoria:</p>
        <input type="text" name="categoryname" placeholder="Nome da categoria..." maxlength="50" >
       
        <br>
        <input type="submit" value="Criar Categoria">       
    </form>
	
	<div id="erro">
		
	</div>
</body>
</html>