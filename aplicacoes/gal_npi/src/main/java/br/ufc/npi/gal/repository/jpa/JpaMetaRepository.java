package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.enumeration.QueryType;
import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.repository.MetaRepository;

@Named
public class JpaMetaRepository extends GenericRepositoryImpl<Meta> implements
		MetaRepository {

	@Override
	public List<Meta> getMeta() {
	
		return find(QueryType.JPQL, "from Meta order by id",null);
		
	}

}
