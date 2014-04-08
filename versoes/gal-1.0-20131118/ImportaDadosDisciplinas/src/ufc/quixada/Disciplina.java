package ufc.quixada;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class Disciplina {

	public enum Atributo {
		NOME, CODIGO, EMENTA, CARGA, BIBLIO
	};

	public String nome; // ok
	public String codigo; // ok
	public String ementa = ""; // ok
	public String carga; // ok
	public String biblio = "";
	public List<String> basica = new ArrayList<String>();
	public List<String> complementar = new ArrayList<String>();
	public String concat = "";
	public boolean site = false;

	public void concatenar(Atributo atrib, String texto) {
		switch (atrib) {
		case NOME:
			nome = texto;
			break;
		case CODIGO:
			codigo = texto;
			break;
		case EMENTA:
			ementa += texto + " ";
			break;
		case CARGA:
			carga = texto;
			break;
		case BIBLIO:
			biblio += texto + "\n";
			break;
		}
	}

	public void biblioOrder() {
		StringTokenizer str1 = new StringTokenizer(biblio, "\n");

		boolean basic = true; // Determinará se a bibliografia é basica ou complementar.

		String aux;
		String aux2; // Usado apenas para reduzir as verificações, em relação a CASE.
		
		while (str1.hasMoreElements()) {
			aux = str1.nextElement().toString().trim();
			aux2 = aux.toLowerCase();
			
			// Tratando as inconsistencias dos marcadores internos da seção bibliografia.
			// Esses marcadores separam a bibliografia básica da complementar.
			if (aux2.contains("bibliografia básica")) {
				aux = str1.nextElement().toString();
			} else if (aux2.equals("básica")) {
				aux = str1.nextElement().toString();
			} else if (aux2.equals("básica:")) {
				aux = str1.nextElement().toString();
			} else if (aux2.contains("bibliografia complementar")) {
				aux = str1.nextElement().toString();
				basic = false;
			} else if (aux2.equals("complementar")) {
				aux = str1.nextElement().toString();
				basic = false;
			} else if (aux2.equals("complementar:")) {
				aux = str1.nextElement().toString();
				basic = false;
			} else if (aux2.equals("complementar:*")) {
				aux = str1.nextElement().toString();
				basic = false;
			}
			
			// Se o asterisco é o nome, não adiciona. Ver o tratamento interno.
			registrarBibliografia(basic, aux);
		}
		tratarEComercial(basica);
		tratarEComercial(complementar);
	}

	private void registrarBibliografia(boolean basic, String aux) {
		if (basic) {
			registrar(aux, basica);
		} else {
			registrar(aux, complementar);
		}
	}

	private void registrar(String aux, List<String> bib) {
		String aux2 = aux.toLowerCase(); //Usado apenas para reduzir as verificações, em relação a CASE.
		
		// Se tem asterisco no nome remove o asterisco.
		if (aux.contains("*") && aux.length() > 3) {
			bib.add(aux.replaceAll("\\*", ""));
		} else if (aux2.contains("disponível em") || site) {
			//Caso encontre um site. Os dados dos links estão quebrados em várias linhas.
			//System.out.println(aux2);
			site = true;
			concat += aux;
			aux2 += concat.toLowerCase();
			if(aux2.contains("acesso em")){
				bib.add(concat);
				concat = "";
				aux2 = "";
				site = false;
			}
		} else if (!aux.contains("*") && !site) {
			bib.add(aux);
		}
	}
	//Existem partes da bibliografia que tem um "&" no nome.
	//E estãos eparados devido a esse caracrtere, aqui juntamos estas partes.
	private void tratarEComercial(List<String> bib){
		int i = 1;
		int limite = bib.size();
		String aux = "";
		while (i < limite) {
			if (bib.get(i).equals("&")) {
				//Juntar a linha atual com a anterior e a seguinte. E substituir na anterior
				aux = bib.get(i-1) + " " + bib.get(i) + " " + bib.get(i+1);
				bib.set(i-1, aux);
				
				bib.remove(i); // Removendo as duas linhas seguintes.
				bib.remove(i);
				limite = bib.size(); // Atualizando o limite para evitar IndexOutOfBounds
			}
			i++;
		}
	}
	
	
	
	
	
	public String toString() {
		return "NOME: \n" + nome + "\n" + "CÓDIGO: \n" + codigo + "\n"
				+ "EMENTA: \n" + ementa + "\n" + "CH TOTAL: \n" + carga + "\n"
				+ "BIBLIOGRAFIA: \n" + biblio;
	}
	


		

}
