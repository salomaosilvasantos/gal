package provaConceito;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import provaConceito.ConexaoBanco;
/**
 * Servlet implementation class CadastroUsuarioServlet
 */
@WebServlet("/CadastroUsuarioServlet")
public class CadastroUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html;charset=UTF-8");
		        PrintWriter out = response.getWriter();
		        try {
		            
		        	String Nome = request.getParameter("nome");
		            String Sobrenome = request.getParameter("sobrenome");
		            
		            String query = "insert into usuario (Nome, Sobrenome) "
		                    + "values ('"+ Nome + "', '" + Sobrenome + "')";

		            Connection conn = ConexaoBanco.AbrirConexao();

		            ConexaoBanco.executeInsert(conn, query);

		            conn.close();
		            
		        }catch(SQLException sqlEx){
		            out.println(sqlEx.getMessage());
		            sqlEx.printStackTrace();
		        }catch(Exception ex){
		            out.println(ex.getMessage());
		            ex.printStackTrace();
		        } finally { 
		            out.close();
		        }
		    } 

	    @Override
		    protected void doGet(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        processRequest(request, response);
		    } 

	    @Override
		    protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        processRequest(request, response);
		    }

		    @Override
		    public String getServletInfo() {
		        return "Short description";
		    }
}
