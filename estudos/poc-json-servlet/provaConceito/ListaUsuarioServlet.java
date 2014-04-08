package provaConceito;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;


@WebServlet("/ListaUsuarioServlet")
public class ListaUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ListaUsuarioServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection connection;
		String sql="SELECT nome,sobrenome FROM usuario";
		String nome,sobrenome;
		JSONArray arrayObj = new JSONArray();
		try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();
				
				while (rs.next()) {
					List<String> usuarios = new ArrayList<String>();
					nome = (rs.getString("nome"));
					sobrenome = (rs.getString("sobrenome"));
					usuarios.add(nome);
					usuarios.add(sobrenome);
					arrayObj.put(usuarios);
					
				}// fim do while
				rs.close();
				pstm.close();
				

		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		}
		
		//RequestDispatcher rd = request.getRequestDispatcher("listarUsuario.jsp");
		//rd.forward(request, response);
		PrintWriter out = response.getWriter();
		//try{
			//for(int i=0;i<arrayObj.length();i++){
				//out.println(arrayObj.getString(i));
				//out.println("<br />");
			//}
		//}catch(Exception e){
			//e.getMessage();
			//e.getStackTrace();
		//}
		out.print(arrayObj);
	}
}
