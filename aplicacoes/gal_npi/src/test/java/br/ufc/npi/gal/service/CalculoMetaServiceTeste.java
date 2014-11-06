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

	@Test
	public void testeUmaComplementarESeisBasicas100Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 1);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(16.6, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeComplementarUmaDisciplina() {

		Titulo titulo = tituloService.find(Titulo.class, 3);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(2, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeBasicaCincoDisciplinas100Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 2);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(16.6, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeComplementarDuasDisciplinas() {

		Titulo titulo = tituloService.find(Titulo.class, 8);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(4, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeLivroNaoAlocadoABibliografia() {

		Titulo titulo = tituloService.find(Titulo.class, 11);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(0, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeComplementaresSemExemplarDoisSemestresParesEImpares() {

		Titulo titulo = tituloService.find(Titulo.class, 689);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(4, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

	@Test
	public void testeBasicaSemExemplarCom20Alunos() {

		Titulo titulo = tituloService.find(Titulo.class, 588);

		List<Titulo> titulos = new ArrayList<Titulo>();
		titulos.add(titulo);

		List<ResultadoCalculo> resultado = calculadorMeta.calcular(titulos);

		assertEquals(3.3, resultado.get(0).getMetaCalculada().calcular(), 0.0);
	}

}
