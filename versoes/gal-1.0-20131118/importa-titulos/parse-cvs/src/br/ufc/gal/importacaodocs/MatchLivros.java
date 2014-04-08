package br.ufc.gal.importacaodocs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ce.ufc.gal.conexao.ConexaoBanco;

public class MatchLivros {

	/**
	 * @param args
	 */
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
	        Connection conexao = ConexaoBanco.AbrirConexao();

	        if(conexao != null){
	            System.out.println("Conexão bem sucedida");
	        }

	    }catch(Exception e){
	        System.out.println("Erro: " + e.getMessage());
	    } 
		
		testeListarTítulos();
	}
	
	public static void testeListarTítulos(){
		Connection connection;
		String sql="SELECT * FROM titulos";
		String isbn,nome_titulo,tipo_titulo;
		//JSONArray arrayObj = new JSONArray();
		
		try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();
				
				while (rs.next()) {
					List<String> titulos = new ArrayList<String>();
					isbn = (rs.getString("isbn"));
					nome_titulo = (rs.getString("nome_titulo"));
					tipo_titulo = (rs.getString("tipo_titulo"));
					titulos.add(isbn);
					titulos.add(nome_titulo);
					titulos.add(tipo_titulo);
					System.out.println(isbn + " " + nome_titulo + " " + tipo_titulo);
				//	arrayObj.put(titulos);
					
				}
				rs.close();
				pstm.close();
				

		
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		
		}
	}

}
