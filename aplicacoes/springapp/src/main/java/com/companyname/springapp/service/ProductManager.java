package com.companyname.springapp.service;

import java.io.Serializable;
import java.util.List;

import com.companyname.springapp.domain.Disciplina;


public interface ProductManager extends Serializable {
    
    public List<Disciplina> getDisciplinas();
    
    public void deleteDisciplina(Integer id);
    
    public Disciplina findById(Integer id);

    public void updateDisciplina(Disciplina disciplina);

    public Disciplina pesquisar(String cod, String nome);
    
    public void inserir(Disciplina disciplina);
    
    public abstract List<Disciplina> findByCod(String cod);
}