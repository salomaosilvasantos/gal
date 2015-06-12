package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.service.GenericService;

public interface UsuarioServiceGal extends GenericService<Usuario>{
	
	public abstract Usuario getUsuarioByLogin(String cpf);
		
}

