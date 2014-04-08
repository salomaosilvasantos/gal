package br.ufc.quixada.parse;

import java.util.ArrayList;
import java.util.List;

import ufc.quixada.Disciplina;
import br.ufc.gal.pojo.Titulo;
import br.ufc.gal.utilitarios.TituloFactory;

public class ParseTitulos {

	/**
	 * @param args
	 */

	public ParseTitulos() {

	}
	
	
	public List<Disciplina> lerDisciplina (List<Disciplina> listaDisciplia) {
		Titulo titulo;
		List<String> nome_titulos = new ArrayList<String>();
		List<Titulo> titulos = new ArrayList<Titulo>();
		for (int i = 0; i < listaDisciplia.size(); i++) {
			for (int j = 0; j < listaDisciplia.get(i).complementar.size(); j++) {
				titulo = TituloFactory.criarTitulo(listaDisciplia.get(i).complementar.get(j));
				boolean tituloDuplicado = false;
				if((!nome_titulos.contains(titulo.getNome()))){
						nome_titulos.add(titulo.getNome());
						for (Titulo titulo2 : titulos) {
							if (titulo2.getIsbn().equals(titulo.getIsbn())){
								tituloDuplicado = true;
								listaDisciplia.get(i).complementar.set(j, titulo2.getNome()+titulo2.getIsbn()+titulo2.getTipo());
							}
						}
						if (!tituloDuplicado) {
							titulos.add(titulo);
//							System.out.println("Título " + (aux) + ":"
//									+ titulo.getNome() + ", " + titulo.getTipo() + ", "
//									+ titulo.getIsbn());
							tituloDuplicado = false;
						}
				  }
				else {
					for (Titulo titulo2 : titulos) {
						if (titulo2.getNome().equals(titulo.getNome())){
							listaDisciplia.get(i).complementar.set(j, titulo2.getNome()+titulo2.getIsbn()+titulo2.getTipo());
						}
					}
				}
			}
		 }
		return listaDisciplia;
	}
	public List<Titulo> ler(List<String> listaTitulosImportados) {
		List<String> nome_titulos = new ArrayList<String>();
		List<Titulo> titulos = new ArrayList<Titulo>();
		Titulo titulo = new Titulo();
		// Ler cada titulo da lista
		// Preencher a tabela titulo.
		for (int i = 0; i < listaTitulosImportados.size(); i++) {
			titulo = TituloFactory.criarTitulo(listaTitulosImportados.get(i));
			boolean tituloDuplicado = false;
			
			if ((titulo != null) && (!nome_titulos.contains(titulo.getNome()))) {
				nome_titulos.add(titulo.getNome());
				for (Titulo titulo2 : titulos) {
					if (titulo2.getIsbn().equals(titulo.getIsbn()))
						tituloDuplicado = true;
				}
				if (!tituloDuplicado) {
					titulos.add(titulo);
//					System.out.println("Título " + (aux) + ":"
//							+ titulo.getNome() + ", " + titulo.getTipo() + ", "
//							+ titulo.getIsbn());
					tituloDuplicado = false;
				}
				

			}

			/*
			 * if (titulo == null) {
			 * System.out.println("***************************************" +
			 * "\nTítulo nulo encontrado!!" +
			 * "\n*******************************************");
			 * System.out.println(listaTitulosImportados.get(i)); } else {
			 * System.out.println(titulo.getNome());
			 * //System.out.println("Título " + (i + 1) + ":" +
			 * titulo.getNome()+ ", " + titulo.getTipo() + ", " +
			 * titulo.getIsbn());
			 * 
			 * }
			 */
		}
		//System.out.println("Número de títulos na lista: "+ titulos.size());
		
		return titulos;
	}

}
