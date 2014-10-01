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
		params.put("anoSemestre", anoSemestre);
		params.put("id", id);
		List<EstruturaCurricular> result = find(QueryType.JPQL,"from curso where id != :id and anoSemestre = :anoSemestre", params);
		if(result != null && !result.isEmpty()){
			return result.get(0);
		}
		return null;
	}
}
