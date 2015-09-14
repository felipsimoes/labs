<!-- #include file="../sys/codebase.asp" -->
<%
    Dim id
    id = Request.QueryString("id")

if id <> "" and id <> "0" and id <> "1" then
	pesquisasql = "SELECT * FROM tb_categoria WHERE cd_id = " & id
	set resul = buscarSQL(pesquisasql)
	if resul.RecordCount > 0 then

		updsql = "UPDATE tb_cadastro SET cd_categoria = 1 WHERE cd_categoria = " & id
		updatecategoria = CreUpSQL(updsql)

		if updatecategoria = true then

			delsql = "DELETE FROM tb_categoria WHERE cd_id = " & id 

			excluircategoria = ExcluirSQL(delsql)
			
			if excluircategoria = true then
				Response.Redirect "../categorias.asp?e=7"
			else
				Response.Redirect "../categorias.asp?e=6"
			end if
		else
			Response.Redirect "../categorias.asp?e=8"
		end if
	else
		Response.Redirect "../categorias.asp?e=4"
	end if
else
	Response.Redirect "../categorias.asp?e=5"
end if


%>