package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Meta;
import br.ufc.quixada.npi.service.GenericService;

public interface MetaService extends GenericService<Meta> {
    
	public abstract List<Meta> getMeta();
	
}