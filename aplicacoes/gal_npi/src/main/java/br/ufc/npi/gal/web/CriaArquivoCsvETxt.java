package br.ufc.npi.gal.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;


public class CriaArquivoCsvETxt {
	
	
	// Para a execução das duas classes abaixo é importar algumas classes do
	// Java.
	private File file;

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public BufferedWriter abreFile(String nomeArquivo) throws UnsupportedEncodingException, FileNotFoundException {
		// Criação de um buffer para a escrita em uma stream
		BufferedWriter StrW = null;
	
			file = new File(nomeArquivo);
			StrW = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "Unicode"));

			return StrW;

	}

	public void fechaFile(BufferedWriter bufferFile) throws IOException {
		// Fechamos o buffer
		
			bufferFile.close();
		

	}

	public void escreveFile(BufferedWriter bufferFile, String linha) throws IOException {
		// Escrita dos dados da tabela
		
			bufferFile.write(linha + "\n");
	}
}