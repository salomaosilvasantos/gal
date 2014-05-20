package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;

@Repository(value = "cursoDao")
@Transactional
public class CopyOfJpaCursoRepository extends GenericRepositoryImpl<Curso> implements CursoRepository {

	public CopyOfJpaCursoRepository() {
		super();
		this.persistentClass = Curso.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Curso> list() {
		return em.createQuery("select d from Curso d order by d.id")
				.getResultList();
	}
	
	/**
	 * Verifica se possui curso com o mesmo codigo cadastrada, para não ter conflito de id.
	 * */
	public Curso pesquisarCurso(String cod, String nome) {
		List<Curso> results = null;

		try {
			results = em
					.createQuery("from Curso where codigoCurso =:cod",
							Curso.class).setParameter("cod", cod)
					.getResultList();

		} catch (NoResultException nre) {
			
		}
		if (!(results.isEmpty()))
			return results.get(0);
		
		else return null;
	}

	public List<Curso> findByCod(String codigoCurso) {
		return em.createQuery("from Curso where cod_d =:cod", Curso.class).setParameter("cod", codigoCurso).getResultList();
	}
}
