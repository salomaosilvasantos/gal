package ufc.quixada;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Main {

	public static void main(String[] args) {
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
			
				// Este comentário abaixo serviu de báse para a resolução do
				// problema.
				/*
				 * Se entendi direito a partir daqui teremos lido um arquivo.
				 * Neste arquivo teremos as informações de uma disciplinas e
				 * queremos os dados da bibliografia desta disciplina. O objeto
				 * app tem um atributo "disc" com visibilidade default, esse
				 * atributo é do tipo Disciplina e contem essas informações que
				 * queremos. Mas esta classe não possui o método get para o
				 * atributo "String biblio", que é a informação que precisamos,
				 * apenas o método toString().
				 * 
				 * Optando por adicionar o método get, poderemos manipular as
				 * informações da bibliografia mais facilmente. As informações
				 * estão separadas por "\n", e no tratamento poderemos tratar os
				 * dados em dois vetores. utilizando a String
				 * "Bibliografia Básica:" como flag para inicio do primeiro
				 * vetor de String que contém os dados da bibliografia básica. A
				 * String "Bibliografia Complementar:" será usada para indicar o
				 * inicio do preenchimento do segundo vetor,que representará a
				 * bibliografia complementar.
				 * 
				 * Em cada posição do vetor, será inserida uma linha. E cada
				 * linha representa um titulo. Com isso podemos realizar a
				 * persistencia e o mais que for preciso.
				 */

			}
		}
		// Realizando "testes visuais". :)
		for (int i = 0; i < disciplinas.size(); i++) {
			System.out.print("\n\n*********************\t");
			System.out.print(disciplinas.get(i).nome);
			System.out.println("\t*********************\n");
			System.out
					.println("\t********************* BIBLIOGRAFIA COMPLEMENTAR\n");
			for (int j = 0; j < disciplinas.get(i).complementar.size(); j++) {

				System.out.println(disciplinas.get(i).complementar.get(j));

			}
			System.out
					.println("\n\t********************* BIBLIOGRAFIA BÁSICA\n");
			for (int j = 0; j < disciplinas.get(i).basica.size(); j++) {
				System.out.println(disciplinas.get(i).basica.get(j));

			}
			System.out.print("\n\n*********************\t");
			System.out.print(disciplinas.get(i).nome);
			System.out.println("\t*********************\n\n");
		}

		// Proxima etapa. Persistir os dados da lista.
		// Proxima etapa. Persistir os dados da lista.
		
		ListaTitulos listaTitulos = new ListaTitulos();
		ListaTitulos.separarTitulosComESemISBN(disciplinas);
		listaTitulos.listar();
		
	}

}
