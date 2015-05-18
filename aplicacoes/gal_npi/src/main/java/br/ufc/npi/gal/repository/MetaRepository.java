package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Meta;
import br.ufc.quixada.npi.repository.GenericRepository;

public interface MetaRepository extends GenericRepository<Meta> {
	
	public abstract List<Meta> getMeta();

}
