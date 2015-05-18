package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.enumeration.QueryType;
import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.UsuarioRepository;
@Named
public class UsuarioRepositoryImpl extends GenericRepositoryImpl<Usuario> implements UsuarioRepository{

	@Override
	public Usuario getUsuarioByLogin(String login) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("login", login);
		List<Usuario> result = find(QueryType.JPQL, "from Usuario where login = :login", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

}
