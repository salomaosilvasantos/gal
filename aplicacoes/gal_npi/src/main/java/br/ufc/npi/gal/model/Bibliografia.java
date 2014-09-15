package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "bibliografias")
@IdClass(BibliografiaId.class)
public class Bibliografia {

	@Id
	@ManyToOne
	@JoinColumn(name="id_disciplina")
	private Disciplina disciplina;

	@Id
	@ManyToOne
	@JoinColumn(name = "id_titulo")
	private Titulo titulo;

	@Column(name = "tipo_bibliografia")
	private String tipoBibliografia;

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
		
		 return "Bibliografia [id_disciplina=" + disciplina +
		 ", id_titulo="
		 + titulo + ", disciplina=" + getDisciplina() + ", titulo="
		 + getTitulo() + ", tipoBibliografia=" + tipoBibliografia + "]";
	}
}
