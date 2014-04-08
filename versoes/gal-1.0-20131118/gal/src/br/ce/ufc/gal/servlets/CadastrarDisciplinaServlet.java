package br.ce.ufc.gal.servlets;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.DisciplinaDAO;


@WebServlet("/CadastrarDisciplina")
public class CadastrarDisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public CadastrarDisciplinaServlet() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DisciplinaDAO dis = new DisciplinaDAO();
		
		int semestre_oferta = 1;
		int quant_aluno = 0;
		String codigo = request.getParameter("codigo");
		String nome_disciplina = request.getParameter("nome_disciplina");
		semestre_oferta = Integer.parseInt(request.getParameter("semestre_oferta"));
		String quantidade = request.getParameter("quantidade_aluno");
		if(!quantidade.equals("")){
			quant_aluno = Integer.parseInt(quantidade);
		}
	
		
		
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		if(dis.quantidadeDeDisciplinasExistentesPorNome(nome_disciplina) > 0 && dis.quantidadeDeDisciplinasExistentesPorCodigo(codigo) > 0){
			out.print("Código "+codigo + " e nome " + nome_disciplina + " já existem.");
		}else if(dis.quantidadeDeDisciplinasExistentesPorNome(nome_disciplina)>0){
			out.print("Nome " + nome_disciplina + " já existe.");
		}else if(dis.quantidadeDeDisciplinasExistentesPorCodigo(codigo)>0){
			out.print("Código " + codigo + " já existe.");
		}else{
			dis.cadastrarDisciplina(codigo, nome_disciplina, semestre_oferta, quant_aluno);
			out.print("Disciplina " + nome_disciplina + " cadastrada com sucesso.");	
		}
	}

}
