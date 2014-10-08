package br.ufc.gal.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class FactoryConnection implements DataBaseConnection {

	// Esses dados serão inicializados por um arquivo properties
	// no futuro.
	private Connection conexao;
	private String usuario;
	private String senha;
	private String servidor;
	private String porta;
	private String banco;
	private String url;
	
	public FactoryConnection() {
		conexao = null;
		usuario = "postgres";
		senha = "postgres";
		servidor = "localhost";
		porta = "5432";
		banco = "bd_gal";
		
		url = "jdbc:postgres://" + servidor + ":" + porta + "/" + banco;
	}

	@Override
	public Connection conectar() {

		try {
			conexao = DriverManager.getConnection(url, usuario, senha);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conexao;
	}

	@Override
	public void desconectar() {
		try {
			conexao.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
