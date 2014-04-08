package br.ufc.gal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.ufc.gal.pojo.Titulo;

public class ExemplarDAO {

	public static boolean cadastra(Connection conexao, Titulo titulo) throws SQLException {
		boolean sucess = false;
		String sql_insert = "insert into exemplares (id_titulo_pk, codigo_exemplar_pk) values (?, ?)";
		
		PreparedStatement pst = conexao.prepareStatement(sql_insert);
		
		for (String codigo : titulo.getCodigo_exemplar()) {
			pst.setInt(1, titulo.getId_titulo_pk());
			pst.setString(2, codigo);
			pst.executeUpdate();
		}
		
		sucess = true;

		return sucess;
	}
}
