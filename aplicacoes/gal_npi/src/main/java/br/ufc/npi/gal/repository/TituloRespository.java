package br.ufc.npi.gal.repository;

import br.ufc.npi.gal.model.Titulo;

public interface TituloRespository extends GenericRepository<Titulo> {
	
	public abstract Titulo getTituloByNome(String nome);
	
	public abstract Titulo getTituloByIsbn(String isbn);
	
	public abstract Titulo getOutroTituloByNome(Integer id, String nome);
	
	public abstract Titulo getOutroTituloByIsbn(Integer id, String isbn);

}
