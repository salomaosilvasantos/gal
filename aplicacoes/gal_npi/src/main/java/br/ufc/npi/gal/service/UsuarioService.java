package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Usuario;

public interface UsuarioService extends GenericService<Usuario>{
	
	public abstract Usuario getUsuarioByLogin(String login);
		
}
