package com.companyname.springapp.repository;


import java.util.List;

import com.companyname.springapp.domain.Disciplina;

public interface DisciplinaDao {

	public Disciplina findById(Integer id);
	
	public List<Disciplina> getDisciplinaList();
	
	public void deleteDisciplina(Integer id);
	
	public void updateDisciplina(Disciplina disciplina);
	
	public Disciplina pesquisarDisciplina(String codigoDisciplina, String nome);
	
	public void save(Disciplina disciplina);
	
	public abstract List<Disciplina> findByCod(String codigoDisciplina);
}
