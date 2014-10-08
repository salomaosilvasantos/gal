package br.ufc.gal.conexao;

import java.sql.Connection;

public interface DataBaseConnection {

	public abstract Connection conectar();
	
	public abstract void desconectar();
}
