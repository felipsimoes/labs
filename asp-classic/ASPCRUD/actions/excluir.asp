<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<%
	Dim id
	id = Request.QueryString("id")
	id = trim(id)

if id <> "" then
	'O cadastro é removido do banco de dados'
	querydelete = "DELETE FROM tb_cadastro WHERE cd_id = " & id
	excluircadastro = ExcluirSQL(querydelete)


	''passa o diretorio da pasta com imagens do usuário
	diretorio_usuario = usuariospath & id

	''Excluir diretorio com id do usuário
	Dim fs,fo
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	set fo=fs.GetFolder(diretorio_usuario)
	if fs.FolderExists(diretorio_usuario)=true then
		fo.Delete 
	end if
	set fo=nothing
	set fs=nothing
	'Caso o cadastro tenha sido excluido com sucesso
	'Retorna para a listagem de cadastros
	if excluircadastro = true then
		Response.Redirect "../listagem.asp"
	else
		Response.Write "O cadastro nao foi excluido por algum motivo."
	end if
else
	Request.Redirect "../listagem.asp?e=" 'DEFINIR NUMERO DO ERRO QUANDO NAO HÁ ID DEFINIDA'

end if


%>