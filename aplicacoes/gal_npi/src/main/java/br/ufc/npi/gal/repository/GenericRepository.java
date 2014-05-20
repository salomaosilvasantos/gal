package br.ufc.npi.gal.repository;


public interface GenericRepository<T> {
	
	public abstract void adicionar(T entity);
	
	public abstract void atualizar(T entity);

	public abstract void excluir(T entity);
	
	public abstract T buscar(Object id);
}
