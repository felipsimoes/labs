<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<!-- #include file="sys/configPath.asp" -->
<%
    Dim id, erro
    id = Request.QueryString("id")
    erro = Request.QueryString("e")

   
if id <> "" then
    sql = "SELECT * FROM tb_cadastro WHERE cd_id = " & id
    
    if erro <> "" then
        SELECT CASE erro
            Case "1"
                Response.Write "Os campos Nome, Email e Data de Nascimento precisam ser preenchidos."
            case "2"
                Response.Write "Dados atualizados corretamente."
            case "3"
                Response.Write "Data está incorreta ou incoerente."
            case "4"
                Response.Write "Email inválido ou incoerente."
            case "5"
                Response.Write "A foto não tem uma extensão permitida."
            case "6"
                Response.Write "Ocorreu uma tentativa de alterar um usuário sem identificação."
        end select
    end if
else
    Response.Write "É necessário passar um id."
end if

%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Alterar Cadastro</title>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" href="css/jquery.Jcrop.css" type="text/css" />
    <link rel="stylesheet" href="js/chosen/chosen.css" type="text/css" />
    <link rel="stylesheet" href="js/tagedit/css/jquery.tagedit.css" type="text/css"/>
    <!-- #include file="includes/jqueryui.asp" --> 
    <script type="text/javascript" src="js/chosen/chosen.jquery.js"> </script>
    <script type="text/javascript" src="js/jquery.Jcrop.js"></script>  
    <script type="text/javascript" src="js/previewImg.js"></script>
    <script type="text/javascript" src="js/actions.js"></script>
    <script type="text/javascript" src="js/tagedit/js/jquery.autoGrowInput.js"></script>
    <script type="text/javascript" src="js/tagedit/js/jquery.tagedit.js"></script>
    <script type="text/javascript" src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body onload="datepicker()">
<!-- #include file="includes/menu.asp" --> 
<!-- #include file="includes/thumb.asp" -->
<%

 '' On Error Resume Next 
    Set busca = buscarSQL(sql)

    if busca.RecordCount > 0 then
        do until busca.EOF
            nome_usuario = busca.Fields("nm_nome").Value
            email_usuario = busca.Fields("nm_email").Value
            bday_usuario = busca.Fields("dt_nascimento").Value
            foto_usuario = busca.Fields("nm_url_foto").Value
        busca.MoveNext
        loop
    end if
    
    busca.Close
    teste = ConvertInputDateTime(bday_usuario)
    If Err.Number <> 0 Then
      Response.Write "Problema de busca dos dados"
   else
   
%>
<h3>Alterar Cadastro</h3>
    <form name="cadastro" id="alteracao_form" method="post" action="actions/alterarDados.asp?id=<%= id %>" onSubmit="return ValidarCadastro()" onload="datepicker()" enctype="multipart/form-data">
        <p>Nome de usuário:</p>
        <input type="text" name="username" placeholder="Nome do usuário..." maxlength="60" value="<% Response.Write nome_usuario %>" >
        <p>Email:</p>
        <input type="email" name="useremail" placeholder="fulano@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" 
         value="<% Response.Write email_usuario %>" maxlength="60"> 
        <p>Data de nascimento:</p>
        <input type="text" id="datepicker" name="userbday" placeholder="DD/MM/AAAA" maxlength="10" pattern="^[0-3]?[0-9]\/[01]?[0-9]\/[12][90][0-9][0-9]$" value="<% Response.Write FormataData(bday_usuario,2) %>">
        <p>Foto (upload):</p>        
        <input type="file" id="file" accept="image/*" name="userphoto">
        <br>
        <% 
            if foto_usuario <> "" then
                Response.Write "<img src='" & cfg_usuariospath & id & "/thumb/" & foto_usuario & "' style='max-width:300px;'>" 
                Response.Write "<input type='hidden' name='useroldphoto' value='" & foto_usuario & "'>"
            else
                Response.Write "<br><strong>Usuário ainda não tem foto.</strong><br>"
            end if 
        %>
        <br>
        <p>Categoria:</p>
        <select data-placeholder="Escolha sua categoria..." multiple class="chosen-select" name="usercategory[]" id="usercategory" style="width:200px;">
            <%
                ''Busca todas as categorias do banco
                sql = "SELECT nm_nome, cd_id FROM tb_categoria"
                Set resul = buscarSQL(sql)   
                ''Busca todas as categorias que o usuários tenha selecionado
                sqlcatusuario = "SELECT r.cd_id_categoria FROM tb_res_categoria r INNER JOIN tb_cadastro c "&_
                                    "WHERE r.cd_id_cadastro = "& id &" AND r.cd_id_cadastro = c.cd_id"
                Set buscaCatUsuario = buscarSQL(sqlcatusuario)      
                
                Dim id_categoria, nome, id_selecionada, cat_id
                if resul.RecordCount > 0 then
                    do until resul.EOF                        
                        flag_selected = 0
                        id_categoria = resul.Fields("cd_id").Value
                        nome = resul.Fields("nm_nome").Value
                        cat_id = CInt(id_categoria)
                        Response.Write "<option value=" & chr(39) & cat_id & chr(39)
                            buscaCatUsuario.MoveFirst  
                            do until buscaCatUsuario.EOF
                                id_selecionada = buscaCatUsuario.Fields("cd_id_categoria").Value
                                id_selecionada_int = CInt(id_selecionada)
                                if id_selecionada_int = cat_id then
                                    Response.Write "selected "                            
                                end if
                                buscaCatUsuario.MoveNext
                            loop
                        Response.Write ">" & nome & "</option>"
                        resul.MoveNext
                    loop
                end if
            %>
        </select>
        <p>Tipos - subtipos:</p>
        <select data-placeholder="Escolha seu tipo..." multiple tab-index="-1" class="chosen-select" name="usersubtype[]" id="usersubtype" style="width:300px;">
    <% 
        
        sql_tb_tipo = "SELECT sub.cd_id as codigo_subtipo, sub.nm_nome as nome_subtipo, tipo.nm_nome as nome_tipo "
        sql_tb_tipo = sql_tb_tipo & "FROM tb_subtipo sub INNER JOIN tb_tipo tipo WHERE tipo.cd_id = sub.cd_tipo"
        Set resulTipos = buscarSQL(sql_tb_tipo)

        sql_subtipo_usuario = "SELECT cd_id_cadastro as cadastro, cd_id_subtipo as subtipo FROM tb_res_subtipo " &_ 
                                "WHERE cd_id_cadastro = " & id
        Set buscaSubtipoUsuario = buscarSQL(sql_subtipo_usuario)
        'Todos os dados de subtipos do banco'
        if resulTipos.RecordCount > 0 then
            do until resulTipos.EOF
            Dim nome_tipo, codigo_subtipo, nm_tipo, nome_subtipo
            nome_tipo = resulTipos.Fields("nome_tipo")
            codigo_subtipo = resulTipos.Fields("codigo_subtipo")
            nome_subtipo = resulTipos.Fields("nome_subtipo")
            'Se nm_tipo ainda não foi declarada  OU  se nm_tipo for diferente do atual nome_tipo'
                if IsEmpty(nm_tipo) or nm_tipo <> resulTipos.Fields("nome_tipo") then
                    'Se for a primeira vez que é declarado - abre um optgroup'
                    if IsEmpty(nm_tipo) then
                        Response.Write "<optgroup label='" & resulTipos.Fields("nome_tipo") & "'>"
                        nm_tipo = resulTipos.Fields("nome_tipo")
                    'Se o nm_tipo ainda não foi declarado '
                    else
                        nm_tipo = resulTipos.Fields("nome_tipo")
                        Response.Write "</optgroup>"
                        Response.Write "<optgroup label='" & nm_tipo & "'>"
                    end if
                end if
                Response.Write "<option value=" 
                Response.Write codigo_subtipo 
                buscaSubtipoUsuario.MoveFirst
                do until buscaSubtipoUsuario.EOF
                    codigo_subtipo_usuario = buscaSubtipoUsuario.Fields("subtipo")
                    subtipo_banco = CInt(codigo_subtipo)
                    subtipo_usuario = CInt(codigo_subtipo_usuario)
                    if subtipo_usuario = subtipo_banco then
                        Response.Write " selected"                     
                    end if  
                    buscaSubtipoUsuario.MoveNext
                loop
                Response.Write  ">"
                Response.Write  nome_subtipo & "</option>"
                resulTipos.MoveNext
            loop
            Response.Write "</optgroup>"
        end if 


    %>
        </select>
        <br>
          <p>Tags:</p>
        <p>
        <input type="text" name="tag[]" value="" class="tag"/>
     <% 
        sqlTagsUsuario = "SELECT res.cd_id_tag as codigo_tag, tag.nm_nome as nome_tag FROM tb_res_tag res " &_ 
                            "INNER JOIN tb_tag tag WHERE res.cd_id_cadastro = " & id & " AND res.cd_id_tag = tag.cd_id"
        Set tagsUsuario = buscarSQL(sqlTagsUsuario)

        if tagsUsuario.RecordCount > 0 then
        do until tagsUsuario.EOF
            Dim codigo_tag, nome_tag
            codigo_tag = tagsUsuario.Fields("codigo_tag")
            nome_tag = tagsUsuario.Fields("nome_tag")
            Response.Write "<input type='hidden' name='tag["& CStr(codigo_tag) &"-a]' value='" & nome_tag & "' class='tag'/>"
            tagsUsuario.MoveNext
        loop
        end if
    %>
            
  
        </p>

        <input type="hidden" name="usertypeNum" id="usertypeNum" value='1'>
        <input type="hidden" id="x" name="x" />
        <input type="hidden" id="y" name="y" />
        <input type="hidden" id="w" name="w" />
        <input type="hidden" id="h" name="h" />

        <br>
<!-- #include file="includes/captcha.asp" --> 

        <br>
        <input type="submit" value="Alterar">       
    </form>
	
	<div id="erro">
		
	</div>
     <script>
    
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Desculpe, nenhuma opção encontrada!'},
      '.chosen-select-width'     : {width:"95%"}
    }
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
    $("#alteracao_form").find('input.tag').tagedit({
        //autocompleteURL: 'js/tagedit/server/autocomplete.php',
        autocompleteURL: 'actions/autocompletetags.asp'
    });

    </script>
<%
     End If
    On Error GoTo 0
%>
</body>
</html>