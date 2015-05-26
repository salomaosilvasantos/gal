package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.repository.TituloRespository;
import br.ufc.npi.gal.service.TituloService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class TituloServiceImpl extends GenericServiceImpl<Titulo> implements TituloService {
	
	@Inject
	private TituloRespository tituloRespository;

	@Override
	public Titulo getTituloByNome(String nome) {
		return tituloRespository.getTituloByNome(nome);
	}

	@Override
	public Titulo getTituloByIsbn(String isbn) {
		return tituloRespository.getTituloByIsbn(isbn);
	}

	@Override
	public Titulo getOutroTituloByNome(Integer id, String nome) {
		return tituloRespository.getOutroTituloByNome(id, nome);
	}

	@Override
	public Titulo getOutroTituloByIsbn(Integer id, String isbn) {
		return tituloRespository.getOutroTituloByIsbn(id, isbn);
	}
	

}
