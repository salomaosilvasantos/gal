package br.ce.ufc.gal.servlets;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.DisciplinaDAO;


/**
 * Servlet implementation class ListarDisciplinasServlet
 */
@WebServlet("/EditarDisciplina")
public class EditarDisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditarDisciplinaServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Connection connection;
		DisciplinaDAO disciplina = new DisciplinaDAO();
		
		int semestre_oferta = 1;
		int quant_aluno = 0;
		String codigo_atual = request.getParameter("codigo_atual");
		String codigo = request.getParameter("codigo");
		String nome_disciplina = request.getParameter("disciplina");
		semestre_oferta = Integer.parseInt(request.getParameter("semestre_oferta"));
		String quantidade = request.getParameter("quantidade_aluno");
		if(!quantidade.equals("")){
			quant_aluno = Integer.parseInt(quantidade);
		}
		disciplina.editarDisciplina(codigo_atual, codigo, nome_disciplina, semestre_oferta, quant_aluno);
		
		response.sendRedirect("listarDisciplinas.html");
		
	}
}
