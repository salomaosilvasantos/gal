package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;

@Repository(value = "curso")
@Transactional
public class JpaCursoRepository extends GenericRepositoryImpl<Curso> implements CursoRepository {

	public JpaCursoRepository() {
		super();
		this.persistentClass = Curso.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Curso> listar() {
		return em.createQuery("select c from Curso c order by c.id").getResultList();
	}
	
	/**
	 * Verifica se possui curso com o mesmo codigo cadastrada, para não ter conflito de id.
	 * */
	
	public Curso buscar(String sigla, Integer codigo) {
		List<Curso> results = null;

		try {
			results = em.createQuery("from Curso where codigo =:codigo or sigla =:sigla", Curso.class).setParameter("codigo", codigo).setParameter("sigla", sigla).getResultList();

		} catch (NoResultException nre) {
			
		}
		if (!(results.isEmpty())) {
			return results.get(0);
		}
		
		else {
			return null;
		}
	}
	
	
	public List<Curso> findByCodigo(Integer codigo) {
		return em.createQuery("from Curso where codigo =:codigo", Curso.class).setParameter("codigo", codigo).getResultList();
	}
	
}