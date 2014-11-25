package br.ufc.npi.gal.service;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.model.Titulo;

@ContextConfiguration(locations = { "classpath:spring/business-config.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@ActiveProfiles("jpa")
@Transactional
public class CalculoMetaServiceTeste {

	@Inject
	private CalculadorMeta calculadorMeta;

	@Inject
	private TituloService tituloService;
	
	@Inject
	private MetaService metaService;

	@Test
	public void testeUmaBiliografiaComplementarESeisBasicasCom100Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 1);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);
		
		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);
		
		
		assertEquals(16.6666, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0001);
	}

	@Test
	public void testeBibliografiaComplementarComUmaDisciplina() {

		Titulo titulo = tituloService.find(Titulo.class, 3);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		Meta meta = metaService.find(Meta.class, 1);
		
		System.err.println("Indice BASICA "+meta.getIndiceCalculoBasica());
		System.err.println("Indice COMPLEMENTAR "+meta.getIndiceCalculoBasica());
		
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);
		System.err.println("Indice BASICA "+resultado.get(0).getMetasCalculadas().get(0).getCalculo());
		assertEquals(2, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0);
	} 

	@Test
	public void testeBibliografiaBasicaComCincoDisciplinasE100Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 2);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);

		assertEquals(16.6666, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0001);
	}

	@Test
	public void testeBibliografiaComplementarComDuasDisciplinas() {

		Titulo titulo = tituloService.find(Titulo.class, 8);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);
		
		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);

		assertEquals(4, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0);
	}

	@Test
	public void testeLivroNaoAlocadoABibliografia() {

		Titulo titulo = tituloService.find(Titulo.class, 11);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);

		assertEquals(0, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0);
	}

	@Test
	public void testeBibliografiasComplementaresSemExemplaresComDoisSemestresParesEImpares() {

		Titulo titulo = tituloService.find(Titulo.class, 689);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);

		assertEquals(4, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0);
	}

	@Test
	public void testeBibliografiaBasicaSemExemplarCom20Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 588);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		Meta meta = metaService.find(Meta.class, 1);
		List<Meta> metas = new ArrayList<Meta>();
		metas.add(meta);
		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos, metas);

		assertEquals(3.3333, resultado.get(0).getMetasCalculadas().get(0).getCalculo(), 0.0001);
	}

}
