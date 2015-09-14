<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="sys/codebase.asp" -->
<%
    Dim erro
    erro = Request.QueryString("e")
    select case erro
        case "1" 
            Response.Write "É preciso preencher os campos de cadastro."
        case "2"
            Response.Write "Usuário cadastrado com sucesso."
        case "3" 
            Response.Write "Usuário cadastrado com sucesso. Considere enviar uma foto."
        case "4"
            Response.Write "É preciso preencher um email válido."
        case "5"
            Response.Write "É preciso que a imagem seja de extensão condizente."
        case "6"
            Response.Write "É preciso que a data de nascimento seja coerente."
        case "7"
            Response.Write "Você não passou no teste de CAPTCHA."
    end select
%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Cadastro</title>
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
<h3>Novo Cadastro</h3>
    <form name="cadastro" id="cadastro_form" method="post" action="actions/cadastrar.asp" onSubmit="return ValidarCadastro()"  enctype="multipart/form-data">
        <p>Nome de usuário:</p>
        <input type="text" name="username" placeholder="Nome do usuário..." maxlength="60">
        <p>Email:</p>
        <input type="email" name="useremail" placeholder="fulano@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" maxlength="60"> 
        <p>Data de nascimento:</p>
        <input type="text" id="datepicker" name="userbday" placeholder="DD/MM/AAAA" maxlength="10" pattern="^[0-3]?[0-9]\/[01]?[0-9]\/[12][90][0-9][0-9]$">
        <p>Foto (upload):</p>        
        <input type="file" id="file" accept="image/*" name="userphoto">
        <br>
        <p>Categoria:</p>
        <select data-placeholder="Escolha sua categoria..." multiple class="chosen-select" name="usercategory[]" id="usercategory" style="width:200px;">
            <%
                sql = "SELECT nm_nome, cd_id FROM tb_categoria"
                Set resul = buscarSQL(sql)            

                if resul.RecordCount > 0 then
                    do until resul.EOF
                        Dim id_categoria, nome
                        id_categoria = resul.Fields("cd_id").Value
                        nome = resul.Fields("nm_nome").Value
                        Response.Write "<option value='" & CInt(id_categoria) & "'>"
                        Response.Write nome & "</option>"
                        
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

        if resulTipos.RecordCount > 0 then
            do until resulTipos.EOF
            Dim nome_tipo, codigo_subtipo, nm_tipo, nome_subtipo, flag_abriu_optgroup
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
                Response.Write  ">" & nome_subtipo & "</option>"
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

            
        </p>

        <input type="hidden" name="usertypeNum" id="usertypeNum" value='1'>
        <input type="hidden" id="x" name="x" />
        <input type="hidden" id="y" name="y" />
        <input type="hidden" id="w" name="w" />
        <input type="hidden" id="h" name="h" />

        <br>

<!-- #include file="includes/captcha.asp" --> 
        <input type="submit" value="Cadastrar">          
    </form>
	
	<div id="erro">
		
	</div>
        <script>

    
    $().ready(function() {

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
       
    });
    $("#cadastro_form").find('input.tag').tagedit({
        autocompleteURL: 'actions/autocompletetags.asp'
    });


    </script>
    
</body>
</html>