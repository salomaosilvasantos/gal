package br.ufc.npi.gal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.ufc.npi.gal.pojo.Titulo;

public class ExemplarDAO {

	public static boolean cadastrar(Titulo titulo, Connection conexao)
			throws SQLException {

		String sqlInsert = "insert into exemplares (id_titulo_pk, codigo_exemplar_pk) values (?, ?)";

		PreparedStatement prepSt = conexao.prepareStatement(sqlInsert);
		prepSt.setInt(1, titulo.getId_titulo_pk());

		for (String codigo : titulo.getCodigo_exemplar()) {
			prepSt.setString(2, codigo);

			prepSt.execute();
		}

		return true;
	}

	public static boolean testar(Titulo titulo, Connection conexao)
			throws SQLException {
		System.out.println(titulo.getId_titulo_pk() + " : " + titulo.getIsbn());
		for (String codigo : titulo.getCodigo_exemplar()) {
			System.out.println("\t" + codigo);
		}
		System.out.println("\n\n");
		return true;
	}
}
