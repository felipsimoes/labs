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


'**** Procedimento para update de tags
'
			id = 15

    	'Pega todas tags criadas pelo usuários em um array separado por vírgulas
	    tagsnovas = split(upl.Form("tag[]"),",")
	    sqlinsertnomesnovos = "INSERT INTO tb_tag (nm_nome) VALUES "
	    for i=0 to UBound(tagsnovas)
	    	tagsinseridas = tagsinseridas & " (" & trim(tagsnovas(i)) & "),"
	    next
	    ''**INSERE NOVAS TAGS E BUSCA SEUS IDS
	    if (not IsEmpty(tagsinseridas)) then
	    	'Caso o usuário tenha criado alguma tag, elas serão inseridas no banco'
	   		sqlinsertnomesnovos = sqlinsertnomesnovos & tagsinseridas
	    	sqlinsertnomesnovos = left(sqlinsertnomesnovos, len(sqlinsertnomesnovos)-1)
	    	'Set criatags = CreUpSQL(sqlinsertnomesnovos)

			'Essas tags terão seus ids recuperados'
	    	sqlrecuperaidsnovos = "SELECT cd_id FROM tb_tag WHERE"
			for i=0 to UBound(tagsnovas)
		    	tagsrecuperadas = tagsrecuperadas & " nm_nome = '" & trim(tagsnovas(i)) & "',"
		    next
		    sqlrecuperaidsnovos = sqlrecuperaidsnovos & tagsrecuperadas
	    	sqlrecuperaidsnovos = left(sqlrecuperaidsnovos, len(sqlrecuperaidsnovos)-1)
	    	'Set buscaIdsNovos = buscarSQL(sqlrecuperaidsnovos)
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
	    if (not IsEmpty(tagsusuario)) then
	    	if (not IsEmpty(tagsinseridas)) then
	    		Dim codigo_tag
	    		do until buscaIdsNovos.EOF
	    				codigo_tag = buscaIdsNovos.Fields("cd_id")
	    				tagsusuario = tagsusuario & "(" & id & "," & codigo_tag "),"
	    			buscaIdsNovos.MoveNext
	    		loop 
	    	end if
		    'Caso o usuário tenha selecionado alguma tag do banco a query é preparada e executada'
		    tagsusuario = left(tagsusuario, len(tagsusuario)-1)	
		    sqltagsselecionadas = sqltagsselecionadas & tagsusuario
		    Set InsereTagsUsuario = CreUpSQL(sqltagsselecionadas)
	    end if

	    
	  	
%>