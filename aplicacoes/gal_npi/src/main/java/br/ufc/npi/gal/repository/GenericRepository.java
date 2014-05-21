package br.ufc.npi.gal.repository;


public interface GenericRepository<T> {
	
	public abstract void adicionarOuAtualizar(T entity);
	
	public abstract void excluir(T entity);
	
	public abstract T buscar(Object id);
}
