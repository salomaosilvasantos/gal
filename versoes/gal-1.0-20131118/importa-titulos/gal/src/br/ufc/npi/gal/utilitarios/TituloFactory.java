package br.ufc.npi.gal.utilitarios;

import br.ufc.npi.gal.pojo.Titulo;

public class TituloFactory {

	public static Titulo criar(String atributos) {

		Titulo titulo = null;

		if (atributos != null) {
			titulo = new Titulo();
			titulo.setIsbn(pegarISBN(atributos));
			titulo.setNome(pegarNome(atributos));
			titulo.setTipo("fisico");
		}

		return titulo;
	}

	private static String pegarISBN(String atributos) {
		String isbn = "";

		int inicioIsbn = 0;
		int fimIsbn = 0;

		// Tratar as inconsistencias do CSV.
		if (atributos.contains("ISBN")) {
			inicioIsbn = atributos.indexOf("ISBN") + 5;
			
			if (atributos.contains("(broch.)")) {
				fimIsbn = atributos.indexOf("(broch.)");
			} else if (atributos.contains("(enc.)")) {
				fimIsbn = atributos.indexOf("(enc.)");
			} else if (atributos.contains("[encad.]")) {
				fimIsbn = atributos.indexOf("[encad.]");
			}else {
				fimIsbn = atributos.length() - 1;
			}
		}

		if (fimIsbn == 0) {
			return isbn;
		}

		isbn = atributos.substring(inicioIsbn, fimIsbn).replaceAll(" ", "");

		return isbn;
	}

	private static String pegarNome(String atributos) {
		String nome = "";

		int fimNome = atributos.length();

		if (atributos.contains("ISBN")) {
			fimNome = atributos.indexOf("ISBN");
		}

		nome = atributos.substring(0, fimNome).trim();

		return nome;
	}
}
