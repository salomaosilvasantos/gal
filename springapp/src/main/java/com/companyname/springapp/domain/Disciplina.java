package com.companyname.springapp.domain;

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
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@NotEmpty(message="Campo Nome não pode ficar vazio")
	@Column(name = "nome")
	@Pattern(regexp="^[a-zA-Z0-9]+",message="Não pode possuir caracteres especiais")
	private String nome;
	
	@NotEmpty(message="Campo Código não pode ficar vazio")
	@Column(name = "cod_d")
	@Pattern(regexp="^[a-zA-Z0-9]+",message="Não pode possuir caracteres especiais")
	private String code;	
	
	public Disciplina() {
		this.code = "";
		this.nome = "";
	}

	public String getCode() {
		return code;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public void setCode(String code) {
		this.code = code;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

}
