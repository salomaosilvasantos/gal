package br.ufc.gal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufc.gal.pojo.Titulo;

public class TituloDAO {

	public static boolean cadastra(Connection conexao, Titulo titulo) throws SQLException {
		boolean sucess = false;
		String sql_insert = "insert into titulos (isbn, nome_titulo, tipo_titulo) values (?, ?, ?)";

		PreparedStatement pst = conexao.prepareStatement(sql_insert);
		pst.setString(1, titulo.getIsbn());
		pst.setString(2, titulo.getNome());
		pst.setString(3, titulo.getTipo());
		pst.executeUpdate();
		sucess = true;

		return sucess;
	}
	
public static List<Titulo> listarTodos(Connection conexao) {
		
		String sql_select = "select * from titulos";
		List<Titulo> titulos = null;
		ResultSet res;
		titulos = new ArrayList<Titulo>();
		try {
			PreparedStatement pst = conexao.prepareStatement(sql_select);
			res = pst.executeQuery();
			
			while (res.next()) {
				Titulo titulo = new Titulo();
				titulo.setId_titulo_pk(res.getInt("id_titulo_pk"));
				titulo.setIsbn(res.getString("isbn"));
				titulo.setNome(res.getString("nome_titulo"));
				titulo.setTipo(res.getString("tipo_titulo"));
				
				titulos.add(titulo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return titulos;		
	}
	
	public static Titulo listarPorIsbn(String isbn, Connection conexao) {
		
		String sql_select = "select * from titulos where isbn = ?";
		Titulo titulo = null;
		ResultSet res;
		
		try {
			PreparedStatement pst = conexao.prepareStatement(sql_select);
			pst.setString(1, isbn);
			res = pst.executeQuery();
			
			while (res.next()) {
				titulo = new Titulo();
				titulo.setId_titulo_pk(res.getInt("id_titulo_pk"));
				titulo.setIsbn(res.getString("isbn"));
				titulo.setNome(res.getString("nome_titulo"));
				titulo.setTipo(res.getString("tipo_titulo"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return titulo;		
	}
}
