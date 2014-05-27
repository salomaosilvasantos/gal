package br.ufc.npi.gal.model;

import java.io.Serializable;


public class IntegracaoCurricularId implements Serializable{

	private Integer id_disciplina;
	private Integer id_curriculo;
	
	
	public Integer getId_disciplina() {
		return id_disciplina;
	}
	public void setId_disciplina(Integer id_disciplina) {
		this.id_disciplina = id_disciplina;
	}
	public Integer getId_curriculo() {
		return id_curriculo;
	}
	public void setId_curriculo(Integer id_curriculo) {
		this.id_curriculo = id_curriculo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((id_curriculo == null) ? 0 : id_curriculo.hashCode());
		result = prime * result
				+ ((id_disciplina == null) ? 0 : id_disciplina.hashCode());
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
		IntegracaoCurricularId other = (IntegracaoCurricularId) obj;
		if (id_curriculo == null) {
			if (other.id_curriculo != null)
				return false;
		} else if (!id_curriculo.equals(other.id_curriculo))
			return false;
		if (id_disciplina == null) {
			if (other.id_disciplina != null)
				return false;
		} else if (!id_disciplina.equals(other.id_disciplina))
			return false;
		return true;
	}
	
}
