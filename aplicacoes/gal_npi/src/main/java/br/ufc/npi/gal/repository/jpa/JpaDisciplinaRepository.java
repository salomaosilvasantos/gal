package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.repository.DisciplinaRepository;

@Repository(value = "disciplinaDao")
@Transactional
public class JpaDisciplinaRepository extends GenericRepositoryImpl<Disciplina> implements DisciplinaRepository {

	public JpaDisciplinaRepository() {
		super();
		this.persistentClass = Disciplina.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Disciplina> list() {
		return em.createQuery("select d from Disciplina d order by d.id")
				.getResultList();
	}
	
	/**
	 * Verifica se possui disciplina com o mesmo codigo cadastrada, para não ter conflito de id.
	 * */
	public Disciplina pesquisarDisciplina(String cod, String nome) {
		List<Disciplina> results = null;

		try {
			results = em
					.createQuery("from Disciplina where codigoDisciplina =:cod",
							Disciplina.class).setParameter("cod", cod)
					.getResultList();

		} catch (NoResultException nre) {
			
		}
		if (!(results.isEmpty()))
			return results.get(0);
		
		else return null;
	}

	public List<Disciplina> findByCod(String codigoDisciplina) {
		return em.createQuery("from Disciplina where cod_d =:cod", Disciplina.class).setParameter("cod", codigoDisciplina).getResultList();
	}
}
