package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Disciplina;

public interface DisciplinaRepository extends GenericRepository<Disciplina>{

	public List<Disciplina> listar();
	
	public Disciplina buscar(String codigo, String nome);
	
	public abstract List<Disciplina> findByCodigo(String codigo);
}
