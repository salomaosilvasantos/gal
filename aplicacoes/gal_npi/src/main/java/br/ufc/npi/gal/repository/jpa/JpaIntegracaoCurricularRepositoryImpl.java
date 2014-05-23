package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.repository.IntegracaoCurricularRepository;

@Repository(value = "integracao_curricular")
@Transactional
public class JpaIntegracaoCurricularRepositoryImpl extends GenericRepositoryImpl<IntegracaoCurricular> implements IntegracaoCurricularRepository{

	@SuppressWarnings("unchecked")
	public List<IntegracaoCurricular> listar() {		
		return em.createQuery("Select ic from IntegracaoCurricular ic").getResultList();
	}

}
