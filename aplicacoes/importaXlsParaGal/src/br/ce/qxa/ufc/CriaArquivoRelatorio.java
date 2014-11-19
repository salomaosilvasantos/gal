package br.ce.qxa.ufc;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;


public class CriaArquivoRelatorio {	
	
	//Para a execução das duas classes abaixo é importar algumas classes do
	//Java.
	

	public BufferedWriter abreCsvFile(String nomeArquivo){
			//Criação de um buffer para a escrita em uma stream
			BufferedWriter StrW = null;
			try {
				//StrW = new BufferedWriter(new FileWriter(nomeArquivo));
				StrW = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(nomeArquivo),"Unicode"));
				
			} catch (IOException e) {

				e.printStackTrace();
			}
			return StrW;
		
	}
	public void fechaCsvFile(BufferedWriter StrW){
		//Fechamos o buffer
		try {
			StrW.close();
		} catch (IOException e) {

			e.printStackTrace();
		}
	
	}
	public void escreveCsvFile(BufferedWriter StrW, String linha){
		//Escrita dos dados da tabela
		try {
			StrW.write(linha +"\n");
		} catch (IOException e) {

			e.printStackTrace();
		}
	}
}
