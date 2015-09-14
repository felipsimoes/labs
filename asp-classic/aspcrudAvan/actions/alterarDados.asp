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
		categoria = upl.FormEx("usercategory[]")
		subtipo = upl.FormEx("usersubtype[]")
		fotoantiga = upl.Form("useroldphoto")
		
		nomelimpo = trim(nome)
		emaillimpo = trim(email)
		bdaylimpo = trim(bday)

	if len(nomelimpo) < 1 or len(emaillimpo) < 1  or len(bdaylimpo) < 1 or categoria = "" or subtipo = "" then
		Response.Redirect "../alterar.asp?id="&id&"&e=1"
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

''*** Realiza update de fotos
			'Checa a extensao da foto do usuario'
			if (InStr(foto, ".jpg") > 0) then
				extensao = ".jpg"
			elseif (InStr(foto, ".png") > 0) then
				extensao = ".png"
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

			x = Cint(upl.form("X"))
			y = Cint(upl.form("Y"))
			w = Cint(upl.form("W"))
			h = Cint(upl.form("H"))

			destinothumb = caminhofoto & "thumb\"
			'A thumb nova será enviada para o diretorio de thumb'
			Set objFS = Server.CreateObject("Scripting.FileSystemObject")
			if objFS.FolderExists(destinothumb) then
					'Nova thumbnail é criada para o usuário'
					call ThumbCriado(x,y,w,h,caminhofoto,destinothumb, foto)
			''		call redimensionarImagem(128, 128, caminhofoto, destinothumb, foto)
			else
					salvaimg = caminho & id & "\" 
					'Cria diretorio de thumbnails
					criarDirThumb = CriarDiretorio(salvaimg, "thumb\")
					call ThumbCriado(x,y,w,h,caminhofoto,destinothumb, foto)
			end if 
			Set objFS = Nothing
		end if 

''*** Update de fotos encerrado
''*** Atualiza dados da tb_cadastro

		'Forma-se a query a ser atualizada'
		sql = "UPDATE tb_cadastro SET nm_nome = '" & nome & "'" &_
			", nm_email = '" & email & "'" &_
			", dt_nascimento = '" & bday & "'" &_
			fotosql &_
			" WHERE cd_id = " & id 

		'Atualiza os dados do usuário identificado'
		upd = CreUpSQL(sql)

''*** Dados de tb_cadastro realizados
''*** Realiza update de categorias e subtipos

		'apaga os registros relacionados aquele usuário na tb_res_categoria
		delsql = "DELETE FROM tb_res_categoria WHERE cd_id_cadastro = " & id
		del_categ = CreUpSQL(delsql)

		'forma a string de categorias que o usuário escolheu e insere na tabela de resolução
		insertCatSQL = "INSERT INTO tb_res_categoria (cd_id_cadastro, cd_id_categoria) VALUES "

		for each categoria in upl.FormEx("usercategory[]") 
			insertCatSQL = insertCatSQL & "(" & id & ", "& categoria & "),"
		next
		'remove a última vírgula e faz a inserção na tabela
		insertCatSQL = left(insertCatSQL,len(insertCatSQL)-1)
		insertCategorias = CreUpSQL(insertCatSQL)

		'apaga os registros relacionados aquele usuário na tb_res_subtipo
		delsql = "DELETE FROM tb_res_subtipo WHERE cd_id_cadastro = " & id
		del_subtipos = CreUpSQL(delsql)

		'forma a string de subtipos que o usuário escolheu e insere na tabela de resolução
		insertSubtipoSQL = "INSERT INTO tb_res_subtipo (cd_id_cadastro, cd_id_subtipo) VALUES "

		for each subtipo in upl.FormEx("usersubtype[]") 
			insertSubtipoSQL = insertSubtipoSQL & "(" & id & "," & subtipo & "),"
		next
		'remove a última vírgula e faz a inserção na tabela
		insertSubtipoSQL = left(insertSubtipoSQL,len(insertSubtipoSQL)-1)
		insertSubtipos = CreUpSQL(insertSubtipoSQL)

''*** Update de categorias e subtipos realizados
		''Tags do usuário são apagadas e novas tags são atribuídas
		sqlDeleteTagsUsuario = "DELETE FROM tb_res_tag WHERE cd_id_cadastro = " & id
		AntigasTagsDeletas = CreUpSQL(sqlDeleteTagsUsuario)

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
''*** Update de tags realizado

		Response.Redirect "../alterar.asp?id=" & id & "&e=2"

	end if
else
	Response.Redirect "../alterar.asp?e=2"
end if
%>