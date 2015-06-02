package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.repository.TituloRespository;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class TituloRespositoryImpl extends JpaGenericRepositoryImpl<Titulo> implements TituloRespository {

	@Override
	public Titulo getTituloByNome(String nome) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("nome", nome);
		List<Titulo> result = find(QueryType.JPQL, "from Titulo where nome = :nome", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Titulo getTituloByIsbn(String isbn) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("isbn", isbn);
		List<Titulo> result = find(QueryType.JPQL, "from Titulo where isbn = :isbn", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Titulo getOutroTituloByNome(Integer id, String nome) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("nome", nome);
		params.put("id", id);
		List<Titulo> result = find(QueryType.JPQL, "from Titulo where id != :id and nome = :nome", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public Titulo getOutroTituloByIsbn(Integer id, String isbn) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("isbn", isbn);
		params.put("id", id);
		List<Titulo> result = find(QueryType.JPQL, "from Titulo where id != :id and isbn = :isbn", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}


}
