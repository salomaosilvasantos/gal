package br.ufc.npi.gal.parse;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import au.com.bytecode.opencsv.CSVReader;
import br.ufc.npi.gal.pojo.Titulo;
import br.ufc.npi.gal.utilitarios.TituloFactory;

public class LeitorCSV {

	private CSVReader leitor;
	private String[] linha;
	private List<Titulo> titulosConsistentes;
	private List<Titulo> titulosInconsistentes;
	private List<String> codigo_exemplares;
	//Flags para identificar as linhas do CSV.
	private boolean isTitulo;
	private boolean isCabecalho;
	private boolean isExemplar;

	public LeitorCSV(FileReader arquivo) {
		this.leitor = new CSVReader(arquivo);
		this.titulosConsistentes = new ArrayList<Titulo>();
		this.titulosInconsistentes = new ArrayList<Titulo>();
	}

	public List<Titulo> getTitulosConsistentes() {
		return titulosConsistentes;
	}

	public List<Titulo> getTitulosInconsistentes() {
		return titulosInconsistentes;
	}

	public void ler() throws IOException {

		Titulo titulo;
		String cod_exemplar;

		while ((linha = leitor.readNext()) != null) {
			//Procurar por um titulo consistente.
			isTitulo = linha[0].contains("ISBN");
			isCabecalho = linha[0].contains("Universidade Federal do Ceará - Biblioteca Universitária");
			isExemplar = linha[0].contains("Ex. :");
			
			if (isTitulo) {
				//linha[0] possui o nome do titulo e o isbn dele.
				titulo = TituloFactory.criar(linha[0]);
				codigo_exemplares = new ArrayList<String>();
				
				//Pegar e adicionar o codigo desse primeiro exemplar.
				cod_exemplar = linha[3];
				codigo_exemplares.add(cod_exemplar.replaceAll("[\\s\\,]", ""));//Remover espaços e virgulas.
				
				//Verificar se há mais deum exemplar.
				int qtd_exemplares = Integer.valueOf(linha[1].substring(4));
				
				//Agora ler as proximas linhas, para pegar os codigos dos exemplares deste titulo.
				//Esse laço só será executado se houver mais de 1 exemplar. Um laço condicional, rsrsr.
				for (int i = 1; i < qtd_exemplares; i++) {
					linha = leitor.readNext();
					//remover espaços e virgulas.
					cod_exemplar = linha[1].replaceAll("[\\s\\,]", "");
					codigo_exemplares.add(cod_exemplar);
				}
				titulo.setCodigo_exemplar(codigo_exemplares);
				
				titulosConsistentes.add(titulo);
				
			} else if(linha.length >= 3 && !isCabecalho && !isExemplar){
				//Se não é cabeçalho nem codigo de exemplar, é um possivel titulo, com dados inconsistentes cadastrado.
				titulo = new Titulo();
				codigo_exemplares = new ArrayList<String>();
				
				titulo.setNome(linha[0]);
				titulo.setIsbn("Titulo não possui ISBN");
				
				//Pegar e adicionar o codigo desse primeiro exemplar.
				cod_exemplar = linha[3];
				codigo_exemplares.add(cod_exemplar.replaceAll("[\\s\\,]", ""));//Remover espaços e virgulas.
				
				//Verificar se há mais deum exemplar.
				int qtd_exemplares = Integer.valueOf(linha[1].substring(4));
				
				//Agora ler as proximas linhas, para pegar os codigos dos exemplares deste titulo.
				//Esse laço só será executado se houver mais de 1 exemplar. Um laço condicional, rsrsr2.
				for (int i = 1; i < qtd_exemplares; i++) {
					linha = leitor.readNext();
					//remover espaços e virgulas.
					cod_exemplar = linha[1].replaceAll("[\\s\\,]", "");
					codigo_exemplares.add(cod_exemplar);
				}
				titulo.setCodigo_exemplar(codigo_exemplares);

				titulosInconsistentes.add(titulo);
				
			}
		}
	}
}
