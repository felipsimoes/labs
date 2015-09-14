<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<%

	if(not IsEmpty(Request.QueryString("pesquisa")) ) then
		pesquisa = Request.QueryString("pesquisa")
	end if

	buscasql = "SELECT nm_nome, dt_nascimento, cd_id FROM tb_cadastro "
	'if pesquisa <> "" then
		buscasql = buscasql & "WHERE nm_nome LIKE " & chr(39) & chr(37) & pesquisa & chr(37) & chr(39) 
	'end if
	'if(not IsEmpty( Request.QueryString("ctg") ) ) then
	''	ctg = Request.QueryString("ctg")
	'else 
		ctg = "nm_nome"
	'end if
		
	prioridade = " AND ic_ativo = 1 ORDER BY " & ctg & " DESC"
	buscasql = buscasql & prioridade
	'Response.Write buscasql
	Set busca = buscarSQL(buscasql)
    if busca.RecordCount > 0 then
%>
	
	<p style="font-size:14px;margin-top:10px;margin-left:15px;">Clique no nome para ordenar de acordo</p>
	<table id="myTable" class="tablesorter" style="max-width:80%;font-size:15px;">
	
	<thead>
		<tr>
			<th>Nome</th>
			<th>Data de Nascimento</th>
			<th>Id</th>
			<th>Alterar</th>
			<th>Visualizar</th>
			<th>Excluir</th>
			<th>Notificar</th>
		</tr>
	</thead>
	<tbody>
	<%
		do until busca.EOF
		Dim nome, data_nasc, codigo
		nome = busca.Fields("nm_nome").Value
		data_nasc = busca.Fields("dt_nascimento").Value
		codigo = busca.Fields("cd_id").Value
		codigo = CStr(codigo)
		codigo = trim(codigo)
			Response.Write "<tr>"
			Response.Write "<td>" & nome & "</td>"
			Response.Write "<td>" & FormataData(data_nasc,2) & "</td>"
			Response.Write "<td>" & codigo & "</td>"
			Response.Write "<td><a href='alterar.asp?id="& codigo&"'>X</a></td>"
			Response.Write "<td><a href='visualizar.asp?id="& codigo&"'>X</a></td>"
			Response.Write "<td><a href='actions/excluir.asp?id="& codigo&"'>X</a></td>"
			Response.Write "<td><a href='actions/notificar.asp?id="& codigo&"'>X</a></td>"
			Response.Write "</tr>"
		busca.MoveNext
		loop
	%>
	</tbody>
	</table>
	<div id="exportbuttons">
		<a href="#" onclick="$('#myTable').tableExport({type:'excel',escape:'false',ignoreColumn: [3,4,5,6]});">Export XLS</a>
		<a href="#" onclick="$('#myTable').tableExport({type:'txt',escape:'false',ignoreColumn: [3,4,5,6]});">Export TXT</a>
	</div>
	<script>
	     $(document).ready(function() 
		    { 
		        $("#myTable").tablesorter(); 
		    }); 
	</script>
<%
	else
		Response.Write "Sem usuários cadastrados."
	end if
%>

