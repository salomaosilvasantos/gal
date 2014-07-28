package br.ufc.npi.gal.repository;


import br.ufc.npi.gal.model.Disciplina;

public interface DisciplinaRepository extends GenericRepository<Disciplina> {
	
	public abstract Disciplina getDisciplinaByNome(String nome);
	
	public abstract Disciplina getDisciplinaByCodigo(String codigo);
	
	public abstract Disciplina getOutraDisciplinaByNome(Integer id, String nome);
	
	public abstract Disciplina getOutraDisciplinaByCodigo(Integer id, String codigo);

}
