package br.ufc.npi.gal.conexao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class ConfiguraBanco {

	public static Properties getProperties() throws IOException{
		Properties conf = new Properties();
		
		FileInputStream banco_conf = new FileInputStream("fontes/banco_conf.properties");
		conf.load(banco_conf);
		
		banco_conf.close();
		
		return conf;
	}
}
