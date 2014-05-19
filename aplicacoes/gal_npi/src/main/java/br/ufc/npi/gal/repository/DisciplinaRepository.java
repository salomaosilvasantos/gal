package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Disciplina;

public interface DisciplinaRepository extends GenericRepository<Disciplina>{

	public List<Disciplina> list();
	
	public Disciplina pesquisarDisciplina(String codigoDisciplina, String nome);
	
	public abstract List<Disciplina> findByCod(String codigoDisciplina);
}
