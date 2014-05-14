package br.ufc.npi.gal.repository;


import java.util.List;

import br.ufc.npi.gal.model.Disciplina;

public interface DisciplinaRepository {

	public Disciplina findById(Integer id);
	
	public List<Disciplina> getDisciplinaList();
	
	public void deleteDisciplina(Integer id);
	
	public void updateDisciplina(Disciplina disciplina);
	
	public Disciplina pesquisarDisciplina(String codigoDisciplina, String nome);
	
	public void save(Disciplina disciplina);
	
	public abstract List<Disciplina> findByCod(String codigoDisciplina);
}
