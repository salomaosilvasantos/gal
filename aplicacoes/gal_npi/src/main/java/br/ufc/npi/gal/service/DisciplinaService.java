package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.quixada.npi.service.GenericService;

public interface DisciplinaService extends GenericService<Disciplina> {
    
	public abstract Disciplina getDisciplinaByNome(String nome);
	
	public abstract Disciplina getDisciplinaByCodigo(String codigo);
	
	public abstract Disciplina getOutraDisciplinaByNome(Integer id, String nome);
	
	public abstract Disciplina getOutraDisciplinaByCodigo(Integer id, String codigo);
	
}