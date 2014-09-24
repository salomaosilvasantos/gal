package br.ufc.npi.gal.teste;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import junit.framework.Assert;

import org.junit.Test;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import br.ufc.npi.gal.model.Curso;

public class CursoTeste {

	private Validator createValidator() {
		LocalValidatorFactoryBean localValidatorFactoryBean = new LocalValidatorFactoryBean();
		localValidatorFactoryBean.afterPropertiesSet();
		return localValidatorFactoryBean;
	}

	@Test
	public void testeCodigoNulo() {
		Curso curso = new Curso();
		curso.setCodigo(null);
		curso.setNome("Eng de Software");
		curso.setSigla("ES");
		Validator validator = createValidator();
		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violacao.getMessage(), "Campo obrigatório");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "codigo");
	}

	@Test
	public void testeNomeVazio() {
		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("");
		curso.setSigla("SIS");

		Validator validator = createValidator();
		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(), "Campo obrigatório");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");

	}
	
	@Test
	public void testeNomeComEspacos() {
		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("  ");
		curso.setSigla("SIS");

		Validator validator = createValidator();
		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());

	}
	
	@Test
	public void testeNomeComNumeroNoInicio() {

		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("2Engenharia");
		curso.setSigla("EHG");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo Nome não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");

	}

	@Test
	public void testeNomeComNumeroNoMeio() {

		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("Engenh4ria");
		curso.setSigla("ENG");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo Nome não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");
	}

	@Test
	public void testeNomeComNumeroNoFinal() {
		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("Engenhari4");
		curso.setSigla("ENG");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo Nome não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");

	}

	@Test
	public void testeNomeComCaracterEspecial() {
		Curso curso = new Curso();
		curso.setCodigo(1234);
		curso.setNome("Engenh@ria");
		curso.setSigla("ENG");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo Nome não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");

	}

	

	@Test
	public void testeSiglaCom_4_Caracteres() {
		Curso curso = new Curso();
		curso.setCodigo(403);
		curso.setNome("Eng de software");
		curso.setSigla("ENGS");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"A sigla deve conter entre 2 e 3 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "sigla");

	}

	@Test
	public void testeSiglaCom_1_Caracteres() {
		Curso curso = new Curso();
		curso.setCodigo(403);
		curso.setNome("Eng de software");
		curso.setSigla("E");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"A sigla deve conter entre 2 e 3 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "sigla");

	}

	@Test
	public void testeSiglaComCaracterEspecial() {
		Curso curso = new Curso();
		curso.setCodigo(403);
		curso.setNome("Eng de software");
		curso.setSigla("E#S");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo sigla não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "sigla");

	}
	
	@Test
	public void testeSiglaComEspacosEmBranco() {
		Curso curso = new Curso();
		curso.setCodigo(403);
		curso.setNome("Eng de software");
		curso.setSigla("  ");

		Validator validator = createValidator();

		Set<ConstraintViolation<Curso>> constraintViolations = validator
				.validate(curso);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Curso> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo sigla não pode possuir caracteres especiais ou números.");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "sigla");

	}
}
