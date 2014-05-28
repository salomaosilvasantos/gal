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
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="disciplinas") 
public class Disciplina {

	@Id
	@Column(name = "id_d")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty(message="Campo Nome não pode ficar vazio")
	@Column(name = "nome")
	@Pattern(regexp="[a-zA-Z\\sà-ùÀ-Ù]{0,}",message="O campo Nome não pode possuir caracteres especiais ou números.")
	@Size(min = 6, max = 40, message = "O nome deve estar entre 6 e 40 caracteres")
	private String nome;
	
	@NotEmpty(message="Campo Código não pode ficar vazio")
	@Column(name = "cod_d")
	@Pattern(regexp="[a-zA-Z\\sà-ùÀ-Ù0-9]{0,}",message="O campo código não pode possuir caracteres especiais.")
	@Size(min = 6, max = 12, message = "O código deve estar entre 6 e 12 caracteres")
	private String codigo;	
	
	@OneToMany(mappedBy = "disciplina", targetEntity = IntegracaoCurricular.class, fetch = FetchType.LAZY)
	private List<IntegracaoCurricular> curriculos;
	
	public Disciplina() {
		this.codigo = "";
		this.nome = "";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getCodigo() {
		return codigo;
	}
	
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Override
	public String toString() {
		return "Disciplina [id=" + id + ", nome=" + nome
				+ ", codigo=" + codigo + "]";
	}
}
