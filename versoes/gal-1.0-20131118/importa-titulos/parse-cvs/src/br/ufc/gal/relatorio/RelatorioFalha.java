package br.ufc.gal.relatorio;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class RelatorioFalha {

	private static String diretorio = "relatorios/";
	public static File arquivo = new File(diretorio,
			"Titulos inconsistentes.txt");

	public static void gravar(String texto) {
		FileWriter escrever;
		PrintWriter printer = null;

		if (!arquivo.exists()) {
			try {
				arquivo.createNewFile();
			} catch (IOException e) {
	
				e.printStackTrace();
			}
		}
		try {
			escrever = new FileWriter(arquivo, true);
			printer = new PrintWriter(escrever);
			printer.println(texto);
			printer.flush();
		} catch (IOException e) {
	
			e.printStackTrace();
		} finally {
			printer.close();
		}
	}
}
