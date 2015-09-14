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
		Case "43"
		Response.Write "Usuario excluído com sucesso."
		Case "44"
		Response.Write "Ocorreu um erro na tentativa de excluir o usuário."
		Case "45"
		Response.Write "Houve uma tentativa de excluir um usuário inexistente."
	end SELECT
%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<head>
	<title>Listagem e busca</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
    <script type="text/javascript" src="js/pesquisa.js"></script>
    <script type="text/javascript" src="js/table-sorter/jquery.tablesorter.js"></script>
    <script type="text/javascript" src="js/tableexport/tableExport.js"> </script>
	<script type="text/javascript" src="js/tableexport/jquery.base64.js"></script>
	<script type="text/javascript" src="js/tableexport/jspdf/libs/sprintf.js"></script>
	<script type="text/javascript" src="js/tableexport/jspdf/jspdf.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/blue-table-sorter/style-table-sorter.css" />
    <style>
	  table,td {
	    	border: 1px solid black;
	    	text-align: center;
	    	margin-top: 30px;
	    	margin-left: 20px;
	    }
	    td {
	    	padding-left: 20px;
	    	padding-right: 20px;
	    }
    
    </style>
</head>
<body>
<!-- #include file="includes/menu.asp" -->

	<form action="" method="GET" id="pesquisaForm" name="pesquisa">
		<input type="text" name="pesquisa" id="mainPesquisa" placeholder="Digite o nome para buscar...">
        
	</form>
	

	<div id="resultado">
		
	</div>
	 <script>
	    $().ready(function() {
           
	       pesquisaAjax('<%  if(not IsEmpty(Request.QueryString("pesquisa"))) then Response.Write(Request.QueryString("pesquisa")) else Response.Write "pesquisa=" end if %>', 'nm_nome'); 
	      });
    </script>

</body>
</html>