package br.ufc.npi.gal.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="curso") 
public class Curso {

	@Id
	@Column(name="id_curso")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@NotEmpty(message="Campo Código não pode ficar vazio")
	@Column(name = "cod_c")
	@DecimalMin(value = "1", message="O campo deve conter apenas números")
	private String codigo;

	@NotEmpty(message="Campo Nome não pode ficar vazio")
	@Column(name = "nome_c")
	@Pattern(regexp="[a-zA-Z\\sà-ùÀ-Ù]{0,}",message="O campo Nome não pode possuir caracteres especiais ou números.")
	@Size(min = 6, max = 40, message = "O nome deve estar entre 6 e 40 caracteres")
	private String nome;
	
	@NotEmpty(message="Campo Sigla não pode ficar vazio")
	@Column(name = "sigla")
	@Pattern(regexp="[A-Z]{0,}",message="O campo sigla não pode possuir caracteres especiais ou números, e precisar ser toda em maiúscula.")
	@Size(min = 2, max = 3, message = "O sigla deve conter entre 2 e 3 caracteres")
	private String sigla;	
	
	@OneToMany(mappedBy = "curso", targetEntity = EstruturaCurricular.class, fetch = FetchType.LAZY)
	private List<EstruturaCurricular> curriculos;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public List<EstruturaCurricular> getCurriculos() {
		return curriculos;
	}

	public void setCurriculos(List<EstruturaCurricular> curriculos) {
		this.curriculos = curriculos;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	
	public String getSigla() {
		return sigla;
	}
	
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return "Curso [codigo=" + codigo + ", nome=" + nome
				+ ", sigla=" + sigla + "]";
	}
}