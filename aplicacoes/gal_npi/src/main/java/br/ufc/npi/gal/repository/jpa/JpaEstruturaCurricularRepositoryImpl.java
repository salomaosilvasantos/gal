package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.repository.EstruturaCurricularRepository;


@Repository("estruturaCurricular")
@Transactional
public class JpaEstruturaCurricularRepositoryImpl extends GenericRepositoryImpl<EstruturaCurricular> implements EstruturaCurricularRepository{

	public JpaEstruturaCurricularRepositoryImpl() {
		super();
		this.persistentClass = EstruturaCurricular.class;
	}

	@SuppressWarnings("unchecked")
	public List<EstruturaCurricular> listar() {
		return em.createQuery("select ec from EstruturaCurricular ec").getResultList();
	}
	

}
