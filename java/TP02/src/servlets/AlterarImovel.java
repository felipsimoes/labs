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
 * Servlet implementation class AlterarImovel
 */
public class AlterarImovel extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AlterarImovel() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("id") != null) {

			int id = Integer.valueOf(request.getParameter("id"));
			Imovel im = new Imovel();
			im.setCd(id);

			DAO dao = new DAO();
			try {
				im = dao.getImovelPorId(im);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			request.setAttribute("imovel", im);

			RequestDispatcher rd = request.getRequestDispatcher("alterarImovel.jsp");

			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int id = Integer.valueOf(request.getParameter("id"));

		RequestDispatcher rd;
		DAO dao = new DAO();

		String end = request.getParameter("endereco");
		int metros = Integer.valueOf(request.getParameter("metros").trim());
		int quartos = Integer.valueOf(request.getParameter("quartos").trim());
		int valor = Integer.valueOf(request.getParameter("valor").trim());

		Imovel imovel = new Imovel(end, metros, quartos, valor);
		imovel.setCd(id);

		try {
			boolean alterado = dao.alterarImovel(imovel);
			if(alterado){
				request.setAttribute("imovel", imovel);
				rd = request.getRequestDispatcher("alterarImovel.jsp");
			}else{
				rd = request.getRequestDispatcher("index.jsp?erro=1");
			}
		} catch (SQLException e) {
			System.out.println(e.getSQLState());
			rd = request.getRequestDispatcher("index.jsp?erro=2");
		}

		rd.forward(request, response);
	}

}
