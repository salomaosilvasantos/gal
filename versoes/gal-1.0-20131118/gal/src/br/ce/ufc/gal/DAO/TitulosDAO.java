package br.ce.ufc.gal.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import br.ce.ufc.gal.conexao.ConexaoBanco;

public class TitulosDAO {
	
	
	//cadastrar titulo
	public void cadastrarTitulos(String isbn, String nome, String tipo){
		
		Connection connection;
		String sql = "INSERT INTO titulos (isbn,nome_titulo,tipo_titulo) VALUES ('"+ isbn +"','"+ nome +"','"+ tipo +"')";
		
		try {
			
			connection = ConexaoBanco.AbrirConexao();
			ConexaoBanco.executeInsert(connection, sql);
			connection.close();
			
			

	
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	
	}
	}
	
	public void editarTitulo(String isbn_atual, String isbn, String nome_titulo, String tipo_titulo){
		Connection connection;
		
		String sql = "UPDATE titulos SET isbn='"+ isbn +"', nome_titulo='"+ nome_titulo +"', tipo_titulo='"+ tipo_titulo +"' WHERE isbn='"+ isbn_atual +"'";

		try {
			
			connection = ConexaoBanco.AbrirConexao();
			ConexaoBanco.executeQuery(connection, sql);
			
			connection.close();
			

	
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	
	}
		
	}
	
	//listar titulo
	public JSONArray listarTitulos(){
		Connection connection;
		String sql="SELECT id_t,isbn,nome_titulo,tipo_titulo FROM titulos ORDER BY nome_titulo ASC";
		
		String isbn;
		String nome_titulo;
		String tipo_titulo;
		String id_t;
		
		JSONArray arrayObj = new JSONArray();
		
		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			
			while (rs.next()) {
				JSONObject titulo = new JSONObject();
				id_t = (rs.getString("id_t"));
				isbn = (rs.getString("isbn"));
				nome_titulo = (rs.getString("nome_titulo"));
				tipo_titulo = (rs.getString("tipo_titulo"));
				titulo.put("id_t",id_t);
				titulo.put("isbn",isbn);
				titulo.put("nome",nome_titulo);
				titulo.put("tipo",tipo_titulo);
			//	System.out.println(isbn + " " + nome_titulo + " " + tipo_titulo);
				arrayObj.put(titulo);
				
			}
			rs.close();
			pstm.close();
			connection.close();

	
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	
	}
		
		return arrayObj;
	}

	public void deleteTitulo(String isbn) throws SQLException, Exception{
		Connection connection;
		
		String sql = "DELETE FROM titulos WHERE isbn ='"+isbn+"'";
		System.out.println(sql);
		
			connection = ConexaoBanco.AbrirConexao();
			ConexaoBanco.executeUpdate(connection, sql);
			connection.close();
		
	}
	
	public int quantidadeDeTitulosExistentesPorNome(String nome_titulo){
		Connection connection;
		int quantidade = 100;
		String sql = "SELECT COUNT(nome_titulo) FROM titulos WHERE nome_titulo ='"+nome_titulo+"'";
		
		try{
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
				quantidade = (rs.getInt(1));
			}
			rs.close();
			pstm.close();
			connection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return quantidade;
	}
	
	public int quantidadeDeTitulosExistentesPorIsbn(String isbn){
		Connection connection;
		int quantidade = 100;
		String sql = "SELECT COUNT(isbn) FROM titulos WHERE isbn ='"+isbn+"'";
		
		try{
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			while(rs.next()){
				quantidade = (rs.getInt(1));
			}
			rs.close();
			pstm.close();
			connection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return quantidade;
	}

	public String getIdPorNome(String nome){
		Connection connection;
		String sql = "SELECT id_t FROM titulos WHERE nome_titulo ='"+nome+"';";
		String id = "";
		try{
			System.out.println(sql);
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			while(rs.next()){
				id = (rs.getString("id_t"));
			}
			rs.close();
			pstm.close();
			connection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
}
