<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<%
    Dim id
    id = Request.QueryString("id")

    if id <> "" then
    	ct_name = Request.Form("categoryname")

        if trim(ct_name) <> "" then
        	upcat = "UPDATE tb_categoria SET nm_nome = '" & ct_name & "' WHERE cd_id = " & id
        	update_cat = CreUpSQL(upcat)

        	Response.Redirect "../categorias.asp?e=2"

        else
            Response.Redirect "../categorias.asp?e=3"
        end if

    else 
    	Response.Redirect "../categorias.asp?e=1"
    end if
 
%>