package br.ufc.npi.gal.service;

import java.io.Serializable;
import java.util.List;

import br.ufc.npi.gal.model.Curso;


public interface CursoService extends Serializable {
    
    public List<Curso> getCursos();
    
    public void deleteCurso(Integer cod);
    
    public Curso findByCod(Integer cod);

    public void updateCurso(Curso curso);

    public Curso pesquisar(String sigla, String nome);
    
    public void inserir(Curso curso);
    
    public abstract List<Curso> findByCod(String cod);
}