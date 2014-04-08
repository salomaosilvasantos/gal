package ufc.quixada;

import java.sql.*;
public class ConexaoBanco {

	public static Connection AbrirConexao() throws SQLException, Exception{
		String banco = "bd_gal";
		String usuario = "postgres";
		String senha = "postgres";
		String driver = "org.postgresql.Driver";
		String url = "jdbc:postgresql://localhost:5432/";
		Connection conn = null;
		
		Class.forName(driver);
		
		conn = (Connection)DriverManager.getConnection(url+ banco,usuario,senha);
		
		return conn;
	}
	 public static ResultSet executeQuery(Connection conn, String query) throws SQLException {
	        Statement sta = conn.createStatement();
	        ResultSet rs = null;

	        try {
	            rs = sta.executeQuery(query);

	        } catch (Exception err) {
	        }
	        return rs;
	    }

	    public static int executeInsert(Connection conn, String query) throws SQLException {
	        Statement stm = conn.createStatement();  
	        return stm.executeUpdate(query);
	    }
}
