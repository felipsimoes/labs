<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<!-- #include file="../sys/configPath.asp" -->
<% 

Set upl = Server.CreateObject("SoftArtisans.FileUp")
	upl.CodePage = 65001

	nome = upl.Form("username")
	email = upl.Form("useremail")
	bday = upl.Form("userbday")
	categoria = upl.FormEx("usercategory[]")
	subtipo = upl.FormEx("usersubtype[]")
	foto = upl.Form("userphoto").UserFileName
	

'Checa nome, email e bday, se estão vazios'
if IsEmpty(nome) or IsEmpty(email) or IsEmpty(bday) or categoria = "" or subtipo = "" then
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

	novocadastro = "INSERT INTO tb_cadastro (nm_nome, nm_email, dt_nascimento) VALUES ('" &_
			nome & "','" & email & "','" & bday & "')"
	Create = CreUpSQL(novocadastro)

	'Recupera-se o id do usuário recém-cadastrado para criar-se uma pasta de fotos dele
		novousuario = "SELECT MAX(cd_id) as cd_id FROM tb_cadastro WHERE nm_nome = '" & nome & "' AND nm_email = '" & email & "'"
		SelectID = buscarSQL(novousuario)
	'Logo que um usuário é criado, seu diretório é criado também'
		'Com o id do usuário (e convertendo para string) cria-se o diretório
		id = SelectID("cd_id")
		id = cstr(id)

	'forma a string de categorias que o usuário escolheu e insere na tabela de resolução
		insertCatSQL = "INSERT INTO tb_res_categoria (cd_id_cadastro, cd_id_categoria) VALUES "

		for each categoria in upl.FormEx("usercategory[]") 
			insertCatSQL = insertCatSQL & "(" & id & "," & categoria & "),"
		next
	'remove a última vírgula e faz a inserção na tabela
		insertCatSQL = left(insertCatSQL,len(insertCatSQL)-1)
		insertCategorias = CreUpSQL(insertCatSQL)

	'forma a string de subtipos que o usuário escolheu e insere na tabela de resolução
		insertSubtipoSQL = "INSERT INTO tb_res_subtipo (cd_id_cadastro, cd_id_subtipo) VALUES "

		for each subtipo in upl.FormEx("usersubtype[]") 
			insertSubtipoSQL = insertSubtipoSQL & "(" & id & "," & subtipo & "),"
		next
	'remove a última vírgula e faz a inserção na tabela
		insertSubtipoSQL = left(insertSubtipoSQL,len(insertSubtipoSQL)-1)
		insertSubtipos = CreUpSQL(insertSubtipoSQL)

'**** Procedimento para update de tags
	    	'Pega todas tags criadas pelo usuários em um array separado por vírgulas
	    tagsnovas = split(upl.Form("tag[]"),",")
	    sqlinsertnomesnovos = "INSERT INTO tb_tag (nm_nome) VALUES "
	    for i=0 to UBound(tagsnovas)
	    	tagsinseridas = tagsinseridas & " ('" & trim(tagsnovas(i)) & "'),"
	    next
	    ''**INSERE NOVAS TAGS E BUSCA SEUS IDS
	    if (not IsEmpty(tagsinseridas)) then
	    	'Caso o usuário tenha criado alguma tag, elas serão inseridas no banco'
	   		sqlinsertnomesnovos = sqlinsertnomesnovos & tagsinseridas
	    	sqlinsertnomesnovos = left(sqlinsertnomesnovos, len(sqlinsertnomesnovos)-1)
	    	criatags = CreUpSQL(sqlinsertnomesnovos)

			'Essas tags terão seus ids recuperados'
	    	sqlrecuperaidsnovos = "SELECT cd_id FROM tb_tag WHERE"
	    	Response.Charset = "utf-8"
			for i=0 to UBound(tagsnovas)
		    	tagsrecuperadas = tagsrecuperadas & " nm_nome = '" & trim(tagsnovas(i)) & "' OR"
		    next
		    sqlrecuperaidsnovos = sqlrecuperaidsnovos & tagsrecuperadas
	    	sqlrecuperaidsnovos = left(sqlrecuperaidsnovos, len(sqlrecuperaidsnovos)-2)
	    	Response.Write sqlrecuperaidsnovos
	    	Set buscaIdsNovos = buscarSQL(sqlrecuperaidsnovos)
	    end if
	    ''**NOVAS TAGS INSERIDAS E SEUS IDS EM buscaIdsNovos

	    ''**BUSCA TODAS IDS NO BANCO
		sqlbuscatags = "SELECT * FROM tb_tag"
	    Set restags = buscarSQL(sqlbuscatags)
	    'Confere as tags selecionadas pelo usuário que já existiam no banco e insere numa query'
	    do until restags.EOF
	   		if (not IsEmpty(upl.Form("tag[" & CStr(restags.Fields("cd_id").Value) & "-a]")) ) then
		   		tagsusuario = tagsusuario & " (" & id & "," & CStr(restags.Fields("cd_id").Value) & "),"
		   	end if
	   		restags.MoveNext
	    loop   

		sqltagsselecionadas = "INSERT INTO tb_res_tag (cd_id_cadastro,cd_id_tag) VALUES "
	    if (not IsEmpty(tagsinseridas)) then
	    		Dim codigo_tag
	    		do until buscaIdsNovos.EOF
	    				codigo_tag = buscaIdsNovos.Fields("cd_id").Value
	    				tagsusuario = tagsusuario & "(" & id & "," & CInt(codigo_tag) & "),"
	    			buscaIdsNovos.MoveNext
	    		loop 
	    end if
	    if (not IsEmpty(tagsusuario)) OR (not IsEmpty(tagsinseridas)) then
	    	'Caso o usuário tenha selecionado alguma tag do banco ou inserido alguma nova a query é preparada e executada'
		    tagsusuario = left(tagsusuario, len(tagsusuario)-1)	
		    sqltagsselecionadas = sqltagsselecionadas & tagsusuario
		    InsereTagsUsuario = CreUpSQL(sqltagsselecionadas)
		    Response.Write sqltagsselecionadas
	    end if
	
'**** Procedimento para criar diretorios de imagens do usuario e envio de confirmacao do cadastro
'
'
		caminho = usuariospath
		criarDir = CriarDiretorio(caminho,id)

		salvaimg = caminho & id & "\" 
		'Cria diretorio de thumbnails
		criarDirThumb = CriarDiretorio(salvaimg, "thumb\")
		
		'Usuario é notificado de cadastro'
		copia = "felipe.lima@kbrtec.com.br"
		status = EnviarEmail("felipe.lima@kbrtec.com.br", "Sistema Crud", email, copia, "Confirmado seu cadastro", "Cadastro realizado com sucesso.")

'**** Procedimento para upload de foto e thumbnail
'
'
	'Caso o usuário esteja enviando uma foto
	if foto <> "" then
		'Redefine o nome da imagem'
		foto = id & extensao

		'O caminho é passado como path do objeto, que envia a imagem
		upl.Path = salvaimg
		upl.SaveAs foto
	
	'***** Criar thumb conforme a opção do usuário
	'	
		'Criar thumbnail da imagem enviada
		destinothumb = salvaimg & "thumb\"

		x = Cint(upl.form("X"))
		y = Cint(upl.form("Y"))
		w = Cint(upl.form("W"))
		h = Cint(upl.form("H"))

		call ThumbCriado(x,y,w,h,salvaimg,destinothumb, foto)
	''		call redimensionarImagem(128, 128, salvaimg, destinothumb, foto)
		
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