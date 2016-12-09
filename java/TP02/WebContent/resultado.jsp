<%@page import="servlets.Imovel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<title>Imóvel Inserido</title>
</head>
<body>
	<div class="container">
	<p><a class='btn btn-primary btn-lg' href='index.jsp'>Voltar para o início</a></p>
	<h2>Novo imóvel</h2>
        <%
            Imovel imovel = (Imovel) request.getAttribute("imovel");

            out.println("<h3> Endereço: " + imovel.getEndereco() + "</h3>");
            out.println("<h3> Metros quadrados: " + imovel.getMetrosQuadrados() + "</h3>");
            out.println("<h3> Qtd. Quartos: " + imovel.getNumQuartos()+ "</h3>");
            out.println("<h3> Valor locação: R$ " + imovel.getValorLocacao()+ "</h3>");
        %>
	</div>
    </body>
</body>
</html>