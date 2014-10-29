package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.IntegracaoCurricular;

public interface IntegracaoCurricularService extends GenericService<IntegracaoCurricular> {

	IntegracaoCurricular getIntegracaoByDoisIds(Integer idDisciplina, Integer idCurriculo);
}