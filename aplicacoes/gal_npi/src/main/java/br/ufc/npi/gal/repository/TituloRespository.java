package br.ufc.npi.gal.repository;

import java.util.List;

import br.ufc.npi.gal.model.Titulo;

public interface TituloRespository extends GenericRepository<Titulo> {
	
	public abstract List<Titulo> listar();
	
	public abstract List<Titulo> findByIsbn(String isbn);
	
	public abstract List<Titulo> findByNome(String nome);

}
