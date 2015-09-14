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
    <script type="text/javascript" src="js/actions.js"> </script>
</head>
<body>
<!-- #include file="includes/menu.asp" --> 
<%

  On Error Resume Next 
    Set busca = buscarSQL(sql)

    if busca.RecordCount > 0 then
        do until busca.EOF
            nome_usuario = busca.Fields("nm_nome").Value
            email_usuario = busca.Fields("nm_email").Value
            bday_usuario = busca.Fields("dt_nascimento").Value
            cat_usuario = busca.Fields("cd_categoria").Value
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
    <form name="alteracao" id="alteracao_form" method="post" action="actions/alterarDados.asp?id=<%= id %>" onSubmit="return ValidarCadastro()" enctype="multipart/form-data">
        <p>Nome de usuário:</p>
        <input type="text" name="username" placeholder="Nome do usuário..." maxlength="60" value="<% Response.Write nome_usuario %>" >
        <p>Email:</p>
        <input type="email" name="useremail" placeholder="fulano@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" 
         value="<% Response.Write email_usuario %>" maxlength="60"> 
        <p>Data de nascimento:</p>
        <input type="text" name="userbday" placeholder="DD/MM/AAAA" maxlength="10" pattern="^[0-3]?[0-9]\/[01]?[0-9]\/[12][90][0-9][0-9]$" value="<% Response.Write FormataData(bday_usuario,2) %>">
        <p>Foto (upload):</p>        
        <input type="file" accept="image/*" name="userphoto">
        <br>
        <% 
            if foto_usuario <> "" then
                Response.Write "<img src='" & cfg_usuariospath & id & "/thumb/" & foto_usuario & "'>" 
                Response.Write "<input type='hidden' name='useroldphoto' value='" & foto_usuario & "'>"
            else
                Response.Write "<br><strong>Usuário ainda não tem foto.</strong><br>"
            end if 
        %>
        <br>
        <p>Categoria:</p>
        <select name="usercategory" id="usercategory">

            <%
                sql = "SELECT nm_nome, cd_id FROM tb_categoria"
                Set resul = buscarSQL(sql)
                if resul.RecordCount > 0 then
                    Response.Write "<option value='0'>Selecione uma categoria</option>"
                     do until resul.EOF
                        Dim id_categoria, nome
                        id_categoria = resul.Fields("cd_id").Value
                        id_categoria = CInt(id_categoria)
                        nome = resul.Fields("nm_nome").Value
                        Response.Write "<option value='" & id_categoria & "'" 
                            if id_categoria = CInt(cat_usuario) then
                                Response.Write " selected"
                            end if
                        Response.Write ">" & nome & "</option>"
                        
                        resul.MoveNext
                    loop
                    resul.Close
                else
                    Response.Write "<option value='0' selected>Selecione uma categoria</option>"
                end if

            %>
        </select>

        <br>
        <input type="submit" value="Alterar">       
    </form>
	
	<div id="erro">
		
	</div>
<%
     End If
    On Error GoTo 0
%>
</body>
</html>