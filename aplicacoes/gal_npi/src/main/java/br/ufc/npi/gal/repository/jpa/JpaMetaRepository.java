package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.repository.MetaRepository;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class JpaMetaRepository extends JpaGenericRepositoryImpl<Meta> implements
		MetaRepository {

	@Override
	public List<Meta> getMeta() {
	
		return find(QueryType.JPQL, "from Meta order by id",null);
		
	}

}
