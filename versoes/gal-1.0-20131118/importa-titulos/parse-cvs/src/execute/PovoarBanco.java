package execute;

import br.ufc.gal.parse.ParseAll;
import br.ufc.quixada.parse.ParseAllFromDocs;

public class PovoarBanco {

	public static void main(String[] args) {
		ParseAll parser = new ParseAll();
//		ParseAllFromDocs parseAllFromDocs = new ParseAllFromDocs();
		
		parser.persistir();
//		parseAllFromDocs.persistir();
		System.out.println("Operação realizada");
	}
}
