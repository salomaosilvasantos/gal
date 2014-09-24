package br.ufc.npi.gal.repository;

import br.ufc.npi.gal.model.EstruturaCurricular;

public interface EstruturaCurricularRepository extends GenericRepository<EstruturaCurricular> {
	
	public abstract EstruturaCurricular getOutraEstruturaCurricularByAnoSemestre(Integer id, String anoSemestre);
}
