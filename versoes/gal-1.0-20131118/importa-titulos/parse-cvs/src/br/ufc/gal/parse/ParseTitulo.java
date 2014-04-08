package br.ufc.gal.parse;

/**
 * Esta classe faz a leitura do CSV e o parse para os Titulos, apenas.
 */
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import au.com.bytecode.opencsv.CSVReader;
import br.ufc.gal.pojo.Titulo;
import br.ufc.gal.relatorio.RelatorioFalha;
import br.ufc.gal.utilitarios.TituloFactory;

public class ParseTitulo {

	private CSVReader leitor = null;
	private FileReader arquivo;
	public ParseTitulo(FileReader arquivo) {
		this.arquivo = arquivo;
	}

	/**
	 * Realiza o parse dos Titulos em uma lista para grava��o no banco.
	 * 
	 * @return uma List de Titulos a partir da leitura do CVS.
	 * @throws IOException
	 *             na leitura do CVS.
	 */
	public List<Titulo> ler() throws IOException {

		List<Titulo> titulos = new ArrayList<Titulo>();
		Titulo titulo;
		List<String> codigo_exemplares;;
		String[] linha;

		leitor = new CSVReader(arquivo);

		// Ler as linhas do CSV procurando uma que contenha o ISBN.
		// Nestas linhas econtramos todas as informa��es necess�rias para
		// Preencher a tabela titulo.
		while ((linha = leitor.readNext()) != null) {
			if (linha[0].contains("ISBN")) {
				// A primeira posi��o dessa linha contem o nome e o ISBN do
				// titulo.
				titulo = TituloFactory.criarTitulo(linha[0]);
				if (titulo != null) {
					
					codigo_exemplares = new ArrayList<String>();
					
					//O codigo do primeiro exemplar esta na linha[3].
					codigo_exemplares.add(linha[3].replaceAll("[\\s\\,]", ""));
					
					//Buscar a quantidade e os c�digos dos outros exemplares, se houver.
					int qtd_exemplares = Integer.valueOf(linha[1].substring(4));
					
					
					for (int i = 1; i < qtd_exemplares; i++) {
						linha = leitor.readNext();
						//remover espa�os e virgulas.
						String codigo = linha[1].replaceAll("[\\s\\,]", "");
						codigo_exemplares.add(codigo);
					}
					titulo.setCodigo_exemplar(codigo_exemplares);
					
					titulos.add(titulo);
				}	
			}else if ( (linha.length >= 3) && (!(linha[0].contains("Universidade Federal do Cear� - Biblioteca Universit�ria"))) && (!(linha[0].contains("Ex. :"))) ){ 
				//Titulos que n�o cont�m ISBN.
				titulo = new Titulo();
				codigo_exemplares = new ArrayList<String>();				
				codigo_exemplares.add(linha[3].replaceAll("[\\s\\,]", ""));
				
				String texto = "\n\n";
				texto += "Titulo n�o possui ISBN: ";
				texto += linha[0];
				texto += "\nExemplares: quantidade " + linha[1].substring(4); 
				texto += ", codigo: ";
				
				//Buscar a quantidade e os c�digos dos outros exemplares, se houver.
				int qtd_exemplares = Integer.valueOf(linha[1].substring(4));
								
				for (int i = 1; i < qtd_exemplares; i++) {
					linha = leitor.readNext();
					//remover espa�os e virgulas.
					String codigo = linha[1].replaceAll("[\\s\\,]", "");
					codigo_exemplares.add(codigo);
				}
				titulo.setCodigo_exemplar(codigo_exemplares);
				
				for(String codigo : codigo_exemplares){
					texto += codigo + ", ";
				}
				RelatorioFalha.gravar(texto);
			}
		}
		return titulos;
	}
}
