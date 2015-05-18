package br.ufc.npi.gal.repository;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.model.Usuario;

public interface UsuarioRepository extends GenericRepository<Usuario>{
	
	public abstract Usuario getUsuarioByLogin(String login);

}
