package br.ufc.npi.gal.conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.junit.Test;

public class ConexaoTeste {

	String sqlInsert = "insert into titulos (isbn, nome_titulo, tipo_titulo) values (?, ?, ?)";
	@Test
	public void testConectar() {
		Conexao c = Conexao.getInstance();
		try {
			Connection con = c.conectar();
			
			PreparedStatement p = con.prepareStatement(sqlInsert);
			p.setString(1, "Françoes da Sílva Pereira");
			p.setString(2, "Patatí Patatá");
			p.setString(3, "maçã ê ó");
			
			p.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
