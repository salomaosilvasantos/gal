package br.ce.ufc.gal.servlets;


import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.TitulosDAO;



/**
 * Servlet implementation class ListarDisciplinasServlet
 */
@WebServlet("/EditarTitulo")
public class EditarTituloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditarTituloServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Connection connection;
		TitulosDAO titulo = new TitulosDAO();
		
		String isbn_atual = request.getParameter("isbn_atual");
		String isbn = request.getParameter("isbn");
		String nome_titulo = request.getParameter("nome_titulo");
		String tipo_titulo = request.getParameter("tipo");
		System.out.println("debug isbn atual" +isbn_atual + "isbn" + isbn + "nome" +nome_titulo + "tipo" +tipo_titulo);
		titulo.editarTitulo(isbn_atual, isbn, nome_titulo, tipo_titulo);
		
		
		
		response.sendRedirect("listarTitulos.html");
		
	}
}
