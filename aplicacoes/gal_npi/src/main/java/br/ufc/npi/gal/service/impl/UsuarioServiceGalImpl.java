package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.UsuarioRepository;
import br.ufc.npi.gal.service.UsuarioServiceGal;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class UsuarioServiceGalImpl extends GenericServiceImpl<Usuario> implements UsuarioServiceGal{

	@Inject
	private UsuarioRepository usuarioRepository;
	
	@Override
	public Usuario getUsuarioByLogin(String cpf) {
		return usuarioRepository.getUsuarioByLogin(cpf);
	}

}
