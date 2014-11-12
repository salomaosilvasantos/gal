package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Meta;

public interface MetaService extends GenericService<Meta> {
    
	public abstract List<Meta> getMeta();
	
}