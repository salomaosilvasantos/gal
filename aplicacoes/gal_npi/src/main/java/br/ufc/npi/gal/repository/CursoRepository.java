package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Curso;

public interface CursoRepository extends GenericRepository<Curso>{

	public List<Curso> list();
	
	public Curso pesquisarCurso(String sigla, String nome);
	
	public abstract List<Curso> findByCod(String cod);
}
