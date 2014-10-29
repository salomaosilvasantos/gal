package br.ufc.npi.gal.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

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

	public BufferedWriter abreFile(String nomeArquivo) {
		// Criação de um buffer para a escrita em uma stream
		BufferedWriter StrW = null;
		try {
			file = new File(nomeArquivo);
			StrW = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "Unicode"));

		} catch (IOException e) {
			e.printStackTrace();
		}
		return StrW;

	}

	public void fechaFile(BufferedWriter bufferFile) {
		// Fechamos o buffer
		try {
			bufferFile.close();
		} catch (IOException e) {
		
			e.printStackTrace();
		}

	}

	public void escreveFile(BufferedWriter bufferFile, String linha) {
		// Escrita dos dados da tabela
		try {
			bufferFile.write(linha + "\n");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}
}
