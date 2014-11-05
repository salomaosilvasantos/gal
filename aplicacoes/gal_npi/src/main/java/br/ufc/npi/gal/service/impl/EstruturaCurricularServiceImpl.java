package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.repository.EstruturaCurricularRepository;
import br.ufc.npi.gal.service.EstruturaCurricularService;


@Named
public class EstruturaCurricularServiceImpl extends GenericServiceImpl<EstruturaCurricular> implements EstruturaCurricularService{

	@Inject
	private EstruturaCurricularRepository estruturaRepository;
	@Override
	public EstruturaCurricular getOutraEstruturaCurricularByAnoSemestre(
			Integer id, String anoSemestre) {
		
		return estruturaRepository.getOutraEstruturaCurricularByAnoSemestre(id, anoSemestre);
	}
	
}
