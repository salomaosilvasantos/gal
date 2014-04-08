package br.ce.ufc.gal.servlets;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import br.ce.ufc.gal.DAO.DisciplinaDAO;


/**
 * Servlet implementation class ListarDisciplinasServlet
 */
@WebServlet("/ListarDisciplinasServlet")
public class ListarDisciplinasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ListarDisciplinasServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Connection connection;
		DisciplinaDAO disciplina = new DisciplinaDAO();
		
		JSONArray arrayObj = disciplina.listarDisciplina();
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(arrayObj);
		
	}
}
