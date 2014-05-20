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
@Table(name="curso") 
public class Curso {

	@Id
	@Column(name = "cod_c")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer cod;

	@NotEmpty(message="Campo Nome não pode ficar vazio")
	@Column(name = "nome_c")
	@Pattern(regexp="[a-zA-Z\\sà-ùÀ-Ù]{0,}",message="O campo Nome não pode possuir caracteres especiais ou números.")
	@Size(min = 6, max = 40, message = "O nome deve estar entre 6 e 40 caracteres")
	private String nome;
	
	@NotEmpty(message="Campo Sigla não pode ficar vazio")
	@Column(name = "sigla")
	@Pattern(regexp="^[a-z\\sA-Z0-9]+",message="O campo sigla não pode possuir caracteres especiais.")
	@Size(min = 2, max = 2, message = "O sigla deve conter 2 caracteres")
	private String sigla;	
	
	public Curso() {
		this.sigla = "";
		this.nome = "";
	}

	public Integer getCod() {
		return cod;
	}

	public void setCod(Integer cod) {
		this.cod = cod;
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
		return "Curso [id=cod=" + cod + ", nome=" + nome
				+ ", sigla=" + sigla + "]";
	}
}
