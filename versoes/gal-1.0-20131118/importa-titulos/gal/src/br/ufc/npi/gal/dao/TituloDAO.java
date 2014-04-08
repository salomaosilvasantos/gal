package br.ufc.npi.gal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufc.npi.gal.pojo.Titulo;

public class TituloDAO {

	public static boolean cadastrar(Titulo titulo, Connection conexao) throws SQLException {

		String sqlIsert = "insert into titulos (isbn, nome_titulo, tipo_titulo) values (?, ?, ?)";

		PreparedStatement prepSt = conexao.prepareStatement(sqlIsert);
		prepSt.setString(1, titulo.getIsbn());
		prepSt.setString(2, titulo.getNome());
		prepSt.setString(3, titulo.getTipo());

		prepSt.execute();

		return true;
	}
	
	public static List<Titulo> listar(Connection conexao) throws SQLException{
		
		List<Titulo> titulos = new ArrayList<Titulo>();
		Titulo titulo;
		String sqlSelect = "select * from titulos";
		
		PreparedStatement prepSt = conexao.prepareStatement(sqlSelect);
		ResultSet res = prepSt.executeQuery();
		
		while(res.next()){
			titulo = new Titulo();
			titulo.setId_titulo_pk(res.getInt("id_titulo_pk"));
			titulo.setIsbn(res.getString("isbn"));
			
			titulos.add(titulo);
		}
		
		return titulos;
	}
}
