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

i = 0
'Response.Write upl.Form("usercategory[]")
if (categoria) = "" then
	Response.Write  "Vazio"
else
	Response.Write "tem coisa"
end if
for each categoria in upl.FormEx("usercategory[]")
	Response.Write categoria & "<br>"
	i = i + 1
next
	
%>