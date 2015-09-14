<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<% 

Set upl = Server.CreateObject("SoftArtisans.FileUp")
	upl.CodePage = 65001

	nome = upl.Form("username")
	email = upl.Form("useremail")
	bday = upl.Form("userbday")
	foto = upl.Form("userphoto").UserFileName
	categoria = upl.Form("usercategory")

'Checa nome, email e bday, se estão vazios'
if IsEmpty(nome) or IsEmpty(email) or IsEmpty(bday) then
	Response.Redirect "../cadastro.asp?e=1"

else
	'Checa se o email é valido
	'Se nao for retorna mensagem de erro
	if validaEmail(email) = false then
		Response.Redirect "../cadastro.asp?e=4"
	end if
	'Converte a data de nascimento
	'Se ela for válida
	if(validaData(bday) = true) then
		bday = ConvertInputDate(bday)
	'retorna mensagem de data invalida'
	else
		Response.Redirect "../cadastro.asp?e=6"
	end if

	Dim novocadastro, novousuario, SelectID, id, salvaimg, destinothumb
	'Caso não tenha categoria selecionada o valor Zero é transformado em 1 (categoria padrão)'
	if categoria = 0 then
		categoria = 1
	end if

	if Not IsEmpty(foto) and ( len(foto) > 1 )then
		'Checa a extensao da foto do usuario'
		if (InStr(foto, ".jpg") > 0) then
			extensao = ".jpg"
		elseif (InStr(foto, ".png") > 0) then
			extensao = ".png"
		elseif (InStr(foto, ".jpeg") > 0) then
			extensao = ".jpeg"
		else
			Response.Redirect "../cadastro.asp?e=5"
		end if 
	end if

	novocadastro = "INSERT INTO tb_cadastro (nm_nome, nm_email, dt_nascimento, cd_categoria) VALUES ('" &_
			nome & "','" & email & "','" & bday & "'," & categoria & ")"
	Create = CreUpSQL(novocadastro)

	'Recupera-se o id do usuário recém-cadastrado para criar-se uma pasta de fotos dele
		novousuario = "SELECT cd_id FROM tb_cadastro WHERE nm_nome = '" & nome & "' AND nm_email = '" & email & "'"
		SelectID = buscarSQL(novousuario)
	'Logo que um usuário é criado, seu diretório é criado também'
		'Com o id do usuário (e convertendo para string) cria-se o diretório
		id = SelectID("cd_id")
		id = cstr(id)

		caminho = usuariospath
		criarDir = CriarDiretorio(caminho,id)

		salvaimg = caminho & id & "\" 
		'Cria diretorio de thumbnails
		criarDirThumb = CriarDiretorio(salvaimg, "thumb\")
		
		'Usuario é notificado de cadastro'
		copia = "felipe.lima@kbrtec.com.br"
		status = EnviarEmail("felipe.lima@kbrtec.com.br", "Sistema Crud", email, copia, "Confirmado seu cadastro", "Cadastro realizado com sucesso.")

	'Caso o usuário esteja enviando uma foto
	if foto <> "" then
		'Redefine o nome da imagem'
		foto = id & extensao

		'O caminho é passado como path do objeto, que envia a imagem
		upl.Path = salvaimg
		upl.SaveAs foto
		
		'Criar thumbnail da imagem enviada
		destinothumb = salvaimg & "thumb\"
		call redimensionarImagem(128, 128, salvaimg, destinothumb, foto)

		
		updatesqlfoto = "UPDATE tb_cadastro SET nm_url_foto = '" & foto &  "' WHERE cd_id = " & id
		updfoto = CreUpSQL(updatesqlfoto)
		
		'Retorna com mensagem de usuario cadastrado com sucesso
		Response.Redirect "../cadastro.asp?e=2"
			
	'Caso o usuário não envie uma foto		
	else
		'Retorna com mensagem de usuario cadastrado sem foto
		Response.Redirect "../cadastro.asp?e=3"
	end if
end if

%>