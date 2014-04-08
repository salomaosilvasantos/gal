package br.ce.ufc.gal.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import br.ce.ufc.gal.conexao.ConexaoBanco;

public class DisciplinaDAO {

	
	public void cadastrarDisciplina(String codigo, String nome, int semestre, int quantidadeAluno){
		Connection connection;
		
		String sql = "INSERT INTO disciplinas (cod_d,nome, qtd_alunos, semestre_oferta) VALUES ('"+ codigo +"','"+ nome +"','"+quantidadeAluno+"','"+semestre+"')";
		
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
	
	public void editarDisciplina(String codigo_atual, String codigo, String nome, int semestre, int quantidadeAluno){
		Connection connection;
		
		String sql = "UPDATE disciplinas SET cod_d='"+ codigo +"', nome='"+ nome +"', qtd_alunos='"+ quantidadeAluno +"', semestre_oferta='"+ semestre +"' WHERE cod_d='"+ codigo_atual +"'";

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
	
	public void deleteDisciplina(String codigo) throws SQLException, Exception{
		
		Connection connection;
		
		String sql = "DELETE FROM disciplinas WHERE cod_d ='"+codigo+"'";
		System.out.println(sql);
		
			connection = ConexaoBanco.AbrirConexao();
			ConexaoBanco.executeUpdate(connection, sql);
			connection.close();
			

	
		
	}
	

	public JSONArray listarDisciplina() {
		Connection connection;
		
		String sql="SELECT id_d,cod_d,nome,semestre_oferta,qtd_alunos FROM disciplinas ORDER BY cod_d ASC";
		String codigo_disciplina,nome_disciplina,semestre_oferta,quantidade_aluno, id_d;
		JSONArray arrayObj = new JSONArray();
		
		try {
		connection = ConexaoBanco.AbrirConexao();
		PreparedStatement pstm = connection.prepareStatement(sql);
		ResultSet rs = pstm.executeQuery();
		
		while (rs.next()) {
			
			JSONObject disciplina = new JSONObject();
			codigo_disciplina = (rs.getString("cod_d"));
			id_d = (rs.getString("id_d"));
			nome_disciplina = (rs.getString("nome"));
			semestre_oferta = (rs.getString("semestre_oferta"));
			quantidade_aluno = (rs.getString("qtd_alunos"));
			disciplina.put("id_d", id_d);
			disciplina.put("codigo",codigo_disciplina);
			disciplina.put("nome",nome_disciplina);
			disciplina.put("semestre_oferta", semestre_oferta);
			disciplina.put("quantidade_aluno", quantidade_aluno);
			arrayObj.put(disciplina);
			
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

	
	public int quantidadeDeDisciplinasExistentesPorNome(String nome){
		Connection connection;
		int quantidade = 100;
		String sql = "SELECT COUNT(nome) FROM disciplinas WHERE nome ='"+nome+"'";
		
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
	
	public int quantidadeDeDisciplinasExistentesPorCodigo(String codigo){
		Connection connection;
		int quantidade = 100;
		String sql = "SELECT COUNT(cod_d) FROM disciplinas WHERE cod_d ='"+codigo+"'";
		
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
	
	
		
}
