package com.companyname.springapp.service;

import java.io.Serializable;
import java.util.List;

import com.companyname.springapp.domain.Disciplina;
import com.companyname.springapp.domain.Product;

/*
 * en la camada de servicio hay q hacer una interfaz porque el uso de interfaces implica 
 * que JDK Proxying (una característica del lenguaje Java) puede ser usada para hacer el 
 * servicio transaccional, en lugar de usar CGLIB (una librería de generación de código).
 * */

public interface ProductManager extends Serializable {

    public void increasePrice(int percentage);
    
    public List<Product> getProducts();

    public List<Disciplina> getDisciplinas();
    
    public void deleteDisciplina(Integer id);
    
    public Disciplina findById(Integer id);

    public void updateDisciplina(Disciplina disciplina);

    public Disciplina pesquisar(String cod, String nome);
    
    public void inserir(Disciplina disciplina);
}