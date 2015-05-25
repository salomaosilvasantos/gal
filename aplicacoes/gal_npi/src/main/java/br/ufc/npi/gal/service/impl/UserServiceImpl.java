package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.service.UserService;
import br.ufc.quixada.npi.ldap.model.Usuario;
import br.ufc.quixada.npi.ldap.service.UsuarioService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class UserServiceImpl extends GenericServiceImpl<Usuario> implements UserService {
	
	@Inject
	private UsuarioService usuarioService;
	
	@Override
	public Usuario getByCpf(String cpf) {
		return usuarioService.getByCpf(cpf);
	}

}
