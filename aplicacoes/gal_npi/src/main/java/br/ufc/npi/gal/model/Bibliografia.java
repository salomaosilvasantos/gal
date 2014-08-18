package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "bibliografias")
@IdClass(BibliografiaId.class)
public class Bibliografia {

	@Id
	@Column(name = "id_disciplina", insertable = false, updatable = false)
	private Integer id_disciplina;

	@Id
	@Column(name = "id_titulo", insertable = false, updatable = false)
	private Integer id_titulo;

	@ManyToOne
	@JoinColumn(name = "id_disciplina")
	@PrimaryKeyJoinColumn(name = "id_disciplina", referencedColumnName = "id_disciplina")
	private Disciplina disciplina;

	@ManyToOne
	@JoinColumn(name = "id_titulo")
	@PrimaryKeyJoinColumn(name = "id_titulo", referencedColumnName = "id_titulo")
	private Titulo titulo;

	@Column(name = "tipo_bibliografia")
	private String tipoBibliografia;

	public Integer getId_disciplina() {
		return id_disciplina;
	}

	public void setId_disciplina(Integer id_disciplina) {
		this.id_disciplina = id_disciplina;
	}

	public Integer getId_titulo() {
		return id_titulo;
	}

	public void setId_titulo(Integer id_titulo) {
		this.id_titulo = id_titulo;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}

	public Titulo getTitulo() {
		return titulo;
	}

	public void setTitulo(Titulo titulo) {
		this.titulo = titulo;
	}

	public String getTipoBibliografia() {
		return tipoBibliografia;
	}

	public void setTipoBibliografia(String tipoBibliografia) {
		this.tipoBibliografia = tipoBibliografia;
	}

	@Override
	public String toString() {
		return "Bibliografia [id_disciplina=" + id_disciplina + ", id_titulo="
				+ id_titulo + ", disciplina=" + disciplina + ", titulo="
				+ titulo + ", tipoBibliografia=" + tipoBibliografia + "]";
	}
	
	
	
	

}
