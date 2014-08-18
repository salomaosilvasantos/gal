package br.ufc.npi.gal.model;

import java.io.Serializable;

public class BibliografiaId implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id_disciplina;
	private Integer id_titulo;

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
    
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((id_disciplina == null) ? 0 : id_disciplina.hashCode());
		result = prime * result
				+ ((id_titulo == null) ? 0 : id_titulo.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BibliografiaId other = (BibliografiaId) obj;
		if (id_disciplina == null) {
			if (other.id_disciplina != null)
				return false;
		} else if (!id_disciplina.equals(other.id_disciplina))
			return false;
		if (id_titulo == null) {
			if (other.id_titulo != null)
				return false;
		} else if (!id_titulo.equals(other.id_titulo))
			return false;
		return true;
	}
}
