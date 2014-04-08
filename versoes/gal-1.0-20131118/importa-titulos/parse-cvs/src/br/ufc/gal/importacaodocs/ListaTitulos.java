package br.ufc.gal.importacaodocs;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import br.ufc.quixada.parse.ParseTitulos;

public class ListaTitulos {

	List<Disciplina> disciplinas = new ArrayList<Disciplina>();

	public ListaTitulos() {
		disciplinas = carregarDisciplinas();
	}

	static List<String> titulosComIsbn = new ArrayList<String>();
	static List<String> titulosSemIsbn = new ArrayList<String>();

	public void separarTitulosComESemISBN(List<Disciplina> disciplinas) {
		int tituloSemIsbn = 0;
		int tituloComIsbn = 0;

		for (int i = 0; i < disciplinas.size(); i++) {
			for (int j = 0; j < disciplinas.get(i).complementar.size(); j++) {
				if (livroTemISBN(disciplinas.get(i).complementar.get(j))) {
					tituloSemIsbn++;
					titulosSemIsbn.add(disciplinas.get(i).complementar.get(j));
				} else {
					tituloComIsbn++;
					titulosComIsbn.add(disciplinas.get(i).complementar.get(j));
				}
			}
		}

		for (int i = 0; i < disciplinas.size(); i++) {
			for (int j = 0; j < disciplinas.get(i).basica.size(); j++) {
				if (livroTemISBN(disciplinas.get(i).basica.get(j))) {
					tituloSemIsbn++;
					titulosSemIsbn.add(disciplinas.get(i).basica.get(j));
				} else {
					tituloComIsbn++;
					titulosComIsbn.add(disciplinas.get(i).basica.get(j));
				}
			}
		}

		System.out.println("Títulos com ISBN: " + tituloComIsbn);
		System.out.println("Títulos sem ISBN: " + tituloSemIsbn);
		System.out.println(titulosComIsbn.size());
		System.out.println(titulosSemIsbn.size());
	}


	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public static List<String> getTitulosComIsbn() {
		return titulosComIsbn;
	}

	public static List<String> getTitulosSemIsbn() {
		return titulosSemIsbn;
	}

	public void listar() {
		ParseTitulos parseTitulos = new ParseTitulos();
		try {
			parseTitulos.ler(titulosComIsbn);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static boolean livroTemISBN(String titulo) {
		if (titulo.toLowerCase().contains("isbn"))
			return false;
		else
			return true;
	}
	
	public List<Disciplina> carregarDisciplinas(){
		File[] lista;
		// old = File folder = new
		// File("/home/camilo/projetos/persistencia/ExtracaoDadosProgramasDisciplinas/res/formatados/xml");
		File folder = new File("res/formatados/xml");
		// Carregando os caminhos dos arquivos.
		lista = folder.listFiles();

		List<Disciplina> disciplinas = new ArrayList<Disciplina>();

		for (int i = 0; i < lista.length; i++) {
			// Excluindo os diretórios...
			if (lista[i].isFile()) {
				ProgramaDOCHandler app = new ProgramaDOCHandler();
				// Envio para parse.
				app.executar(lista[i].getAbsolutePath());

				// Remove as inconsistencias das bibliografias de cada
				// disciplina.
				app.disc.biblioOrder();

				// Adicionar as disciplinas na lista. :)
				disciplinas.add(app.disc);
			
			}
		}
		return disciplinas;
	}

}
