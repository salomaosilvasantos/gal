package br.ufc.npi.gal.model;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
	@Pattern(regexp="^[a-z\\sA-Z0-9]+",message="O campo código não pode possuir caracteres especiais.")
	@Size(min = 6, max = 12, message = "O código deve estar entre 6 e 12 caracteres")
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
