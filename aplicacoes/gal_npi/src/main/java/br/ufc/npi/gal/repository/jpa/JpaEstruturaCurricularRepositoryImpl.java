package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Named;
import br.ufc.npi.gal.enumeration.QueryType;
import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.repository.EstruturaCurricularRepository;

@Named
public class JpaEstruturaCurricularRepositoryImpl extends GenericRepositoryImpl<EstruturaCurricular> implements EstruturaCurricularRepository{

	@Override
	public EstruturaCurricular getOutraEstruturaCurricularByAnoSemestre(Integer id, String anoSemestre) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("ano_semestre", anoSemestre);
		params.put("id_curso", id);
		List<EstruturaCurricular> result = find(QueryType.JPQL,"from EstruturaCurricular where id_curso = :id_curso and ano_semestre = :ano_semestre", params);
		if(result != null && !result.isEmpty()){
			return result.get(0);
		}
		return null;
	}
}
