package br.ufc.npi.gal.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

@Entity
@Table(name = "curso")
public class Curso implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_crs")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotNull(message = "Campo obrigatório")
	@Column(name = "cod_c")
	@NumberFormat(style = Style.NUMBER)
	private Integer codigo;

	@NotEmpty(message = "Campo obrigatório")
	@Column(name = "nome_c")
	@Pattern(regexp = "[a-zA-Z\\sà-ùÀ-Ù]{0,}", message = "O campo Nome não pode possuir caracteres especiais ou números.")
	private String nome;

	@NotEmpty(message = "Campo obrigatório")
	@Column(name = "sigla")
	@Pattern(regexp = "[a-zA-Z]{0,}", message = "O campo sigla não pode possuir caracteres especiais ou números.")
	@Size(min = 2, max = 3, message = "A sigla deve conter entre 2 e 3 caracteres")
	private String sigla;

	@OneToMany(mappedBy = "curso", targetEntity = EstruturaCurricular.class)
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

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Curso) {
			Curso other = (Curso) obj;
			if (other != null && other.getId() != null && this.id != null
					&& other.getId().equals(this.id)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String toString() {
		return "Curso [codigo=" + codigo + ", nome=" + nome + ", sigla="
				+ sigla + "]";
	}
}
