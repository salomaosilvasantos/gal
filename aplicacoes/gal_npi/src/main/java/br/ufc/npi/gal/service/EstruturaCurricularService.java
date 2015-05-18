package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.quixada.npi.service.GenericService;

public interface EstruturaCurricularService extends GenericService<EstruturaCurricular> {
	
	public abstract EstruturaCurricular getOutraEstruturaCurricularByAnoSemestre(Integer id, String anoSemestre);
}
