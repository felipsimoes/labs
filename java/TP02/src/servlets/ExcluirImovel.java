package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAO;

/**
 * Servlet implementation class ExcluirImovel
 */
public class ExcluirImovel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExcluirImovel() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='utf-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>");
            out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' integrity='sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u' crossorigin='anonymous'>");
            out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css' integrity='sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp' crossorigin='anonymous'>");
            out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>");
            out.println("<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' integrity='sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa' crossorigin='anonymous'></script>");
            out.println("<title>Excluir Imóvel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<p><a class='btn btn-primary' role='button'  href='index.jsp'>Voltar para o início</a></p>");
            out.println("<h2>Deletar Imóvel</h2>");

            if (request.getParameter("id") != null) {
            	int cd = Integer.valueOf(request.getParameter("id")) ;
            	Imovel imovel = new Imovel();
                imovel.setCd(cd);
                
                DAO dao = new DAO();
                try {
					imovel = dao.getImovelPorId(imovel);
					
					out.println("<p>Endereço: "+imovel.getEndereco());
					out.println("<br> Qtd quartos: "+imovel.getNumQuartos());
					out.println("<br> Metros quadrados: "+imovel.getMetrosQuadrados());
					out.println("<br> Valor locação: "+imovel.getValorLocacao());
					out.println("</p><form action='ExcluirImovel' name='form' method='post'>");
					out.println("<input type='hidden' name='id' value='"+ imovel.getCd() +"'>");
					out.print("<div class='form-group row'>");
		       		out.print("<div class='offset-sm-2 col-sm-10'>");
			       	out.print("<button type='submit' class='btn btn-danger'>Confirmar Exclusão</button>");
		       		out.print("</div>");
		       		out.print("</div>");
					out.println("</form>");

                } catch (SQLException e) {
					e.printStackTrace();
					out.println("O código de imóvel é inválido!");
				}
            }
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='utf-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>");
            out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' integrity='sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u' crossorigin='anonymous'>");
            out.println("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css' integrity='sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp' crossorigin='anonymous'>");
            out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>");
            out.println("<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' integrity='sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa' crossorigin='anonymous'></script>");
            out.println("<title>Excluir Imóvel</title>");
            out.println("</head>");
            out.println("<body> <div class='container'> ");
            out.println("<p><a class='btn btn-primary btn-lg' href='index.jsp'>Voltar para o início</a></p>");
            out.println("<h2>Deletar Imóvel</h2>");

            if (request.getParameter("id") != null) {
            	int cd = Integer.valueOf(request.getParameter("id")) ;
            	Imovel imovel = new Imovel();
                imovel.setCd(cd);
                
                DAO dao = new DAO();
                try {
					boolean deletado = dao.excluirImovel(imovel);
					if(deletado){
						out.println("Imóvel excluído!");
					}else{
						out.println("Imóvel não pôde ser excluído");
					}

                } catch (SQLException e) {
					e.printStackTrace();
					out.println("Erro na operação!");
				}
            }else{
            	out.println("Um imóvel precisa ser específicado.");
            }
            out.print("</div>");
            out.println("</body>");
            out.println("</html>");
        }
	}

}
