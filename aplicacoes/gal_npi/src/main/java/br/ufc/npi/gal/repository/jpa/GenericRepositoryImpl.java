package br.ufc.npi.gal.repository.jpa;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import br.ufc.npi.gal.repository.GenericRepository;

public class GenericRepositoryImpl<T> implements GenericRepository<T>{

	@PersistenceContext
    protected EntityManager em;
	
	protected Class<T> persistentClass;
	
	@Transactional
	public void save(T entity) {
		this.em.persist(entity);		
	}

	@Transactional
	public void update(T entity) {
		this.em.merge(entity);		
	}

	@Transactional
	public void delete(T entity) {
		em.remove(em.merge(entity));		
	}

	public T find(Object id) {
		return em.find(this.persistentClass, id);
	}

}
