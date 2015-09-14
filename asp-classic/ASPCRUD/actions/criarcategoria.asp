<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<%
  	ct_name = Request.Form("categoryname")
    
    if trim(ct_name) <> "" then
      	novacat = "INSERT INTO tb_categoria (nm_nome) VALUES ('" & ct_name & "')" 
       	insert_cat = CreUpSQL(novacat)
       	Response.Redirect "../categorias.asp?e=8"
    else 
    	Response.Redirect "../categorias.asp?e=1"
    end if
 
%>