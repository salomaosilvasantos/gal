package br.ufc.npi.gal.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import java.util.logging.Level;
import java.util.logging.Logger;


public class CriaArquivoCsvETxt {
	private final static Logger LOGGER = Logger.getLogger(CriaArquivoCsvETxt.class.getName());
	
	
	// Para a execução das duas classes abaixo é importar algumas classes do
	// Java.
	private File file;

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public BufferedWriter abreFile(String nomeArquivo) {
		// Criação de um buffer para a escrita em uma stream
		BufferedWriter StrW = null;
		try {
			file = new File(nomeArquivo);
			StrW = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "Unicode"));

		} catch (IOException e) {
			LOGGER.setLevel(Level.INFO);
			LOGGER.severe(e.getMessage());
			
		}
		return StrW;

	}

	public void fechaFile(BufferedWriter strW) {
		// Fechamos o buffer
		try {
			strW.close();
		} catch (IOException e) {
		
			LOGGER.setLevel(Level.INFO);
			LOGGER.severe(e.getMessage());
		}

	}

	public void escreveFile(BufferedWriter strW, String linha) {
		// Escrita dos dados da tabela
		try {
			strW.write(linha + "\n");
		} catch (IOException e) {

			LOGGER.setLevel(Level.INFO);
			LOGGER.severe(e.getMessage());
		}
	}
}
