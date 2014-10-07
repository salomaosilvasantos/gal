package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.repository.IntegracaoCurricularRepository;
import br.ufc.npi.gal.service.IntegracaoCurricularService;

@Named
public class IntegracaoCurricularServiceImpl extends GenericServiceImpl<IntegracaoCurricular> implements IntegracaoCurricularService {
	
	@Inject
	private IntegracaoCurricularRepository integracaoCurricularRepository;
	
	@Override
	public IntegracaoCurricular getIntegracaoByDoisIds(Integer id_disciplina, Integer id_curriculo) {
		return integracaoCurricularRepository.getIntegracao(id_disciplina, id_curriculo);
	}
	
}