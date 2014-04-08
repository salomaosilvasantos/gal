package br.ce.ufc.gal.servlets;

import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.TitulosDAO;

@WebServlet("/deletarTitulosServlet")
public class DeletarTitulosServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp){
			String isbn = req.getParameter("isbn");
			

			
			TitulosDAO dao= new TitulosDAO();
			try {
				dao.deleteTitulo(isbn);
				resp.setContentType("text/html");
				PrintWriter out = resp.getWriter();
				out.print("O titulo de ISBN: "+isbn+", foi deletado com sucesso.");
				
			} catch (SQLException e) {
				

			} catch (Exception e) {
				e.printStackTrace();
			}
		
	}
	

}
