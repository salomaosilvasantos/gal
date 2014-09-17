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

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="titulos")
public class Titulo {
	
	public Titulo() {
		
	}
	
	public Titulo(String nome, String isbn, String tipo) {
		super();
		this.nome = nome;
		this.isbn = isbn;
		this.tipo = tipo;
	}
	
	@Id
	@Column(name="id_t")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="nome_titulo")
	@NotEmpty(message="Campo obrigatório")
	private String nome;
	
	@Pattern.List({
		@Pattern(regexp = "([^\\s]{0,})", message = "O isbn não pode conter espaços"), 
		@Pattern(regexp = "(.){13}|(.){10}", message = "O isbn deve conter 10 ou 13 caracteres"),
		@Pattern(regexp = "[a-zA-Z\\sà-ùÀ-Ù0-9]{0,}", message = "O campo não pode contar caracteres especiais")
	})
	@NotEmpty(message="Campo obrigatório")
	private String isbn;
	
	@Column(name="tipo_titulo")
	@NotEmpty(message="Campo obrigatório")
	private String tipo;
	
	@OneToMany(mappedBy = "titulo", targetEntity = Bibliografia.class, fetch = FetchType.LAZY)
	private List<Bibliografia> bibliografias;
	
	@OneToMany(mappedBy = "titulo", targetEntity = Exemplar.class, fetch = FetchType.LAZY)
	private List<Exemplar> exemplares;
	
	public List<Bibliografia> getBibliografias() {
		return bibliografias;
	}

	public void setBibliografias(List<Bibliografia> bibliografias) {
		this.bibliografias = bibliografias;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	public List<Exemplar> getExemplares() {
		return exemplares;
	}

	public void setExemplares(List<Exemplar> exemplares) {
		this.exemplares = exemplares;
	}

	public int getAcervo() {
		return this.exemplares.size();
	}

	@Override
	public String toString() {
		return "Titulo [id=" + id + ", nome=" + nome + ", tipo=" + tipo + "]";
	}

}
