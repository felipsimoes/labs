<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="bd.ConexaoBD"%>
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
<title>Tela principal</title>
<style>
thead {color:blue;}
table, th, td {
    border: 1px solid black;
    padding: 3px;
}
table {
	margin: 10px;
    border-collapse: collapse;
}
#botao {
	margin: 10px;
}

#botao.a {
	border: 1px solid black;
}
</style>
</head>
<body>
	<div class="container">
	<h2>Op��es Im�vel</h2>
	<div id="botao">
		<a class="btn btn-primary" href="inserirImovel.jsp" role="button">Inserir Novo Im�vel</a>
	</div>
	<% Connection con  = (Connection)ConexaoBD.getConexao();
		String sql = "SELECT * FROM imovel ";	
		PreparedStatement p = con.prepareStatement(sql);
		ResultSet result = p.executeQuery(); 
		if(result.next()) {
			out.println("<table>");
			out.println("<thead>Lista de im�veis");
			out.println(" <tr>");
			out.println("  <th>Endere�o</th>");
			out.println("  <th>Metros quadrados</th>");
			out.println("  <th>Qtd. quartos</th>");
			out.println("  <th>Valor loca��o</th>");
			out.println("  <th colspan='2'>Op��es</th>");
			out.println(" </tr>");
			out.println("</thead>");
			out.println("<tbody>");
	
			result.beforeFirst();
	    	while(result.next()){
	    		out.print("<tr>");
	    		out.print("<th>"+ result.getString("endereco") +"</th>");
	    		out.print("<th>"+ result.getInt("metros") +"</th>");
	    		out.print("<th>"+ result.getInt("quartos") +"</th>");
	    		out.print("<th>"+ result.getDouble("valor") +"</th>");
	    		out.print("<th> <a href='AlterarImovel?id="+ result.getInt("cd") +"'>Alterar</a></th>");
	    		out.print("<th> <a href='ExcluirImovel?id="+ result.getInt("cd") +"'>Excluir</a></th>");
	    		out.print("</tr>");
	    	} 
		}
			
		else{
			out.println("Nenhum im�vel registrado");
	    }
    	con.close();
   		 %>
    	</tbody>
    </table>
    </div>
</body>
</html>