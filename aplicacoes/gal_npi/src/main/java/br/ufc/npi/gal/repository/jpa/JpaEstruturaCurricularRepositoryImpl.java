package br.ufc.npi.gal.repository.jpa;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.repository.EStruturaCurricularRepository;

public class JpaEstruturaCurricularRepositoryImpl extends GenericRepositoryImpl<EstruturaCurricular> implements EStruturaCurricularRepository{

	public JpaEstruturaCurricularRepositoryImpl() {
		this.persistentClass = EstruturaCurricular.class;
	}

}
