package br.ufc.npi.gal.model;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.Pattern;

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
	@Pattern(regexp="^[a-zA-Z0-9]+",message="Não pode possuir caracteres especiais")
	private String nome;
	
	@NotEmpty(message="Campo Código não pode ficar vazio")
	@Column(name = "cod_d")
	@Pattern(regexp="^[a-zA-Z0-9]+",message="Não pode possuir caracteres especiais")
	private String codigoDisciplina;	
	
	public Disciplina() {
		this.codigoDisciplina = "";
		this.nome = "";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getCodigoDisciplina() {
		return codigoDisciplina;
	}
	
	public void setCodigoDisciplina(String codigoDisciplina) {
		this.codigoDisciplina = codigoDisciplina;
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
				+ ", codigo Disciplina=" + codigoDisciplina + "]";
	}
}
