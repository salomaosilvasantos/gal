package com.companyname.springapp.repository;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.companyname.springapp.domain.Disciplina;

@Repository(value = "disciplinaDao")
@Transactional
public class JPADisciplinaDao implements DisciplinaDao {

	// etiqueta do spring utiliza para carregar o objeto EntityManager
	// responsável por fazer
	// as operações com as entities
	@PersistenceContext
	private EntityManager em;

	public Disciplina findById(Integer id) {

		Disciplina disc = em.find(Disciplina.class, id);
		return disc;
	}

	@SuppressWarnings("unchecked")
	public List<Disciplina> getDisciplinaList() {
		return em.createQuery("select d from Disciplina d order by d.id")
				.getResultList();
	}

	public void deleteDisciplina(Integer id) {

		Disciplina disc = findById(id);
		em.remove(disc);
	}

	public void updateDisciplina(Disciplina disciplina) {

		em.merge(disciplina);
	}

	public void save(Disciplina disciplina) {
		if (disciplina.getId() == null) {

			System.out.println("entrou no save get id");
			em.merge(disciplina);
		} else
			em.persist(disciplina);
	}

	public Disciplina pesquisarDisciplina(String cod, String nome) {

		List<Disciplina> results = null;

		try {
			results = em
					.createQuery("from Disciplina where code =:cod",
							Disciplina.class).setParameter("cod", cod)
					.getResultList();

			System.out.println(results.isEmpty());
		} catch (NoResultException nre) {
			
		}
		if (!(results.isEmpty())){

			System.out.println(results.get(0));
			return results.get(0);
			
		}else return null;
	}
}
