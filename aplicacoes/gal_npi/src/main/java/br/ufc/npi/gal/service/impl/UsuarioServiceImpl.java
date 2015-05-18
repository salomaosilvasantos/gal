package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.UsuarioRepository;
import br.ufc.npi.gal.service.UsuarioService;

@Named
public class UsuarioServiceImpl extends GenericServiceImpl<Usuario> implements UsuarioService{

	@Inject
	private UsuarioRepository usuarioRepository;
	
	@Override
	public Usuario getUsuarioByLogin(String login) {
		return usuarioRepository.getUsuarioByLogin(login);
	}

}
