package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.UsuarioRepository;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;
@Named
public class UsuarioRepositoryImpl extends JpaGenericRepositoryImpl<Usuario> implements UsuarioRepository{

	@Override
	public Usuario getUsuarioByLogin(String cpf) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cpf", cpf);
		List<Usuario> result = find(QueryType.JPQL, "from Usuario where cpf = :cpf", params);
		if(result != null && !result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

}
