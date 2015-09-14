<!-- #include file="sys/codebase.asp" -->
<!-- #include file="sys/configPath.asp" -->
<%

dim t, id
id = "12"

diretorio_usuario = cfg_usuariospath & id

Response.Write  diretorio_usuario

	Dim fs,fo
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	set fo=fs.GetFolder(diretorio_usuario)
	if fs.FolderExists(diretorio_usuario)=true then
		fo.Delete 
	else 
		Response.Write "nao existe."
	end if
	set fo=nothing
	set fs=nothing


%>