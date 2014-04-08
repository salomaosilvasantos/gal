package br.ce.ufc.gal.servlets;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import br.ce.ufc.gal.DAO.BibliografiaDAO;


@WebServlet("/ListarBibliografiaBasica")
public class ListarBibliografiaBasicaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public ListarBibliografiaBasicaServlet() {
        super();
       
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	int id = Integer.parseInt(request.getParameter("id_d"));
    	
		BibliografiaDAO bibliografia = new BibliografiaDAO();
		JSONArray arrayObj = bibliografia.listarBibliografiaBasica(id);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(arrayObj);
		

	}

}
