package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Curso;


public interface CursoService {
    
	public void adicionar(Curso curso);
	
	public void atualizar(Curso curso);
	
	public void excluir(Integer id);
	
    public List<Curso> listar();
    
    public Curso findById(Integer id);

    public Curso buscar(String sigla, Integer codigo);
    
    public abstract List<Curso> findByCodigoList(Integer codigo);

}