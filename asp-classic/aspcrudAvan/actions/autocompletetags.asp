<%@Language="VBScript" CodePage = 65001 %>
<!-- #include file="../sys/codebase.asp" -->
<%
'Realiza busca de todas as tags'
Set buscatags = buscarSQL("SELECT * FROM tb_tag t")

'percorre o resultset de buscatags'
if buscatags.RecordCount > 0 then
	'Define o tamanho do RecordCount
	'Define o tamanho de linhas necessárias para a matriz
	'	Que será um a menos que o tamanho do record count
	'Define o tamanho da matriz autocompletiondata com 2 colunas (0 e 1)
	tamanhoRecordCount = buscatags.RecordCount
	tamanhoLinhas = tamanhoRecordCount - 1
	''tamanhoLinhas = 26  'CInt(tamanhoLinhas)
	ReDim autocompletiondata(tamanhoLinhas,1)
	Dim id_tag, nome, i
    i = 0
    do until buscatags.EOF
        
        id_tag = buscatags.Fields("cd_id").Value
        nome = buscatags.Fields("nm_nome").Value
			
			autocompletiondata(i,0) = id_tag 
			autocompletiondata(i,1) = nome

		i = i + 1	        
        buscatags.MoveNext
    loop
end if
if( not IsEmpty(Request.QueryString("term")) ) then 

    ReDim result(tamanhoLinhas)

    for i=0 to UBound(result)
        if(Len(Request.QueryString("term")) <> 0 AND InStr(autocompletiondata(i,1),Request.QueryString("term")) <> 0 ) then 
            Dim mystring, id
            id = autocompletiondata(i,0)
            mystring = "{" & chr(34)& "id" & chr(34) &":" & CStr(id) 
            mystring = mystring & "," & chr(34) & "label" & chr(34) & ":" & chr(34) & autocompletiondata(i,1) & chr(34) & ","
            mystring = mystring & chr(34) & "value" & chr(34) & ":" & chr(34) & autocompletiondata(i,1) & chr(34) & "}"
            result(i) = mystring
        end if
    next 
   
    
    Response.Write "["
    flag_virgula = -1
    for i=0 to UBound(result)
     if result(i) <> "" then
     	if i < UBound(result) AND flag_virgula = 0 then
    		Response.Write "," 
    	end if
    	Response.Write result(i)
    	flag_virgula = 0	
     end if
    next 
	Response.Write "]"

    
end if
%>