package br.ufc.npi.gal.model;

import java.io.Serializable;


public class BibliografiaId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private Disciplina disciplina;

	
	private Titulo titulo;
	
	

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

	@Override
	public int hashCode() {
		return titulo.hashCode()+disciplina.hashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof BibliografiaId){
			BibliografiaId bibliografiaId = (BibliografiaId) obj;
			return bibliografiaId.disciplina.equals(disciplina) && bibliografiaId.titulo.equals(titulo);
		}
		
		return false;	
	}
}
