package br.ce.ufc.gal.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import br.ce.ufc.gal.conexao.ConexaoBanco;

public class BibliografiaDAO {
	public void vincularBibliografia(String id_disciplina, List<String> titulo_id, List<String> titulo_tipo) throws SQLException, Exception{
		Connection connection;
		connection = ConexaoBanco.AbrirConexao();
		deletarTodasVinculadasADisciplina(id_disciplina);
		for(int i=0;i<titulo_id.size();i++){ 
			//if(jaEstaVinculado(id_disciplina, titulo_id.get(i)) == false)
			//{
			String sql = "INSERT INTO bibliografias (id_disciplina,id_titulo,tipo_bibliografia) VALUES ("+ id_disciplina +", "+ titulo_id.get(i) +", '"+ titulo_tipo.get(i) +"');";
			try {
				System.out.println(sql);
				connection = ConexaoBanco.AbrirConexao();
				ConexaoBanco.executeInsert(connection, sql);
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			}
		//}

	}
	
	public JSONArray listarBibliografiaBasica(int id) {
		Connection connection;
		
		String sql="SELECT titulos.id_t, titulos.isbn, titulos.nome_titulo FROM bibliografias, titulos WHERE bibliografias.id_disciplina = '"+id+"' AND bibliografias.id_titulo = titulos.id_t AND bibliografias.tipo_bibliografia = 'Básica' ORDER BY titulos.nome_titulo ASC;";
		String isbn;
		String nome_titulo;
		String id_t;
		
		JSONArray arrayObj = new JSONArray();
		
		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			
			while (rs.next()) {
				JSONObject titulo = new JSONObject();
				isbn = (rs.getString("isbn"));
				nome_titulo = (rs.getString("nome_titulo"));
				id_t = (rs.getString("id_t"));
				titulo.put("isbn",isbn);
				titulo.put("nome",nome_titulo);
				titulo.put("id_t",id_t);
				arrayObj.put(titulo);
				
			}
		rs.close();
		pstm.close();
		


} catch (SQLException e) {
	e.printStackTrace();
} catch (Exception e) {
	e.printStackTrace();

}
		
		return arrayObj;
	}
	
	public JSONArray listarBibliografiaComplementar(int id) {
		Connection connection;
		
		String sql="SELECT titulos.id_t, titulos.isbn, titulos.nome_titulo FROM bibliografias, titulos WHERE bibliografias.id_disciplina = "+id+" AND bibliografias.id_titulo = titulos.id_t AND bibliografias.tipo_bibliografia = 'Complementar' ORDER BY titulos.nome_titulo ASC;";
		String isbn;
		String nome_titulo;
		String id_t;
		
		JSONArray arrayObj = new JSONArray();
		
		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();
			
			while (rs.next()) {
				JSONObject titulo = new JSONObject();
				isbn = (rs.getString("isbn"));
				nome_titulo = (rs.getString("nome_titulo"));
				id_t = (rs.getString("id_t"));
				titulo.put("isbn",isbn);
				titulo.put("nome",nome_titulo);
				titulo.put("id_t",id_t);
				arrayObj.put(titulo);
				
			}
		rs.close();
		pstm.close();
		


} catch (SQLException e) {
	e.printStackTrace();
} catch (Exception e) {
	e.printStackTrace();

}
		
		return arrayObj;
	}
	
	public boolean jaEstaVinculado(String id_disciplina, String titulo_id){
		Connection connection;
		int quantidade = 0;
		String sql = "SELECT id_b FROM bibliografias WHERE id_disciplina ='"+id_disciplina+"' AND id_titulo='"+titulo_id+"';";
		
		try{
			connection = ConexaoBanco.AbrirConexao();
			System.out.println(sql);
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
		
		if(quantidade==0){
			return false;
		}else{
			return true;
		}
	}
	
	public void deletarTodasVinculadasADisciplina(String id_disciplina) throws SQLException, Exception{
		Connection connection;
		connection = ConexaoBanco.AbrirConexao();
			String sql = "DELETE FROM bibliografias WHERE id_disciplina='"+id_disciplina+"';";
			try {
				System.out.println(sql);
				connection = ConexaoBanco.AbrirConexao();
				ConexaoBanco.executeInsert(connection, sql);
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
}
