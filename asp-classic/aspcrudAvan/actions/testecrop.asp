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


sub ThumbCriado(x, y, w, h, caminho, caminho_novo, nome_arquivo)
		'Cria a instância com o objeto Persits.Jpeg
		Set ImgObj = Server.CreateObject("Persits.Jpeg")
		
		'Busca a imagem a ser redimensionada
		ImgObj.Open caminho & nome_arquivo
		
		call ImgObj.crop (x, y, x+w, y+h)
			
		ImgObj.Save caminho_novo & "thumb" &nome_arquivo
		Set ImgObj = Nothing

		'Cria a instância com o objeto ObjFile
		Dim fso				
		Set fso = CreateObject("Scripting.FileSystemObject")

		'Move o arquivo da pasta atual para a pasta informada
		fso.CopyFile caminho & nome_arquivo, caminho_novo
		'fso.MoveFile caminho & nome_arquivo, caminho_novo & nome_novo

		'Elimina variável da memória 
		Set fso = Nothing	
end sub

		caminho = filespath
		upl.Path = caminho
		upl.SaveAs foto
	 x = Cint(upl.form("X"))
	 y = Cint(upl.form("Y"))
	 w = Cint(upl.form("W"))
	 h = Cint(upl.form("H"))

		call ThumbCriado(x,y,w,h,caminho,caminho, foto)

%>