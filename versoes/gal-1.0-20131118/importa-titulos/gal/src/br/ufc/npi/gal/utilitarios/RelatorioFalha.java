package br.ufc.npi.gal.utilitarios;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RelatorioFalha {

	private static String diretorio = "relatorios/";
	public static File arquivo = new File(diretorio,
			"Log_Titulos.txt");

	public static void gravar(String texto) {
		FileWriter escrever;
		PrintWriter printer = null;

		if (!arquivo.exists()) {
			try {
				arquivo.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			escrever = new FileWriter(arquivo, true);
			//Corrigindo falha de encode na gravação do arquivo.
			//printer = new PrintWriter(arquivo, "UTF-8");
			printer = new PrintWriter(escrever);
			printer.println(data() + " : " + texto);
			printer.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			printer.close();
		}
	}
	
	public static String data(){

		Date hoje  = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		
		return sdf.format(hoje);
	}
}
