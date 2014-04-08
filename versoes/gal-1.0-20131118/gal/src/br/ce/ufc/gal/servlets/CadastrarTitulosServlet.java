package br.ce.ufc.gal.servlets;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.TitulosDAO;

/**
 * Servlet implementation class CadastrarTitulos
 */
@WebServlet("/CadastrarTitulos")
public class CadastrarTitulosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public CadastrarTitulosServlet() {
        	super();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TitulosDAO titulo = new TitulosDAO();
		
		String isbn = request.getParameter("isbn_titulo");
		String nome_titulo = request.getParameter("nome_titulo");
		String tipo_titulo = request.getParameter("tipo");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		if(titulo.quantidadeDeTitulosExistentesPorNome(nome_titulo) > 0 && titulo.quantidadeDeTitulosExistentesPorIsbn(isbn) > 0){
			out.print("ISBN "+isbn + " e nome " + nome_titulo + " já existem.");
		}else if(titulo.quantidadeDeTitulosExistentesPorNome(nome_titulo)>0){
			out.print("Nome " + nome_titulo + " já existe.");
		}else if(titulo.quantidadeDeTitulosExistentesPorIsbn(isbn)>0){
			out.print("ISBN " + isbn + " já existe.");
		}else{
			titulo.cadastrarTitulos(isbn, nome_titulo, tipo_titulo);
			out.print("Título " + nome_titulo + " cadastrado com sucesso.");	
		}
	}

	
}