package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Curso;

public interface CursoRepository extends GenericRepository<Curso>{

	public List<Curso> listar();
	
	public Curso buscar(String sigla, String codigo);
	
	public abstract List<Curso> findByCodigo(String codigo);
}
