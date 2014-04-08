package br.ufc.gal.utilitarios;

import java.util.ArrayList;
import java.util.List;

import br.ufc.gal.pojo.Titulo;

public class TituloFactory {

	public static List<Titulo> titulosComFalha = new ArrayList<Titulo>();

	/**
	 * Fabrica os titulos a partir de uma String recebida.
	 * 
	 * @param atributos
	 * @return
	 */
	public static Titulo criarTitulo(String atributos) {

		Titulo titulo = null;

		if (atributos != null) {
			titulo = new Titulo();
			titulo.setIsbn(pegarISBN(atributos));
			titulo.setNome(adequacaoNomesTitulos(pegarNome(atributos).replace(" ", "")).replace(" ", ""));
			titulo.setTipo("Fisico");
//			boolean naoPassa = titulo.getIsbn().equals("ERROR");
//			if (naoPassa) {
//				return null;
//			}
		}

		return titulo;
	}
	
	public static String adequacaoNomesTitulos(String nome_titulo){
		
		switch (nome_titulo) {
		case "BASS,Len;CLEMENTS,Paul;KAZMAN,Rick.Softwarearchitectureinpractice.2.ed.Boston,Massachusetts:Addison-WesleyProfessional,2003.560p":
			return "BASS,Len;CLEMENTS,Paul;KAZMAN,Rick.Softwarearchitectureinpractice.2.ed.Boston:Addison-Wesley,2003.528p.";
		case "BEZERRA,E.PrincípiosdeanáliseeprojetodesistemascomUML.2.ed.RiodeJaneiro:Elsevier,2007":
			return "BEZERRA, Eduardo. Princípios de análise e projeto de sistemas com UML.     2. ed. rev. e atual. Rio de Janeiro: Elsevier: Campus, c2007. 369 p.";
		case "BEZERRA,Eduardo.PrincípiosdeanáliseeprojetodesistemascomUML.2.ed.RiodeJaneiro:Campus.2007":
			return "BEZERRA, Eduardo. Princípios de análise e projeto de sistemas com UML.     2. ed. rev. e atual. Rio de Janeiro: Elsevier: Campus, c2007. 369 p.";	
		case "BOOCH,Grady;RUMBAUGH,James;JACOBSON,Ivar.UML:guiadousuário.2.ed.RiodeJaneiro,RJ:Campus,2005":
			return "BOOCH, Grady; RUMBAUGH, James; JACOBSON, Ivar. UML:   guia do usuário.   2. ed. rev. e atual. Rio de Janeiro, RJ: Elsevier, 2005. xviii, 474 p.";
		case "FEDELI,RicardoDaniel;POLLONI,EnricoGiulioFranco;PERES,FernandoEduardo.Introduçãoàciênciadacomputação.2.ed.SãoPaulo,SP:CengageLearning,2009":
			return "FEDELI, Ricardo Daniel.; POLLONI, Enrico Giulio Franco; PERES, Fernando Eduardo. Introdução à ciência da computação.     2. ed. atual. São Paulo, SP: Cengage Learning, 2010. xvi, 250 p.";
		case "GAMMA,E.;HELM,JOHNSON,R.;R.;VLISSIDES,J.Padrõesdeprojeto:soluçõesreutilizáveisdesoftwareorientadoaobjetos.PortoAlegre:Bookman,2000.364p":
			return "GAMMA,Erich.Padrõesdeprojeto:soluçõesreutilizáveisdesoftwareorientadoaobjetos.PortoAlegre:Bookman,2000.364p.";
		case "HENNESSY,JohnL.;PATTERSON,DavidA.Arquiteturadecomputadores:umaabordagemquantitativa.4.ed.RiodeJaneiro:Elsevier,2008":
			return "HENNESSY,JohnL;PATTERSON,DavidA.Arquiteturadecomputadores:umaabordagemquantitativa.4.ed.RiodeJaneiro,RJ:Elsevier,2008.494p.";
		case "PRESSMAN,R.Engenhariadesoftware.6.ed.SãoPaulo:McGraw-Hill,2007":
			return "PRESSMAN,RogerS.Engenhariadesoftware.6.ed.SãoPaulo:McGraw-Hill,2006.720p.";
		case "PRESSMAN,RogerS.Engenhariadesoftware.6.ed.SãoPaulo:MakronBooks,2006":
			return  "PRESSMAN,RogerS.Engenhariadesoftware.6.ed.SãoPaulo:McGraw-Hill,2006.720p.";
		case "SOMMERVILLE,Ian.Engenhariadesoftware.8.ed.SãoPaulo:Addison-Wesley,2007":
			return "SOMMERVILLE, Ian, |d 1951-. Engenharia de software.     8. ed. São Paulo, SP: Pearson/ Prentice Hall, 2007. xiv, 552 p.";
		case "SOMMERVILLE,IAN.EngenhariadeSoftware.8.ed.SãoPaulo:Pearson,2007":
			return "SOMMERVILLE, Ian, |d 1951-. Engenharia de software.     8. ed. São Paulo, SP: Pearson/ Prentice Hall, 2007. xiv, 552 p.";
		case "THAYER,RichardH.Softwarerequirementsengineering.2.ed.California:IEEEComputerSociety,2000.528p":
			return "THAYER,RichardH.;DORFMAN,M.;BAILIN,SidneyC.Softwarerequirementsengineering.2.ed.LosAlamitos,Calif.:IEEEComputerSocietyPress,2000.483p.";
		case "GONÇALVES,Edson.DesenvolvendoaplicaçõesWebcomNetBeansIDE6.RiodeJaneiro:CiênciaModerna,2008.581p.:CD-ROM":
			return "GONÇALVES, Edson. Desenvolvendo aplicações Web com NetBeans IDE 6.      Rio de Janeiro, RJ: Ciência Moderna, 2008. xix, 581 p.";	
		case "WEBER,RaulFernando.Fundamentosdearquiteturadecomputadores.3.ed.PortoAlegre,RS:SagraLuzzatto,2008":
			return "WEBER, Raul Fernando. Fundamentos de arquitetura de computadores.     3. ed. Porto Alegre, RS: Bookman, 2008. 306 p.  (Série Livros Didáticos 8)";	
		case "FEDELI,RicardoDaniel.;POLLONI,EnricoGiulioFranco;PERES,FernandoEduardo.Introduçãoàciênciadacomputação.2.ed.atual.SãoPaulo,SP:CengageLearning,2010.250p.":
			return "FEDELI, Ricardo Daniel.; POLLONI, Enrico Giulio Franco; PERES, Fernando Eduardo. Introdução à ciência da computação.     2. ed. atual. São Paulo, SP: Cengage Learning, 2010. xvi, 250 p.";	
		case "MONTEIRO,M.A.IntroduçãoàOrganizaçãodeComputadores.5.ed.LTC,RiodeJaneiro,2008":
			return "MONTEIRO, Mario A. Introdução à organização de computadores.     5. ed. Rio de Janeiro, RJ: LTC, 2007. xii, 696p.";
		case "STALLINGS,W.Arquiteturaeorganizaçãodecomputadores.5.ed.SãoPaulo:PrenticeHall,2002":
			return "STALLINGS, William. Arquitetura e organização de computadores:   projeto para o desempenho.   5. ed. São Paulo, SP: Prentice Hall, 2006. xix, 786 p.";
		case "TANENBAUM,A.Organizaçãoestruturadadecomputadores.5.ed.SãoPaulo:PearsonPrenticeHall,2007":
			return "TANENBAUM, Andrew S. Organização estruturada de computadores.     5. ed. São Paulo, SP: Prentice Hall, 2007. xii, 449 p.";
		case "MURDOCCA,MilesJ.;HEURING,VincentP.Introduçãoàarquiteturadecomputadores.RiodeJaneiro:Campus,2000.512p.":
			return "MURDOCCA, Miles; HEURING, Vincent P. Introdução a arquitetura de computadores.      Rio de Janeiro, RJ: Elsevier, 2000. xxii, 512p.";
		case "COULOURIS,GeorgeF.;DOLLIMORE,Jean;KINDBERG,Tim.Sistemasdistribuídos:conceitoseprojetos.4.ed.PortoAlegre,RS:Bookman,2007.784p.":
			return "COULOURIS, George F.; DOLLIMORE, Jean; KINDBERG, Tim. Sistemas distribuídos:   conceitos e projeto.   4. ed. Porto Alegre: Bookman, 2007. viii, 784p.";
		case "CHRISSIS,M.B.;KONRAD,M.;SHRUM,S.CMMIforDevelopment®:guidelinesforprocessintegrationandproductimprovement.3.ed.NewYork:AddisonWesley,AddisonWesley,2011":
			return "CHRISSIS,MaryBeth;KONRAD,Mike;SHRUM,Sandy.CMMIforDevelopment®:guidelinesforprocessintegrationandproductimprovement.3.ed.UpperSaddleRiver:Addison-Wesley,2011";	
		default: 
			return nome_titulo;
		}
	}

	public static Titulo adaptarTituloDoBanco(String atributos) {
		Titulo titulo = new Titulo();

		if (atributos != null) {
			titulo.setIsbn(pegarISBN(atributos));
			titulo.setNome(pegarNome(atributos).replace(" ", ""));
			titulo.setTipo("fisico");
//			boolean naoPassa = titulo.getIsbn().equals("ERROR");
	//		if (naoPassa) {
				//return null;	
		//	}
		}
		return titulo;
	}

	private static String pegarISBN(String linha) {
		String isbn = new String("falha");

		// Inconsistencias no CSV
		int inicioIsbn = linha.indexOf("ISBN") + 5;
		int fimIsbn = 0;
		if (linha.indexOf("ISBN")==-1){
			return "falha";
		}
		if (linha.contains("(broch.)")) {
			fimIsbn = linha.indexOf("(broch.)");
		} else if (linha.contains("(enc.)")) {
			fimIsbn = linha.indexOf("(enc.)");
		}else if(linha.contains("(broch)")) {
			fimIsbn = linha.indexOf("(broch)");
		}
		else if(linha.contains("(broch")) {
			fimIsbn = linha.indexOf("(broch");
		}
		else if(linha.contains("Broch")) {
			fimIsbn = linha.indexOf("(Broch");
		}
		else if (linha.contains("[encad.]")) {
			fimIsbn = linha.indexOf("[encad.]");
		} else {
			String aux = linha.substring(inicioIsbn);

			fimIsbn = aux.indexOf(".") + inicioIsbn;
		}

		// Ap�s tratar asincosistencias do CSV.
		if (inicioIsbn > fimIsbn) {
			Titulo tituloFail = new Titulo();
			tituloFail.setNome(linha);
			titulosComFalha.add(tituloFail);
			isbn=isbn.replace("-", "");
			isbn=isbn.replace(" ", "");
			return "falha"; // padr�o para isbn errado.
		}

		isbn = linha.substring(inicioIsbn, fimIsbn);
		isbn=isbn.replace("-", "");
		isbn=isbn.replace(" ", "");
		return isbn;
	}

	private static String pegarNome(String linha) {
		String nome = "";
		int fimNome;
		if (linha.contains("ISBN")) {
			fimNome = linha.indexOf("ISBN");
		} else
			fimNome = linha.length() - 1;

		nome = linha.substring(0, fimNome).replace(" ", "");
		return nome;
	}
}
