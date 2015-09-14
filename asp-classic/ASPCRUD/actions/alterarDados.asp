<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<% 
Dim id
   id = Request.QueryString("id")
if id <> "" then

	Set upl = Server.CreateObject("SoftArtisans.FileUp")
		upl.CodePage = 65001

		nome = upl.Form("username")
		email = upl.Form("useremail")
		bday = upl.Form("userbday")
		foto = upl.Form("userphoto").UserFileName
		categoria = upl.Form("usercategory")
		fotoantiga = upl.Form("useroldphoto")
	nomelimpo = trim(nome)
	emaillimpo = trim(email)
	bdaylimpo = trim(bday)

	if len(nomelimpo) < 1 or len(emaillimpo) < 1  or len(bdaylimpo) < 1 then
		Response.Redirect "../alterar.asp?id="&id&" 1&e=1"
	else 
		'Checa se o email é valido
		'Se nao for retorna mensagem de erro
		if validaEmail(email) = false then
			Response.Redirect "../alterar.asp?id="&id&"&e=4"
		end if

		'Converte a data de nascimento
		'Se ela for válida
		if(validaData(bday) = true) then
			bday = ConvertInputDate(bday)
		'retorna mensagem de data invalida'
		else
			Response.Redirect "../alterar.asp?id="&id&"&e=3"
		end if

		'Caso usuário não queira enviar nova foto o campo de nm_url_foto não é alterado'
		if len(foto) < 1 then
			fotosql = " " 

		'Caso usuário passe uma foto nova o campo de nm_url_foto deve ser alterado'
		else 

			'Checa a extensao da foto do usuario'
			if (InStr(foto, ".jpg") > 0) then
				extensao = ".jpg"
			elseif (InStr(foto, ".png") > 0) then
				extensao = ".png"
			elseif (InStr(foto, ".gif") > 0) then 
				extensao = ".gif"
			elseif (InStr(foto, ".jpeg") > 0) then
				extensao = ".jpeg"
			else
				Response.Redirect "../alterar.asp?id="&id&"&e=5"
			end if 

			'Foto é nomeada com o id do usuario e extensao original'
			foto = id & extensao
				
			fotosql = ", nm_url_foto = '" & foto & "'"
			
			'A nova foto do usuário é enviada para sua pasta'
			ids = cstr(id)
			caminhofoto = usuariospath & ids & "\"

			'A antiga foto do usuário deve ser apagada'
			'A antiga thumbnail do usuário deve ser apaga'
			Dim objFS
			fotoapagada = caminhofoto & "\" & fotoantiga
			thumbapagada = destinothumb & fotoantiga
			Set objFS = Server.CreateObject("Scripting.FileSystemObject")
			if objFS.FileExists(fotoapagada) then
					objFS.DeleteFile(fotoapagada)
			end if
			if objFS.FileExists(thumbapagada) then
					objFS.DeleteFile(thumbapagada)
			end if 
			Set objFS = Nothing

			
			'A foto nova será enviada para o diretorio'
			Set objFS = Server.CreateObject("Scripting.FileSystemObject")
			'Caso o diretorio exista a foto é jogada la'
			if objFS.FolderExists(caminhofoto)=true then
					upl.Path = caminhofoto
					upl.SaveAs foto
			else
					caminho = usuariospath
					criarDir = CriarDiretorio(caminho,id)
					upl.Path = caminhofoto
					upl.SaveAs foto
			end if
			Set objFS = Nothing


			destinothumb = caminhofoto & "thumb\"
			'A thumb nova será enviada para o diretorio de thumb'
			Set objFS = Server.CreateObject("Scripting.FileSystemObject")
			if objFS.FolderExists(destinothumb) then
					'Nova thumbnail é criada para o usuário'
					call redimensionarImagem(128, 128, caminhofoto, destinothumb, foto)
			else
					salvaimg = caminho & id & "\" 
					'Cria diretorio de thumbnails
					criarDirThumb = CriarDiretorio(salvaimg, "thumb\")
					call redimensionarImagem(128, 128, caminhofoto, destinothumb, foto)
			end if 
			Set objFS = Nothing
		end if 

		'Forma-se a query a ser atualizada'
		sql = "UPDATE tb_cadastro SET nm_nome = '" & nome & "'" &_
			", nm_email = '" & email & "'" &_
			", dt_nascimento = '" & bday & "'" &_
			fotosql &_
			", cd_categoria = " & CInt(categoria) &_
			" WHERE cd_id = " & id 

		'Atualiza os dados do usuário identificado'
		upd = CreUpSQL(sql)
		Response.Redirect "../alterar.asp?id=" & id & "&e=2"

	end if
else
	Response.Redirect "../alterar.asp?e=2"
end if
%>