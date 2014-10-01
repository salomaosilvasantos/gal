package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.enumeration.QueryType;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.repository.IntegracaoCurricularRepository;

@Named
public class JpaIntegracaoCurricularRepositoryImpl extends GenericRepositoryImpl<IntegracaoCurricular> implements IntegracaoCurricularRepository{

	@Override
	public IntegracaoCurricular getIntegracaoByDoisIds(Integer id_disciplina, Integer id_curriculo) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id_disciplina", id_disciplina);
		params.put("id_curriculo", id_curriculo);
		List<IntegracaoCurricular> result = find(QueryType.JPQL, "from IntegracaoCurricular where id_disciplina = :id_disciplina and id_curriculo = :id_curriculo", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}
}