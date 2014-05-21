package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.repository.DisciplinaRepository;

@Repository(value = "disciplina")
@Transactional
public class JpaDisciplinaRepository extends GenericRepositoryImpl<Disciplina> implements DisciplinaRepository {

	public JpaDisciplinaRepository() {
		super();
		this.persistentClass = Disciplina.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Disciplina> listar() {
		return em.createQuery("select d from Disciplina d order by d.id").getResultList();
	}
	
	/**
	 * Verifica se possui disciplina com o mesmo codigo cadastrada, para não ter conflito de id.
	 * */
	public Disciplina buscar(String codigo, String nome) {
		List<Disciplina> results = null;

		try {
			results = em.createQuery("from Disciplina where codigo =:codigo", Disciplina.class).setParameter("codigo", codigo).getResultList();

		} catch (NoResultException nre) {
			
		}
		if (!(results.isEmpty()))
			return results.get(0);
		
		else return null;
	}

	public List<Disciplina> findByCodigo(String codigo) {
		return em.createQuery("from Disciplina where codigo =:codigo", Disciplina.class).setParameter("codigo", codigo).getResultList();
	}
}
