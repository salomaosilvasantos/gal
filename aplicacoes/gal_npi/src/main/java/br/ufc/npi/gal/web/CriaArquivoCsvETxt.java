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
		BufferedWriter bufferWrite = null;
	
			file = new File(nomeArquivo);
			bufferWrite = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "Unicode"));

			return bufferWrite;

	}

	public void fechaFile(BufferedWriter bufferWrite) throws IOException {
		// Fechamos o buffer
		
			bufferWrite.close();
		

	}

	public void escreveFile(BufferedWriter bufferWrite, String linha) throws IOException {
		// Escrita dos dados da tabela
		
			bufferWrite.write(linha + "\n");
	}
}