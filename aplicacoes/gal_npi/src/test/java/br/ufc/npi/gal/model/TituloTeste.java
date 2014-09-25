package br.ufc.npi.gal.model;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import junit.framework.Assert;

import org.junit.Test;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import br.ufc.npi.gal.model.Titulo;

public class TituloTeste {

	private Validator createValidator() {
		LocalValidatorFactoryBean localValidatorFactoryBean = new LocalValidatorFactoryBean();
		localValidatorFactoryBean.afterPropertiesSet();
		return localValidatorFactoryBean;
	}

	@Test
	public void testeNomeVazio() {
		Titulo titulo = new Titulo();
		titulo.setNome("");
		titulo.setIsbn("1234567890");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violacao.getMessage(), "Campo obrigatório");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");
	}

	@Test
	public void testeISBN10CaracteresComEspaco() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("12345678 9");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());

		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn não pode conter espaços");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBN13CaracteresComEspaco() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("123456 789011");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn não pode conter espaços");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBNCom9Caracteres() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("123456789");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn deve conter 10 ou 13 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBNCom11Caracteres() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("12345678901");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn deve conter 10 ou 13 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBNCom12Caracteres() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("123456789012");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn deve conter 10 ou 13 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBNCom14Caracteres() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("12345678901234");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn deve conter 10 ou 13 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");
	}

	@Test
	public void testeISBNComCaracterEspecial() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("1234%67890");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O campo não pode contar caracteres especiais");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");

	}

	@Test
	public void testeISBNVazio() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);
		
		Assert.assertEquals(1, constraintViolations.size());
		
	}

	@Test
	public void testeISBNCom10Espacos() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("          ");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn não pode conter espaços");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");

	}

	@Test
	public void testeISBNCom13Espacos() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("          ");
		titulo.setTipo("TIPO");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(),
				"O isbn não pode conter espaços");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "isbn");

	}

	@Test
	public void testeTipoVazio() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("1234567890");
		titulo.setTipo("");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Titulo> violacao = constraintViolations.iterator()
				.next();

		Assert.assertEquals(violacao.getMessage(), "Campo obrigatório");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "tipo");
	}

	@Test
	public void testeTipoComEspacoEmBranco() {
		Titulo titulo = new Titulo();
		titulo.setNome("Nome");
		titulo.setIsbn("1234567890");
		titulo.setTipo(" ");
		Validator validator = createValidator();
		Set<ConstraintViolation<Titulo>> constraintViolations = validator
				.validate(titulo);

		Assert.assertEquals(1, constraintViolations.size());

	}
}
