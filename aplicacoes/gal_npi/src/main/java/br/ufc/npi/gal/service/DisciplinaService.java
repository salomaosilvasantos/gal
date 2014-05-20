package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Disciplina;


public interface DisciplinaService {
    
	public void adicionar(Disciplina disciplina);
	
	public void atualizar(Disciplina disciplina);
	
	public void excluir(Integer id);
	
    public List<Disciplina> listar();    
    
    public Disciplina findById(Integer id);

    public Disciplina buscar(String codigo, String nome);
    
    public abstract List<Disciplina> findByCodigo(String codigo);
}