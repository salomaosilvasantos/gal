package br.ufc.npi.gal.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Curso;

@ContextConfiguration(locations = { "classpath:spring/business-config.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@ActiveProfiles("jpa")
public class CursoServiceTeste {

	@Inject
	private CursoService cursoService;

	@Test
	public void buscarCursoPorId() {

		Curso curso = cursoService.find(Curso.class, 1);
		assertEquals("Sistemas de Informação", curso.getNome());
		assertEquals("SI", curso.getSigla());
	}

	@Test
	public void inserirCurso() {
		Curso curso = new Curso();
		curso.setCodigo(406);
		curso.setNome("Design Digital");
		curso.setSigla("DD");
		cursoService.save(curso);

		assertTrue(cursoService.find(Curso.class).contains(curso));
		cursoService.delete(curso);
	}

	@Test
	@Transactional
	public void atualizaCurso() {
		Curso curso = cursoService.find(Curso.class, 1);
		String old = curso.getNome();
		curso.setNome(old + "2");
		cursoService.update(curso);

		curso = cursoService.find(Curso.class, 1);
		assertEquals(curso.getNome(), "Sistemas de Informação2");

		curso.setNome(old);
		cursoService.update(curso);
	}

	@Test
	public void removerCurso() {
		Curso curso = new Curso();
		curso.setCodigo(405);
		curso.setNome("Engenharia da Computação");
		curso.setSigla("EC");
		cursoService.save(curso);
		assertTrue(cursoService.find(Curso.class).contains(curso));
		cursoService.delete(curso);
		assertFalse(cursoService.find(Curso.class).contains(curso));
	}

}
