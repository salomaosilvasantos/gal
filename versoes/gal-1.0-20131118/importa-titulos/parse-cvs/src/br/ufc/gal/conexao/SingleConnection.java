package br.ufc.gal.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SingleConnection implements DataBaseConnection{

	public static SingleConnection instanceSingleConnection = null;
	
	//Esses dados ser�o inicializados por um arquivo properties
	//no futuro.
	private Connection conexao = null;
	private String usuario;
	private String senha;
	
	private String url;
	
	private SingleConnection(){
		
		usuario = "postgres";
		senha = "postgres";
	
		
		//url = "jdbc:postgres://" + servidor + ":" + porta + "/" + banco;
		url = "jdbc:postgresql://localhost:5432/bd_gal";
	}
	
	public static SingleConnection getInstance(){
		
		if(instanceSingleConnection == null){
			instanceSingleConnection = new SingleConnection();
		}
		
		return instanceSingleConnection;
	}
	
	@Override
	public Connection conectar(){
		
		try {
			conexao = DriverManager.getConnection(url, usuario, senha);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conexao;
	}
	
	@Override
	public void desconectar (){
		
		try {
			conexao.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
