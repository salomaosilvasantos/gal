package br.ufc.npi.gal.conexao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Conexao {
	
	public static Conexao instaceConexao;
	
	private String url = "";
	private String host;
	private String tipoBanco;//Postgres,MySql, Oracle...
	private String banco;//Nome da base de dados.
	private String porta;
	private String usuario;
	private String senha;

	private Connection conexao;
	
	private Properties conf;
	
	private Conexao() {
		try {
			conf = ConfiguraBanco.getProperties();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static Conexao getInstance(){
		if(instaceConexao == null){
			instaceConexao = new Conexao();
		}
		
		return instaceConexao;
	}
	
	public Connection conectar() throws SQLException{
		
		configure();
		
		montarURL();
		
		conexao = DriverManager.getConnection(url, usuario, senha);
		
		return conexao;
	}
	
	public void desconectar() throws SQLException{
		conexao.close();
	}

	private void montarURL() {
		if(tipoBanco.equalsIgnoreCase("postgres")){
			//url = "jdbc:postgresql://localhost:5432/bd_gal
			url += "jdbc:postgresql://";
			url += host;
			url += ":" + porta;
			url += "/"  + banco;
		}else if (tipoBanco.equalsIgnoreCase("mysql")){
			//jdbc:mysql://server/database?characterEncoding=UTF-8
			url += "jdbc:mysql://";
			url += host;
			url += banco;
		}
	}
	
	private void configure(){
		host = conf.getProperty("prop.server.host");
		tipoBanco = conf.getProperty("prop.server.banco");
		banco = conf.getProperty("prop.database.banco");
		porta = conf.getProperty("prop.database.porta");
		usuario = conf.getProperty("prop.database.usuario");
		senha = conf.getProperty("prop.database.senha");
	}
}




