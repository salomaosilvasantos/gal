package br.ufc.npi.gal.repository;


import br.ufc.npi.gal.model.Curso;
import br.ufc.quixada.npi.repository.GenericRepository;

public interface CursoRepository extends GenericRepository<Curso> {
	
	public abstract Curso getCursoBySigla(String sigla);
	
	public abstract Curso getCursoByCodigo(Integer codigo);
	
	public abstract Curso getOutroCursoBySigla(Integer id, String sigla);
	
	public abstract Curso getOutroCursoByCodigo(Integer id, Integer codigo);

}
