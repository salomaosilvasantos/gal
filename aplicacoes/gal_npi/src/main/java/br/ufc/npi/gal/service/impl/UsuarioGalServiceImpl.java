package br.ufc.npi.gal.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.service.UsuarioGalService;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.GenericRepository;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class UsuarioGalServiceImpl extends GenericServiceImpl<Usuario> implements UsuarioGalService {

	@Inject
	private GenericRepository<Usuario> usuarioRepository;
	
	@Override
	public Usuario getByCpf(String cpf) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cpf", cpf);
		return usuarioRepository.findFirst(QueryType.JPQL, "select u from Usuario u where cpf = :cpf", params, -1);
	}

}
