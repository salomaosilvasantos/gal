package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Curso;

public interface CursoRepository extends GenericRepository<Curso>{

	public List<Curso> listar();
	
	public Curso buscar(String sigla, Integer codigo);
	
	public abstract List<Curso> findByCodigo(Integer codigo);
}
