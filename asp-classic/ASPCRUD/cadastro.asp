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
    end select
%>
<!DOCTYPE>
<html>
<meta charset="utf-8">
<title>Tela de Cadastro</title>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="js/actions.js"> </script>
</head>
<body>
<!-- #include file="includes/menu.asp" --> 

<h3>Novo Cadastro</h3>
    <form name="cadastro" id="cadastro_form" method="post" action="actions/cadastrar.asp" onSubmit="return ValidarCadastro()" enctype="multipart/form-data">
        <p>Nome de usuário:</p>
        <input type="text" name="username" placeholder="Nome do usuário..." maxlength="60">
        <p>Email:</p>
        <input type="email" name="useremail" placeholder="fulano@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" maxlength="60"> 
        <p>Data de nascimento:</p>
        <input type="text" name="userbday" placeholder="DD/MM/AAAA" maxlength="10" pattern="^[0-3]?[0-9]\/[01]?[0-9]\/[12][90][0-9][0-9]$">
        <p>Foto (upload):</p>        
        <input type="file" accept="image/*" name="userphoto">
        <br>
        <p>Categoria:</p>
        <select name="usercategory" id="usercategory">
            <option value="0" selected>Selecione uma categoria</option>
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

        <br>
        <input type="submit" value="Cadastrar">       
    </form>
	
	<div id="erro">
		
	</div>
</body>
</html>