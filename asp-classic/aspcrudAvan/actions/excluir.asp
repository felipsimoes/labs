<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<%
	Dim id
	id = Request.QueryString("id")
	id = trim(id)

if id <> "" then
	'O cadastro é removido do banco de dados'
	querydelete = "UPDATE tb_cadastro SET ic_ativo = 0 WHERE cd_id = " & id
	excluircadastro = CreUpSQL(querydelete)


	''passa o diretorio da pasta com imagens do usuário
	diretorio_usuario = usuariospath & id

	''Excluir diretorio com id do usuário
	Dim fs,fo
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	if fs.FolderExists(diretorio_usuario)=true then
		set fo=fs.GetFolder(diretorio_usuario)
		fo.Delete 
	end if
	set fo=nothing
	set fs=nothing
	'Caso o cadastro tenha sido excluido com sucesso
	'Retorna para a listagem de cadastros
	if excluircadastro = true then
		Response.Redirect "../listagem.asp?e=43"
	else
		Response.Redirect "../listagem.asp?e=44"
	end if
else
	Request.Redirect "../listagem.asp?e=45" 'DEFINIR NUMERO DO ERRO QUANDO NAO HÁ ID DEFINIDA'

end if


%>