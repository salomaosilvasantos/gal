package br.ufc.npi.gal.repository.jpa;

import javax.inject.Named;

import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.repository.MetaRepository;

@Named
public class JpaMetaRepository extends GenericRepositoryImpl<Meta> implements
		MetaRepository {

}
