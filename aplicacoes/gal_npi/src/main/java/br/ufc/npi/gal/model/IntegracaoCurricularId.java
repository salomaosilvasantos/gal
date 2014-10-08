package br.ufc.npi.gal.model;

import java.io.Serializable;


public class IntegracaoCurricularId implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private EstruturaCurricular estruturaCurricular;
	private Disciplina disciplina;
	
	
	
	
	public EstruturaCurricular getEstruturaCurricular() {
		return estruturaCurricular;
	}
	public void setEstruturaCurricular(EstruturaCurricular estruturaCurricular) {
		this.estruturaCurricular = estruturaCurricular;
	}
	public Disciplina getDisciplina() {
		return disciplina;
	}
	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public int hashCode() {
		return estruturaCurricular.hashCode()+disciplina.hashCode();
	}
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof IntegracaoCurricularId){
			IntegracaoCurricularId integracaoId = (IntegracaoCurricularId) obj;
			return integracaoId.disciplina.equals(disciplina) && integracaoId.estruturaCurricular.equals(estruturaCurricular);
		}	
		return false;	
	}
}
