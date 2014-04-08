package br.ce.ufc.gal.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ce.ufc.gal.DAO.DisciplinaDAO;

/**
 * Servlet implementation class DeletarDisciplinaServlet
 */
@WebServlet("/deletarDisciplinaServlet")
public class DeletarDisciplinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletarDisciplinaServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codigo = request.getParameter("codigo");
		System.out.println(codigo.toString());
		
		DisciplinaDAO disciplinaDao = new DisciplinaDAO();
		try {
			disciplinaDao.deleteDisciplina(codigo);
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("A disciplina de código: "+codigo+" , foi deletada com sucesso.");
		} catch (SQLException e) {
			request.setAttribute("test", "Msg de Teste");
			response.sendRedirect("listarDisciplinas.html");
			
			/*PrintWriter out = response.getWriter();
		    out.println("<script>");  
            out.println("alert('Senha ou Usuário inválidos!');");    
            out.println("document.location=('listarDisciplinas.html');");    
            out.println("</script>");*/  

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
