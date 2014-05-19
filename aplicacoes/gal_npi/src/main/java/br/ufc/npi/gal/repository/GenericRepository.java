package br.ufc.npi.gal.repository;


public interface GenericRepository<T> {
	
	public abstract void save(T entity);
	
	public abstract void update(T entity);

	public abstract void delete(T entity);
	
	public abstract T find(Object id);
}
