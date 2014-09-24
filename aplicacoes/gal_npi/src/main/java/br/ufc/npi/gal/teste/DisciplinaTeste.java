package br.ufc.npi.gal.teste;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import junit.framework.Assert;

import org.junit.Test;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import br.ufc.npi.gal.model.Disciplina;

public class DisciplinaTeste {

	private Validator createValidator() {
		LocalValidatorFactoryBean localValidatorFactoryBean = new LocalValidatorFactoryBean();
		localValidatorFactoryBean.afterPropertiesSet();
		return localValidatorFactoryBean;
	}

	@Test
	public void testeNomeVazio() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("");
		disciplina.setCodigo("QXD002");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violacao = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violacao.getMessage(), "Campo obrigatório");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");
	
	}
		
	@Test
	public void testeNomeComSeisEspacosNaoDeveriaPassar() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("      ");
		disciplina.setCodigo("QXD002");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		
	
	}
	
	@Test
	public void testeNomeComCincoCaracteres() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Geren");
		disciplina.setCodigo("QXD002");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violacao = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violacao.getMessage(), "O nome deve ter no mínimo 6 caracteres");
		Assert.assertEquals(violacao.getPropertyPath().toString(), "nome");
	
	}
	
	@Test
	public void testeNomeComCaractereEspecial() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerenci@ de Projetos");
		disciplina.setCodigo("QXD002");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "O campo Nome não pode possuir caracteres especiais ou números.");

	}
	
	@Test
	public void testeNomeComNumero() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerenc7a de Projetos");
		disciplina.setCodigo("QXD002");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "O campo Nome não pode possuir caracteres especiais ou números.");

	}
		

	@Test
	public void testeCodigoVazio(){
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerencia de Projetos");
		disciplina.setCodigo("");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "Campo obrigatório");

	}
	

	@Test
	public void testeCodigoComSeisEspacos() {
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerencia");
		disciplina.setCodigo("      ");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		
	}
	
	@Test
	public void testeCodigoComCaratereEspecial(){
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerencia de Projetos");
		disciplina.setCodigo("QXD%02");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "O campo código não pode possuir caracteres especiais.");

	}
	
	@Test
	public void testeCodigoCom_5_Caracteres(){
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerencia de Projetos");
		disciplina.setCodigo("QXD02");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "O código deve ter entre 6 e 12 caracteres");

	}
	
	@Test
	public void testeCodigoCom_13_Caracteres(){
		Disciplina disciplina = new Disciplina();
		disciplina.setNome("Gerencia de Projetos");
		disciplina.setCodigo("QXD1234567890");
		
		Validator validator = createValidator();
		Set<ConstraintViolation<Disciplina>> constraintViolations = validator
				.validate(disciplina);
		
		Assert.assertEquals(1, constraintViolations.size());
		ConstraintViolation<Disciplina> violation = constraintViolations.iterator()
				.next();
		Assert.assertEquals(violation.getMessage(), "O código deve ter entre 6 e 12 caracteres");

	}
	
}
