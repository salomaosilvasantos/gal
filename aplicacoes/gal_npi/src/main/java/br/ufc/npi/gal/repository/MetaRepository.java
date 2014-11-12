package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Meta;

public interface MetaRepository extends GenericRepository<Meta> {
	
	public abstract List<Meta> getMeta();

}
