package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class JpaCursoRepository extends JpaGenericRepositoryImpl<Curso> implements CursoRepository {

	@Override
	public Curso getCursoBySigla(String sigla) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sigla", sigla);
		List<Curso> result = find(QueryType.JPQL, "from Curso where sigla = :sigla", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Curso getCursoByCodigo(Integer codigo) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("codigo", codigo);
		List<Curso> result = find(QueryType.JPQL, "from Curso where codigo = :codigo", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Curso getOutroCursoBySigla(Integer id, String sigla) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sigla", sigla);
		params.put("id", id);
		List<Curso> result = find(QueryType.JPQL, "from Curso where id != :id and sigla = :sigla", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Curso getOutroCursoByCodigo(Integer id, Integer codigo) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("codigo", codigo);
		params.put("id", id);
		List<Curso> result = find(QueryType.JPQL, "from Curso where id != :id and codigo = :codigo", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}
	
}