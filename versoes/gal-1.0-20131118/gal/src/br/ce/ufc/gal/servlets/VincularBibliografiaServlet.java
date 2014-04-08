package br.ce.ufc.gal.servlets;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.BibliografiaDAO;


@WebServlet("/VincularBibliografia")
public class VincularBibliografiaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public VincularBibliografiaServlet() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> titulo_nome = new ArrayList<String>();
		List<String> titulo_tipo = new ArrayList<String>();
		BibliografiaDAO bibliografias = new BibliografiaDAO();
		String id_disciplina = request.getParameter("id_disciplina");
		System.out.println(id_disciplina);
		
		for (int i = 0; i < Integer.MAX_VALUE; i++) {
		    String titulos_vinculados_id = request.getParameter("titulos[" + i + "][titulo_id]");
		    String titulos_vinculados_tipo = request.getParameter("titulos[" + i + "][titulo_tipo]");
		    if (titulos_vinculados_id == null) {
		        break;
		    }
		    titulo_nome.add(titulos_vinculados_id);
		    System.out.println(titulos_vinculados_id);
		    titulo_tipo.add(titulos_vinculados_tipo);
		    System.out.println(titulos_vinculados_tipo);
		}
		try {
			bibliografias.vincularBibliografia(id_disciplina, titulo_nome, titulo_tipo);
			System.out.println("insert servlet");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.print("Títulos vinculados com sucesso.");
	}
}