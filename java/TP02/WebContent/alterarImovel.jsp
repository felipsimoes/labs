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
<title>Alterar Imóvel</title>
</head>
<body>
	<% Imovel imovel = (Imovel) request.getAttribute("imovel"); %>
    <div class="container">
    <p><a class="btn btn-primary" href='index.jsp'>Voltar para o início</a></p>
    <h3>Alterar Imóvel</h3><br>
    <form class="form" action="AlterarImovel" name="form" method="post">
    	<div class="form-group row">
    		<label for="endereco" class="col-sm-2 col-form-label">Endereço:</label>
       		<div class="col-sm-10">
	       		<input type="text" name="endereco" value="<% out.print(imovel.getEndereco()); %>">
       		</div>
    	</div>
    	<div class="form-group row">
    		<label for="metros" class="col-sm-2 col-form-label">Metros²:</label>
       		<div class="col-sm-10">
        	 	<input type="number" name="metros" min="50" max="1000" step="10" value="<% out.print(imovel.getMetrosQuadrados()); %>">
       		</div>
     	</div>
       		<div class="form-group row">
    		<label for="quartos" class="col-sm-2 col-form-label">Qtd. Quartos:</label>
       		<div class="col-sm-10">
		        <input type="number" name="quartos" min="0" max="10" value="<% out.print(imovel.getNumQuartos()); %>">
       		</div>
   		</div>	
   		<div class="form-group row">
    		<label for="valor" class="col-sm-2 col-form-label">Valor de Locação: </label>
       		<div class="col-sm-10">
        		<input type="number" name="valor" pattern="^\d+(\.|\,)\d{2}$" min="250,00" step="10,00" value="<% out.print(imovel.getValorLocacao()); %>">
        	</div>
        </div>
        <input type="hidden" name="id" value="<% out.print(imovel.getCd()); %>">
        
        <div class="form-group row">
      		<div class="offset-sm-2 col-sm-10">
        		<button type="submit" class="btn btn-primary">Alterar</button>
      		</div>
    	</div>
    
    </form>
    </div>
</body>
</html>