package br.ufc.npi.gal.model;

import java.io.Serializable;


public class IntegracaoCurricularId implements Serializable{

	private Integer idDisciplina;
	private Integer idEstruturaCurricular;
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idDisciplina == null) ? 0 : idDisciplina.hashCode());
		result = prime
				* result
				+ ((idEstruturaCurricular == null) ? 0 : idEstruturaCurricular
						.hashCode());
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
		if (idDisciplina == null) {
			if (other.idDisciplina != null)
				return false;
		} else if (!idDisciplina.equals(other.idDisciplina))
			return false;
		if (idEstruturaCurricular == null) {
			if (other.idEstruturaCurricular != null)
				return false;
		} else if (!idEstruturaCurricular.equals(other.idEstruturaCurricular))
			return false;
		return true;
	}
	
}
