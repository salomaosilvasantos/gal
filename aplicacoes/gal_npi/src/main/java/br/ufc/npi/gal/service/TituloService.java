package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.quixada.npi.service.GenericService;


public interface TituloService extends GenericService<Titulo> {
	
	public abstract Titulo getTituloByNome(String nome);
	
	public abstract Titulo getTituloByIsbn(String isbn);
	
	public abstract Titulo getOutroTituloByNome(Integer id, String nome);
	
	public abstract Titulo getOutroTituloByIsbn(Integer id, String isbn);

}
