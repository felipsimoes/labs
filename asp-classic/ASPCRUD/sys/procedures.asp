<% 
sub buscarStatus()

	sql = "SELECT bl_conectado FROM tb_usuario WHERE cd_id = " & Session("cd_id") 

	Set res = buscarSQL(sql)

	if res.EOF <> - 1 then
		Session("logado") = res("bl_conectado")
	end if

	checarLogin()
end sub

sub checarLogin()
	if Session("logado") = 0 then
		Response.Redirect("default.asp?e=1")
		Session.Abandon
	end if 
end sub

'Procedure reduz imagem
'Obs.: Aumento da imagem não é esperado
sub redimensionarImagem(altura, largura, caminho, caminho_novo, nome_arquivo)
		If IsNumeric(largura) And IsNumeric(altura) Then
			'Cria a instância com o objeto Persits.Jpeg
			Set ImgObj = Server.CreateObject("Persits.Jpeg")
			
			width_img  = largura
			height_img = altura
			
			'Busca a imagem a ser redimensionada
			ImgObj.Open caminho & nome_arquivo
			
			'Checa se as dimensões da imagem original são diferentes dos parâmetros
			'Function CInt converte valor para inteiro
			If width_img <> Cint(ImgObj.OriginalWidth) and height_img <> Cint(ImgObj.OriginalHeight) Then 
				'Checa se os parâmetros são menores que as dimensões originais	
				If Cint(ImgObj.OriginalHeight) > height_img Or Cint(ImgObj.OriginalWidth) > width_img Then
					'Caso a altura original seja maior que a largura
					If Cint(ImgObj.OriginalHeight) > Cint(ImgObj.OriginalWidth) Then
						'A altura da nova imagem é igual ao parametro de altura
						ImgObj.Height  = height_img
						'A largura da nova imagem é proporcional a
						'(largura original * altura nova) / altura original
						ImgObj.Width   = cint((ImgObj.OriginalWidth * ImgObj.Height)/ImgObj.OriginalHeight)
					'Caso a largura original seja maior que a altura
					Else
						ImgObj.Width   = width_img
						'A largura da nova imagem é proporcional a
						'(altura original * largura nova) / largura original
						ImgObj.Height  = cint((ImgObj.OriginalHeight * ImgObj.Width)/ImgObj.OriginalWidth)
					End If
				End if
				
				ImgObj.Quality = 100
				'ImgObj.Sharpen 1,150
				
				ImgObj.Save caminho_novo & nome_arquivo
				Set ImgObj = Nothing

			'Caso as dimensões originais e os parâmetros sejam iguais a imagem é simplesmente copiada
			'para o diretório especificado
			Else
				'Cria a instância com o objeto ObjFile
				Dim fso				
				Set fso = CreateObject("Scripting.FileSystemObject")

				'Move o arquivo da pasta atual para a pasta informada
				fso.CopyFile caminho & nome_arquivo, caminho_novo
				'fso.MoveFile caminho & nome_arquivo, caminho_novo & nome_novo

				'Elimina variável da memória 
				Set fso = Nothing
			End If		
		End If
end sub

%>