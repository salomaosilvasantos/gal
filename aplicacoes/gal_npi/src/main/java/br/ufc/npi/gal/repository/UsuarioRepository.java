package br.ufc.npi.gal.repository;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.repository.GenericRepository;

public interface UsuarioRepository extends GenericRepository<Usuario>{
	
	public abstract Usuario getUsuarioByLogin(String login);

}
