package br.ufc.npi.gal.utilitarios;

import junit.framework.TestCase;

import org.junit.Test;

import br.ufc.npi.gal.pojo.Titulo;

public class TituloFactoryTeste extends TestCase{

	@Test
	public void testCriar() {
		String linha1 = "LAVILLE, Christian; DIONNE, Jean. A construção do saber:   manual de metodologia da pesquisa em ciências humanas.    Porto Alegre: Artmed, Belo Horizonte: Editora UFMG, 2008. 340 p.    ISBN 9788573074895 (broch.).";
		String linha2 = "FURTADO, Elizabeth Sucupira. Qualidade de interação de sistemas e novas abordagens para avaliação.      Curitiba, PR: CRV, 2012. 198 p.    ";
		String linha3 = "";
		String aux = "LAVILLE, Christian; DIONNE, Jean. A construção do saber:   manual de metodologia da pesquisa em ciências humanas.    Porto Alegre: Artmed, Belo Horizonte: Editora UFMG, 2008. 340 p.";
		
		TituloFactory fab = new TituloFactory();
		Titulo t1 = fab.criar(linha1);
		Titulo t2 = fab.criar(linha2);
		Titulo t3 = fab.criar(linha3);
		
		assertEquals(aux, t1.getNome());
		assertEquals(linha2.trim(), t2.getNome());
		assertEquals(linha3.trim(), t3.getNome());
	}

}
